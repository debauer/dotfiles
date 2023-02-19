#!/usr/bin/env python3

from argparse import Namespace, ArgumentParser
from pathlib import Path

from mutagen.mp3 import MP3  
from mutagen.easyid3 import EasyID3

def parse_args() -> Namespace:
    parser = ArgumentParser(description="rename soundcloud downloads")
    parser.add_argument("-p", "--path", type=str, default=".")
    parser.add_argument("-d", "--debug", action='store_true' )
    return parser.parse_args()

blacklist = []
reverse_artist_title = [1245901033, 1214336509, 1245902500, 1302717112]
remove = [
    " - ON SPOTIFY", 
    "-ON SPOTIFY-", 
    "_OUT ON ALl PLATFORMS_", 
    "-OUT ON ALl PLATFORMS-", 
    "ON SPOTIFY",
    "(IN SPOTIFY)"]

if __name__ == "__main__":
    args = parse_args()
    paths = Path(args.path).glob("**/*")
    debug = args.debug
    for p in paths:
        if p.is_file():
            name = p.name.replace(p.suffix,"")
            ending = p.suffix
            folder = p.parent.absolute()
            artist = name.split("-").pop().strip()
            old_artist = artist
            album = "soundcloud"
            name_wo_artist = name[0:len(name)-len(artist)-3]
            id = name_wo_artist.split("_").pop().strip()
            name_wo_artist_id = name_wo_artist[0:len(name_wo_artist)-len(id)-1]
            name_wo_artist_id_clean = name_wo_artist_id.replace(f"{artist} - ","")
            name_wo_artist_id_clean = name_wo_artist_id_clean.replace(f"_","-")
            name_wo_artist_id_clean = name_wo_artist_id_clean.replace(f"{artist} - ","")
            name_wo_artist_id_clean = name_wo_artist_id_clean.replace(f"{artist} _ ","")
            name_wo_artist_id_clean = name_wo_artist_id_clean.replace(f"{artist}","")
            for item in remove:
                name_wo_artist_id_clean = name_wo_artist_id_clean.replace(item,"")
            name_wo_artist_id_clean = name_wo_artist_id_clean.strip()
            if artist == "Phonk Workshop" and int(id) not in blacklist:
                t = name_wo_artist_id_clean.split(" - ")
                if len(t) == 2:
                    artist = t[0] if int(id) in reverse_artist_title else t[1]
                    name_wo_artist_id_clean = t[1] if int(id) in reverse_artist_title else t[0]
            if id.isnumeric():
                if debug:
                    print(f"'{old_artist}' # '{id}' # '{album}' #  '{name}'")
                print(f"'{artist}' # '{id}' # '{album}' #  '{name_wo_artist_id_clean}'")
                if debug:
                    print()
            else:
                if debug:
                    print(f"'IGNORE: {name}'")

                
    
