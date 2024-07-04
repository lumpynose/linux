#! /bin/sh

passwd=$(cat /usr/local/etc/passwd)

#    "mqtt://localhost:1883,devices=rtl_433[/model]" > /dev/null

logger -i --tag rtl_433 "Starting rtl_433 to mqtt"

rtl_433 \
    -C customary \
    -F \
    "mqtt://localhost:1883,events=rtl_433[/model]"
