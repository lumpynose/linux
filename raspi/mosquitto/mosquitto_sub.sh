#! /bin/sh

passwd=$(cat /usr/local/etc/passwd)

mosquitto_sub -u raspi -P ${passwd} -h raspi-pi4 -t '#'
