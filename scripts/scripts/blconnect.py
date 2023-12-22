#!/home/debauer/.dotfiles/scripts/scripts/.venv/bin/python3

import subprocess
from argparse import ArgumentParser
from dataclasses import dataclass

from helper.process import command_print


@dataclass
class Device:
    name: str = ""
    mac: str = ""


devices = [Device("bose", "28:11:A5:48:88:B4")]


def parse() -> Device:
    choices = [d.name for d in devices]

    parser = ArgumentParser(description="System to record the data on a trimodal crane")
    parser.add_argument("device", type=str, help="device", choices=choices)
    device_name = parser.parse_args().device
    for d in devices:
        if d.name == device_name:
            return d
    print("device not found")
    exit()


def connect(device: Device) -> None:
    try:
        command_print(f"bluetoothctl connect {device.mac}")
    except subprocess.TimeoutExpired:
        print("connection failed [timeout]")


if __name__ == "__main__":
    connect(parse())
