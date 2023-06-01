#!/usr/bin/env python3

import subprocess
from argparse import ArgumentParser, Namespace

connections = {
    "jetson": ("automodal", "synyx123", "192.168.1.96:3389"),
    "sdr": ("pi", "raspberry", "192.168.1.112:3389"),
    "windows": ("debauer", "123456", "192.168.1.100:3389"),
    "windows-extern": ("debauer", "123456", "localhost:13389"),
}

def parse_args() -> Namespace:
    parser = ArgumentParser(description="System to record the data on a trimodal crane")

    parser.add_argument(
        "connection", type=str, help="connection", choices=connections.keys()
    )
    return parser.parse_args()

if __name__ == "__main__":
    args = parse_args()
    connection = args.connection
    try:
        # xfreerdp /u:"debauer" /p:'123456' /v:192.168.1.84:3389 /f +fonts /floatbar /smart-sizing
        # xfreerdp /u:"automodal" /p:'synyx123' /v:192.168.1.96:3389 /f +fonts /floatbar /smart-sizing
        command = f"xfreerdp /u:'{connections[connection][0]}' /p:'{connections[connection][1]}' /v:{connections[connection][2]} /f +fonts /floatbar /smart-sizing"
        print(command)
        connect = subprocess.Popen(args=command, shell=True)
        while connect.poll() is None:
            pass
    except KeyboardInterrupt:
        exit()
