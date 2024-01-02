#!/usr/bin/env python3
import subprocess
from argparse import ArgumentParser
from time import sleep

from helper.notify import notify
from helper.xrandr_command import XrandrCommand


if __name__ == "__main__":
    command = XrandrCommand(primary="eDP-1")

    command.set_monitors(
        {
            "laptop": ("eDP-1", "1920x1080", "760x1569", "normal"),
            "asus": ("DP1-3", "2560x1440", "3440x0", "right"),
            "lg": ("DP1-1", "3440x1440", "0x154", "normal"),
            "thinkvision": ("DP-1", "1920x1080", "2680x1569", "normal"),
        }
    )

    command.set_setups(
        {
            "kitchen": ["asus", "lg"],
            "thinkvision": ["laptop", "thinkvision"],
            "laptop": ["laptop"],
        }
    )

    parser = ArgumentParser(description="System to record the data on a trimodal crane")

    parser.add_argument("--reset", help="reset", action="store_const", const="reset")
    parser.add_argument("setup", type=str, help="setup", choices=command.setups)

    args = parser.parse_args()
    setup = args.setup
    reset = args.reset

    if reset:
        command.build("laptop")
        command.run()
        sleep(2)
    print(command.build(setup))
    command.run()
    notify(__file__, 1337, f"changed displays to setup: {setup}")
    print("DONE")
