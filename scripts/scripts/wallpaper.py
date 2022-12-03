#!/usr/bin/env python3
import subprocess
from argparse import ArgumentParser
from pathlib import Path

from helper.process import command_silent


def monitor_count():
    count = 0
    process = subprocess.run(
        ["xrandr"], shell=True, text=True, stdout=subprocess.PIPE, timeout=2
    )
    for line in process.stdout.split("\n"):
        if " connected " in line:
            count += 1
    return count

if __name__ == "__main__":
    wallpaper_folder = Path("/home/debauer/Bilder/Wallpaper/")
    wallpaper = wallpaper_folder.glob("**/*")
    
    choices = []
    for w in wallpaper:
        choices.append(str(w.name.split(".")[0]))
    choices.sort()
    
    parser = ArgumentParser(description="System to record the data on a trimodal crane")
    
    parser.add_argument("wallpaper", type=str, help="wallpaper", choices=choices)
    
    wallpaper = parser.parse_args().wallpaper


    print("run commands:")
    for x in range(monitor_count()):
        command = f"nitrogen --head={x} --set-scaled {wallpaper_folder.joinpath(wallpaper + '.jpg')}"
        command_silent(command, verbose=True)
    print("done")

# nitrogen --head=2 --set-scaled /home/debauer/Bilder/Wallpaper/wallpaperflare.com_wallpaper.jpg
# nitrogen --head=0 --set-scaled /home/debauer/Bilder/Wallpaper/wallpaperflare.com_wallpaper.jpg
