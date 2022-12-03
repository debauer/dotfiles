#!/usr/bin/env python3

import subprocess
from argparse import ArgumentParser

from helper.process import command_print

mac = {"boxen": "E9:08:EF:8B:66:6C", "headset": "28:11:A5:48:88:B4"}

def parse():
    parser = ArgumentParser(description="System to record the data on a trimodal crane")
    parser.add_argument("device", type=str, help="device", choices=mac.keys())
    return parser.parse_args().device

def connect(device):
    try:
        command_print(f"bluetoothctl connect {mac[device]}")
    except subprocess.TimeoutExpired:
        print("connection failed [timeout]")
        

if __name__ == "__main__":
    connect(parse())
    exit()