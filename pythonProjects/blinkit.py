from subprocess import check_output
import blinkt
import time


people = {"user1" : {"mac" : "18:c0:4d:a3:5b:20",
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
            blinkt.set_pixel(pixel,60,0,0)
    blinkt.show()

def scan_network():
    arp_out = check_output(["sudo", "arp-scan", "-lg"])
    arp_out =arp_out.decode()
    arp_out = arp_out.split("\n")
    devices = []
    for x in arp_out:
        if "192.168" in x:
           devices.append(x.split("\t"))
    print(devices)
    macs = [str(x[1]) for x in devices]
    print(macs)
    return(macs)

if __name__ == "__main__":
    blinkt.clear()
    blinkt.show()
    try:
        while True:
            macs = scan_network()
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
        print(f"ERROR: {str(e)}")
        blinkt.clear()
        blinkt.show()
