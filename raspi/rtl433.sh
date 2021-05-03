#! /bin/sh

passwd=$(cat /usr/local/etc/passwd)

logger -i --tag rtl_433 "Starting rtl_433 to mqtt"
# /usr/local/bin/rtl_433 -C customary -F "mqtt://localhost:1883,user=raspi,pass=${passwd},devices=rtl_433[/id]"
/usr/local/bin/rtl_433 \
    -C customary \
    -F \
    "mqtt://localhost:1883,user=raspi,pass=${passwd},devices=rtl_433[/model]"
