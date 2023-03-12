#!/bin/sh
ln -sf /dev/stdout /dev/console
/usr/sbin/tac_plus -C $CONFIG $FLAGS -l $DEBFILE 2>&1
