#! /usr/bin/python3

import paho.mqtt.client as mqtt
from prometheus_client import start_http_server
from prometheus_client import Gauge
import time, datetime

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

    client.subscribe("rtl_433/#", qos = 1)

# The callback for when a PUBLISH message is received from the server.
def on_message_oregon(client, userdata, msg):
    global recent_oregon
    if ((recent_oregon + datetime.timedelta(seconds = 30)) < datetime.datetime.now()):
        recent_oregon = datetime.datetime.now()
        # print("oregon topic: {}, payload: {}".format(msg.topic, msg.payload.decode())) # Set to a given value
        prom_gauge_oregon.set_to_current_time()
        prom_gauge_oregon.set(float("{:.2f}".format(float(msg.payload.decode()))))   # Set to a given value

# The callback for when a PUBLISH message is received from the server.
def on_message_prologue(client, userdata, msg):
    global recent_prologue
    if ((recent_prologue + datetime.timedelta(seconds = 30)) < datetime.datetime.now()):
        recent_prologue = datetime.datetime.now()
        #print("prologue topic: {}, payload: {}".format(msg.topic, msg.payload.decode())) # Set to a given value
        prom_gauge_prologue.set_to_current_time()
        prom_gauge_prologue.set(float("{:.2f}".format(float(msg.payload.decode()))))   # Set to a given value

# The callback for when a PUBLISH message is received from the server.
def on_message_accurite(client, userdata, msg):
    global recent_accurite
    if ((recent_accurite + datetime.timedelta(seconds = 30)) < datetime.datetime.now()):
        recent_accurite = datetime.datetime.now()
        # print("accurite topic: {}, payload: {}".format(msg.topic, msg.payload.decode())) # Set to a given value
        prom_gauge_accurite.set_to_current_time()
        prom_gauge_accurite.set(float("{:.2f}".format(float(msg.payload.decode()))))   # Set to a given value

if __name__ == '__main__':
    global prom_gauge_oregon, prom_gauge_prologue, prom_gauge_accurite
    global recent_oregon, recent_prologue, recent_accurite

    recent_oregon = datetime.datetime(1971, 1, 1)
    recent_prologue = datetime.datetime(1971, 1, 1)
    recent_accurite = datetime.datetime(1971, 1, 1)

    passwd = get_passwd("/usr/local/etc/passwd")

    client = mqtt.Client()

    client.on_connect = on_connect

    client.message_callback_add("rtl_433/Oregon-THGR122N/temperature_F", on_message_oregon)
    client.message_callback_add("rtl_433/Prologue-TH/temperature_F", on_message_prologue)
    client.message_callback_add("rtl_433/Acurite-Tower/temperature_F", on_message_accurite)

    # connect to mqtt
    client.username_pw_set("tiny", password = passwd)
    client.connect("raspi-pi4", 1883, 60)

    # prometheus scrape point
    start_http_server(8000)

    prom_gauge_oregon = Gauge('oregon_temperature', 'description of gauge')
    prom_gauge_prologue = Gauge('prologue_temperature', 'description of gauge')
    prom_gauge_accurite = Gauge('accurite_temperature', 'description of gauge')

    # Blocking call that processes network traffic, dispatches callbacks and
    # handles reconnecting.  Other loop*() functions are available that give a
    # threaded interface and a manual interface.
    client.loop_forever()
