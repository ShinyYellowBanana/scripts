import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe("#")

def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))

client = mqtt.Client()
client.username_pw_set("root", "Jrotc7281991!@")  # set the username and password
client.on_connect = on_connect
client.on_message = on_message

client.connect("192.168.1.141", 1883, 60)

client.loop_forever()
