import paho.mqtt.client as mqtt
import time

# Define the MQTT broker address and port
broker_address = "192.168.1.141"
broker_port = 1883

# Define the username and password for the MQTT broker
username = "root"
password = "Jrotc7281991!@"

# Publish a test message to a topic
topic = "test/hello"
message = "Hello, world!"

# Define the callback function to handle connection status
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to MQTT broker")
    else:
        print("Failed to connect to MQTT broker with error code " + str(rc))

# Define the callback function to handle incoming messages
def on_message(client, userdata, message):
    print("Received message on topic " + message.topic + " with payload " + str(message.payload))
    exit(1)


# Create an MQTT client and set the callback functions
client = mqtt.Client()
client.username_pw_set(username, password)
client.on_connect = on_connect
client.on_message = on_message

# Connect to the MQTT broker and start the network loop
client.connect(broker_address, broker_port)

# Subscribe to the test topic
print("Subscibe")
client.subscribe(topic)

client.loop_start()
print("Publish")
time.sleep(3)
client.publish(topic, message)

while True:
    pass