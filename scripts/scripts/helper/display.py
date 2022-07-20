import subprocess


def display_list():
    monitor = []
    process = subprocess.run(
        ["xrandr -display :0.0"], shell=True, text=True, stdout=subprocess.PIPE, timeout=2
    )
    for line in process.stdout.split("\n"):
        if " connected " in line or " disconnected " in line:
            monitor.append(line.split()[0])
    monitor.sort()
    return monitor
    
    
def edid():
    monitor = []
    process = subprocess.run(
        ["sudo find /sys |grep -i edid | grep 'sys/devices'"], shell=True, text=True, stdout=subprocess.PIPE, timeout=2
    )
    for line in process.stdout.split("\n"):
        s = line.split("/")
        if len(s) >= 8:
            monitor.append(s[7][6:])
    monitor.sort()
    print("found edids:", monitor)
    #subprocess.getoutput("xrandr")
    #pyedid.parse_edid(edid_bytes)