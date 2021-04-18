#! /usr/bin/python3

import paho.mqtt.client as mqtt
from prometheus_client import start_http_server
from prometheus_client import Gauge
import datetime

# 433.920MHz

print(datetime.datetime.now())

def get_passwd(passwd_file):
    file = open(passwd_file, 'r')
    line = file.readline()
    return line.strip()
 
# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, rc):
    current_time = datetime.datetime.now().strftime("%H:%M:%S")
    print("[{}] Connected with result code {}".format(current_time, str(rc)))

    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    # client.subscribe("#")
    client.subscribe("rtl_433/+/devices/Prologue-TH/+/+/102/temperature_F")

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
    prom_gauge.set_to_current_time()
    prom_gauge.set(float(msg.payload.decode()))   # Set to a given value

if __name__ == '__main__':
    global prom_gauge

    passwd = get_passwd("/usr/local/etc/passwd")

    client = mqtt.Client()
    client.username_pw_set("tiny", password = passwd)
    client.on_connect = on_connect
    client.on_message = on_message

    # connect to mqtt
    client.connect("raspi-pi4", 1883, 60)

    # prometheus scrape point
    start_http_server(8000)

    prom_gauge = Gauge('prologue_th_temperature', 'description of gauge')

    # Blocking call that processes network traffic, dispatches callbacks and
    # handles reconnecting.
    # Other loop*() functions are available that give a threaded interface and a
    # manual interface.
    client.loop_forever()
