#!/usr/bin/env python3
import subprocess
from argparse import ArgumentParser
from datetime import datetime
from time import sleep

from helper.process import command_print

sources = ["Flatbed", "ADF"]
resolution = [75, 100, 150, 200, 300]

imagename = datetime.now().isoformat()
device = "airscan:w1:Samsung Electronics Co., Ltd. M2070 Series"
    
def parse_args():
    parser = ArgumentParser(description="scan image")
    
    parser.add_argument("--source", type=str, help="Flatbed or ADF", choices=sources, default="Flatbed")
    parser.add_argument("--dpi", type=int, help="DPI", choices=resolution, default=300)
    parser.add_argument("--brightness", type=int, help="brightness -100..100% (in steps of 1)", choices=resolution, default=0)
    parser.add_argument("--contrast", type=int, help="contrast -100..100% (in steps of 1)", default=0)
    parser.add_argument("--name", type=str, help="name of file", default=imagename)
    parser.add_argument("--batch", help="reset", action='store_const', const="reset")

    return parser.parse_args()

def build_command(args):
    batch = args.batch
    cmd = f'scanimage -d "{device}" -p -v '
    cmd += f" --source {args.source}"
    cmd += f" --brightness {args.brightness}"
    cmd += f" --contrast {args.contrast}"
    cmd += f" --resolution {args.dpi}"
    if batch:
        batch += " --batch=batch%d.jpg"
        if args.source == "Flatbed":
            batch += " --batch-prompt "
    else:
        cmd += f" -o {args.name}.jpeg"
    return cmd

def build_dokument():
    tempname = imagename
    if args.batch:
        tempname = "batch*"
    cmd = f"convert {tempname}.jpg {imagename}.pdf"
    command_print(cmd, timeout=None)


args = parse_args()

command_print(build_command(args), timeout=None)
if args.batch:
    build_dokument()