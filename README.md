# Intro
TACACS+ Docker image and docker compose, with config examples.

# Quck start

1. Download latest image from docker.io.

```bash
docker pull azyablov/tac_plus:latest
```

OR run `docker build . -t tac_plus:latest`.

2. Update docker compose up to desirable config, but make sure necessary folder / volumes for `log` and `config` files are created and specified.
In order to follow default path `./config` and `./log` should be created.

```yaml
    volumes:
      - type: bind
        source: ./log
        target: /var/log
      - type: bind
        source: ./config
        target: /etc/tacacs+
        read_only: true
```

3. Put your `tac_plus.conf` and `tacacs_passwords` files into `./config`. Examples in `./config_example` can be used.
If you need to create hash for your users use `openssl passwd -1 -stdin` command.
All the rest can be found in config file comments or / and man pages, but the setup provides bare minumum to run your TACACS+ in 20-30 min.

4. Run docker compose...
```bash
docker-compose up -d
```

... shutdown, if you would not like to use it anymore.
```bash
docker-compose down
```

# Logs 

By default, all logs should be visible via `docker container logs`, but if you want to see accouning logs in a file, 
then remove `accounting file = /dev/stdout` and uncomment `accounting file = /var/log/tac_plus_acct.log` (specify whatever is necessary as per your case).
