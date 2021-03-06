from subprocess import check_output
import blinkt
import time


people = {"user1" : {"mac" : "4c:cc:6a:fd:43:6e",
                      "color" : (0,60,0),
                      "pixel" : 0,
                      "present" : False},
          "user2" : {"mac" : "b8:27:eb:dd:88:3b",
                     "color" : (60,0,40),
                     "pixel" : 1,
                     "present" : False}} 
def show_presence(people):
    for person in people:
        person = people[person]
        r,g,b = person["color"]
        pixel = person["pixel"]
        present = person["present"]
        if present:
            blinkt.set_pixel(pixel,r,g,b)
        else:
            blinkt.set_pixel(pixel,0,0,0)
    blinkt.show()

def scan_network():
    arp_out = check_output(["sudo", "arp-scan", "192.168.0.0-192.168.5.0"])
    arp_out =arp_out.decode()
    arp_out = arp_out.split("\n")
    devices = []
    for x in arp_out:
        if "192.168" in x:
           devices.append(x.split("\t"))
    macs = [str(x[1]) for x in devices]
    return(macs)

if __name__ == "__main__":
    blinkt.clear()
    blinkt.show()
    try:
        while True:
            macs = scan_network()
            print("1")
            for person in people:
                print(person)
                person = people[person]
                if person["mac"] in macs:
                    person["present"] = True
                else:
                    person["present"] = False
            show_presence(people)
            time.sleep(1)
    except Exception as e:
        print(str(e))
        blinkt.clear()
        blinkt.show()
