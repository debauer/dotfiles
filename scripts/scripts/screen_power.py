#!/usr/bin/env python3
from helper.process import command_silent

command_silent("xset dpms force off", verbose=True)