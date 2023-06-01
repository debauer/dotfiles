#!/usr/bin/env python3

from argparse import ArgumentParser
from typing import List

import pulsectl
from pulsectl import PulseSinkInfo, PulseClientInfo, PulseOperationFailed, PulseSinkInputInfo

from helper.notify import notify

pulse = pulsectl.Pulse("my-client-name")

my_sinks = {
    "internal": "Family 17h/19h HD Audio Controller",
    "boxen": "Sound Blaster Play!",
    "bayer": "USB HIFI Audio",
    "bose": "Bose David"
}

def find_sink(name: str, verbose: bool = False) -> PulseSinkInfo:
    sinks: List[PulseSinkInfo] = pulse.sink_list()
    for s in sinks:
        if s.proplist["device.description"] == my_sinks[name]:
            if verbose:
                print("found sink:")
                print(" ", s)
            return s
        

def find_short_name(name: str) -> str:
    for ms in my_sinks:
        if my_sinks[ms] == name:
            return ms
        
def default_sink(verbose: bool = False) -> None:
    sinks: List[PulseSinkInfo] = pulse.sink_list()
    for s in sinks:
        if verbose:
            if s.proplist["node.name"] == pulse.server_info().default_sink_name:
                print("default sink:")
                print(" ", find_short_name(s.proplist["device.description"]))
    
        
def active_sink(verbose: bool = False) -> PulseSinkInfo:
    sinks: List[PulseSinkInfo] = pulse.sink_list()
    for s in sinks:
        if s.state._value == "running":
            if verbose:
                print("active sink:")
                print(" ", find_short_name(s.proplist["device.description"]))
            return s

def available_sinks(verbose: bool = False) -> None:
    sinks: List[PulseSinkInfo] = pulse.sink_list()
    if verbose:
        print("available sinks:")
        for s in sinks:
            print(f'description:{s.proplist["device.description"]} || short_name:{find_short_name(s.proplist["device.description"])} || state:{s.state._value} || device.id:{s.proplist["device.id"]}')

def available_input_sinks(verbose: bool = False) -> List[PulseSinkInputInfo]:
    sinks: List[PulseSinkInputInfo] = pulse.sink_input_list()
    if verbose:
        print("available input sinks:")
        for s in sinks:
            print(" ", s.proplist["application.name"])
    return sinks

def available_clients(verbose: bool = False) -> List[PulseClientInfo]:
    playbacks: List[PulseClientInfo] = pulse.client_list()
    if verbose:
        print("available clients:")
        for p in playbacks:
            print(f' {p.proplist["application.name"]} (id:{p.index})')
    return playbacks
        


def menue_item():
    return my_sinks

def parse():
    parser = ArgumentParser(description="System to record the data on a trimodal crane")
    parser.add_argument("device", type=str, help="device", choices=my_sinks.keys())
    parser.add_argument("-v", "--verbose", action='store_const', const="verbose", help="verbose")
    return parser.parse_args()


def switch(device: str, verbose: bool):
    if verbose:
        print(pulse.sink_input_list())
    sink = find_sink(device)
    input_sinks = available_input_sinks()


    pulse.sink_default_set(sink)
    for input_sink in input_sinks:
        try:
            pulse.sink_input_move(input_sink.index, sink.index)
        except PulseOperationFailed:
            print(f"failed {input_sink.proplist['application.name']}")
        except AttributeError:
            available_sinks(verbose=True) 
            print("NO SINK FOUND")
            return
    print("DONE")



def _main():
    args = parse()
    verbose = args.verbose
    device = args.device
    
    active_sink(verbose)
    available_sinks(verbose) 
    available_clients(verbose)
    default_sink(verbose)
    
    switch(device, verbose)
    #notify("sound.py", "1337", f"changed sink to: {device}")
    exit()

if __name__ == "__main__":
    _main()
    
