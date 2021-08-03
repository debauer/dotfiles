import magic, os, sys
from pathlib import Path
file = list(Path("/boot").glob("vmlinuz-*"))
os_info = os.uname()
sys.exit(os_info.release not in file[0].as_posix())