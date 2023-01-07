import socket
import fcntl

# set the target website and port
target_website = "www.example.com"
target_port = 80

# look up the IP addresses of the target website
target_ips = []
addr_info = socket.getaddrinfo(target_website, target_port)
for addr in addr_info:
    target_ips.append(addr[4][0])

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

    # check if the packet is going to the target website and port
    if dst_ip in target_ips and dst_port == target_port:
        print("Device with IP address {} is going to {} on port {}".format(src_ip, dst_ip, dst_port))

# close the socket
s.close()
