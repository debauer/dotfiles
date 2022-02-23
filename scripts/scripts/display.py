#!/usr/bin/env python3
import subprocess
from argparse import ArgumentParser
from time import sleep

def display_list():
    monitor = []
    process = subprocess.run(
        ["xrandr"], shell=True, text=True, stdout=subprocess.PIPE, timeout=2
    )
    for line in process.stdout.split("\n"):
        if " connected " in line or " disconnected " in line:
            monitor.append(line.split()[0])
    monitor.sort()
    print("found displays:", monitor)
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

primary_monitor = "eDP-1"

monitors = {
    "laptop": ("eDP-1", "1920x1080", "1920x1440"),
    "Asus calibrated": ("DP-2-3", "2560x1440", "1466x0"),
    "thinkvision": ("DP-1", "1920x1080", "2240x1440" )
}

monitor_setups = {
    "home-3": ["laptop", "Asus calibrated", "thinkvision"],
    "home-2-small": ["laptop", "thinkvision"],
    "home-2-big": ["laptop", "Asus calibrated"],
    "home-1": ["laptop"],
}



def disable(display):
    return f" --output {display} --off "

def enable(display, mode, pos):
    primary = ""
    if display == primary_monitor:
        primary = "--primary"
    return f"--output {display} {primary} --mode {mode} --pos {pos} "

def build_command(enable_monitors: list):
    print("enable: ", enable_monitors)
    monitor_setup = []
    for mon in enable_monitors:
        monitor_setup.append(monitors[mon])
    print("monitor_setups:", monitor_setup)
    command = "xrandr "
    displays = display_list()
    for display in displays:
        for setup in monitor_setup:
            if display == setup[0]:
                command +=  enable(*(setup))
                continue
        command += disable(display)
    print(command)        
    
print()
parser = ArgumentParser(description="System to record the data on a trimodal crane")

parser.add_argument("--reset", help="reset", action='store_const', const="reset")
parser.add_argument("setup", type=str, help="setup", choices=monitor_setups)

args = parser.parse_args()
setup = args.setup
reset = args.reset

if reset:
    build_command(["home-1"])
    sleep(2)
build_command(monitor_setups[setup])
