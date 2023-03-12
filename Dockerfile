FROM ubuntu:bionic
LABEL maintainer="anton.zyablov@nokia.com"\
    org.label-schema.name="azyablov/tac_plus"\
    org.label-schema.description="tac_plus base image"\
    org.label-schema.vendor="Anton Zyablov, Nokia"\
    org.label-schema.version="0.3"\
    org.label-schema.schema-version="1.0"\
    org.label-schema.docker.cmd="docker run -p 49:49/tcp -v $(pwd)/log:/var/log  -v $(pwd)/config:/etc/tacacs+ -e 'FLAGS=-S -G -t' --name tacp -d rsyslog:latest" 
ARG USER=tacplus
ARG HOME=/home/${USER}
RUN apt-get update && apt-get upgrade -y
RUN apt-get install tacacs+ -y
RUN apt-get clean
RUN useradd -ms /bin/bash ${USER}
RUN cd ${HOME}
WORKDIR ${HOME}
RUN mkdir ${HOME}/bin
RUN chown root:root bin
ENV CONFIG_PATH "/etc/tacacs+"
ENV DEBFILE "/var/log/tac_plus.log"
ENV CONFIG "${CONFIG_PATH}/tac_plus.conf"
VOLUME [ "${CONFIG_PATH}" ]
ADD --chown=root:root tac_start.sh ${HOME}/bin
RUN chmod ug+x ${HOME}/bin/tac_start.sh
EXPOSE 49/tcp
ENTRYPOINT [ "/home/tacplus/bin/tac_start.sh" ]
