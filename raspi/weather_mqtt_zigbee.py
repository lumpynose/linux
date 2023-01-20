#! /usr/bin/python3

import paho.mqtt.client as mqtt
import time, datetime

print(datetime.datetime.now())

def get_passwd(passwd_file):
    file = open(passwd_file, 'r')
    line = file.readline()
    return line.strip()
 
# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, rc):
    current_time = datetime.datetime.now().strftime("%H:%M:%S")
    print("[{}] Connected with result code {}".format(current_time, str(rc)))

    client.subscribe("#", qos = 1)


# The callback for when a PUBLISH message is received from the server.
def on_message_zigbee_logging(client, userdata, msg):
    global recent_zigbee
    if ((recent_zigbee + datetime.timedelta(seconds = 30)) < datetime.datetime.now()):
        recent_zigbee = datetime.datetime.now()
        print("zigbee logging topic: {}, payload: {}, time: {}".
              format(msg.topic, msg.payload.decode(), recent_zigbee))

def on_message_zigbee_state(client, userdata, msg):
    global recent_zigbee
    if ((recent_zigbee + datetime.timedelta(seconds = 30)) < datetime.datetime.now()):
        recent_zigbee = datetime.datetime.now()
        print("zigbee state topic: {}, payload: {}, time: {}".
              format(msg.topic, msg.payload.decode(), recent_zigbee))

def on_message_zigbee_bridge(client, userdata, msg):
    now = datetime.datetime.now()
    print("zigbee bridge topic: {}, payload: {}, time: {}".
          format(msg.topic, msg.payload.decode(), now))

def on_message_zigbee_sensor(client, userdata, msg):
    global recent_zigbee_sensor
#    if ((recent_zigbee_sensor + datetime.timedelta(seconds = 30)) < datetime.datetime.now()):
    recent_zigbee = datetime.datetime.now()
    print("zigbee sensor topic: {}, payload: {}, time: {}".
          format(msg.topic, msg.payload.decode(), recent_zigbee))

if __name__ == '__main__':
    global recent_zigbee_sensor

    recent_zigbee_sensor = datetime.datetime(1971, 1, 1)

    passwd = get_passwd("/usr/local/etc/passwd")

    client = mqtt.Client()

    client.on_connect = on_connect

    #client.message_callback_add("zigbee2mqtt/bridge/logging", on_message_zigbee_logging)
    #client.message_callback_add("zigbee2mqtt/bridge/state", on_message_zigbee_state)

    client.message_callback_add("zigbee2mqtt/bridge/#", on_message_zigbee_bridge)
    client.message_callback_add("zigbee2mqtt/temperature/#", on_message_zigbee_sensor)

    # connect to mqtt
    #client.username_pw_set("tiny", password = passwd)
    client.connect("192.168.50.5", 1883, 60)

    # Blocking call that processes network traffic, dispatches callbacks and
    # handles reconnecting.  Other loop*() functions are available that give a
    # threaded interface and a manual interface.
    client.loop_forever()
