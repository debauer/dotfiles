#!/usr/bin/env python3
from helper.process import command_silent

if __name__ == "__main__":
    command_silent("xset dpms force off", verbose=True)