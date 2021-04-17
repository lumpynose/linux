import paho.mqtt.client as mqtt

# 433.920MHz

# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe("rtl_433/raspi-pi4/devices/Oregon-THGR122N/3/101/temperature_F")

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
    temperature = float(msg.payload.decode('utf-8'))
    print("payload:", temperature)

client = mqtt.Client()
client.username_pw_set("tiny", password="secret")
client.on_connect = on_connect
client.on_message = on_message

client.connect("raspi-pi4", 1883, 60)

# Blocking call that processes network traffic, dispatches callbacks and
# handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a
# manual interface.
client.loop_forever()
