import subprocess
import shlex

import re

PATTERN = re.compile(r"""((?:[^;"']|"[^"]*"|'[^']*')+)""")


def command_silent(command: str, verbose: bool = False):
    if verbose:
        print("[command_silent] " + command)
    subprocess.Popen(args=command, shell=True)


def command_print(command: str, timeout: float | None = 2.0, verbose: bool = False) -> str:
    if verbose:
        print(command)
        print(shlex.split(command))
    proc = subprocess.run(
        shlex.split(command),
        text=True,
        stdout=subprocess.PIPE,
        check=True,
        timeout=timeout,
    )
    if verbose:
        for line in proc.stdout.split("\n"):
            print(line)
        if proc.stderr:
            for line in proc.stderr.split("\n"):
                print(line)
    return proc.stdout
