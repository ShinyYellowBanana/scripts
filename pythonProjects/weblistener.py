import socket
import fcntl

# set the target website and port
target_website = "www.example.com"
target_port = 80

# create a raw socket
s = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_TCP)

# receive all packets
s.bind(("", 0))
s.setsockopt(socket.IPPROTO_IP, socket.IP_HDRINCL, 1)

# receive data indefinitely
while True:
    # receive a packet
    packet = s.recvfrom(65565)

    # extract the data from the packet
    data = packet[0]

    # extract the source IP and destination IP from the data
    src_ip = data[12:16]
    dst_ip = data[16:20]

    # convert the source IP and destination IP to human-readable format
    src_ip = socket.inet_ntoa(src_ip)
    dst_ip = socket.inet_ntoa(dst_ip)

    # extract the source port and destination port from the data
    src_port = data[20:22]
    dst_port = data[22:24]

    # convert the source port and destination port to integers
    src_port = int.from_bytes(src_port, byteorder="big")
    dst_port = int.from_bytes(dst_port, byteorder="big")
    if dst_port != 22:
        print("SRC:\t",src_port)
        print("DST:\t",dst_port)

    # check if the packet is going to the target website and port
    if dst_ip == target_website and dst_port == target_port:
        print("Device with IP address {} is going to {} on port {}".format(src_ip, dst_ip, dst_port))

# close the socket
s.close()
