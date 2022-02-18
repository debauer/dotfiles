#!/usr/bin/env python3

import subprocess
from argparse import ArgumentParser

mac = {"boxen": "E9:08:EF:8B:66:6C", "headset": "28:11:A5:48:88:B4"}


parser = ArgumentParser(description="System to record the data on a trimodal crane")

parser.add_argument("device", type=str, help="device", choices=mac.keys())

device = parser.parse_args().device
try:
    connect = subprocess.run(
        ["bluetoothctl", "connect", mac[device]],
        text=True,
        stdout=subprocess.PIPE,
        check=True,
        timeout=2,
    )
    for line in connect.stdout.split("\n"):
        print(line)
except subprocess.TimeoutExpired:
    print("connection failed [timeout]")
    exit()
