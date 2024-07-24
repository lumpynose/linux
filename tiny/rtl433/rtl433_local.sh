#! /bin/sh

# use to test when compiled and installed from github

# passwd=$(cat /usr/local/etc/passwd)

#    "mqtt://localhost:1883,devices=rtl_433[/model]" > /dev/null

logger -i --tag rtl_433 "Starting rtl_433 to mqtt"

# "mqtt://localhost:1883,events=rtl_433[/model]" > /dev/null
/usr/local/bin/rtl_433 \
    -C customary \

#    -F "mqtt://localhost:1883,events=rtl_433/temperature[/model]" > /dev/null
