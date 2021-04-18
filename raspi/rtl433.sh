#! /bin/sh

passwd=$(cat /usr/local/etc/passwd)

/usr/local/bin/rtl_433 -C customary -F "mqtt://localhost:1883,user=raspi,pass=${passwd}"
