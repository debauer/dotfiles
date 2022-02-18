#!/usr/bin/env python3

from argparse import ArgumentParser
from typing import List

import pulsectl
from pulsectl import PulseSinkInfo, PulseClientInfo, PulseOperationFailed, PulseSinkInputInfo


def find_sink(name: str) -> PulseSinkInfo:
    sinks: List[PulseSinkInfo] = pulse.sink_list()
    for s in sinks:
        if s.proplist["device.description"] == name:
            print("found sink:")
            print(" ", s)
            return s

def find_short_name(name: str) -> str:
    for ms in my_sinks:
        if my_sinks[ms] == name:
            return ms
        
def default_sink() -> None:
    sinks: List[PulseSinkInfo] = pulse.sink_list()
    for s in sinks:
        if s.proplist["node.name"] == pulse.server_info().default_sink_name:
            print("default sink:")
            print(" ", find_short_name(s.proplist["device.description"]))
    
        
def active_sink() -> PulseSinkInfo:
    sinks: List[PulseSinkInfo] = pulse.sink_list()
    for s in sinks:
        if s.state._value == "running":
            print("active sink:")
            print(" ", find_short_name(s.proplist["device.description"]))
            return s

def available_sinks() -> None:
    sinks: List[PulseSinkInfo] = pulse.sink_list()
    print("available sinks:")
    for s in sinks:
        print(f' {find_short_name(s.proplist["device.description"])} (state:{s.state._value}, device.id:{s.proplist["device.id"]})')

def available_input_sinks() -> List[PulseSinkInputInfo]:
    sinks: List[PulseSinkInputInfo] = pulse.sink_input_list()
    print("available input sinks:")
    for s in sinks:
        print(" ", s.proplist["application.name"])
    return sinks

def available_clients() -> List[PulseClientInfo]:
    playbacks: List[PulseClientInfo] = pulse.client_list()
    print("available clients:")
    for p in playbacks:
        print(f' {p.proplist["application.name"]} (id:{p.index})')
    return playbacks
        
my_sinks = {
    "internal": "Internes Audio Analog Stereo",
    "boxen": "AUKEY BR-C1",
    "bayer": "USB HIFI Audio Analog Stereo",
    "bose": "Bose David"
}

parser = ArgumentParser(description="System to record the data on a trimodal crane")
parser.add_argument("device", type=str, help="device", choices=my_sinks.keys())
device = parser.parse_args().device

pulse = pulsectl.Pulse("my-client-name")

print(pulse.sink_input_list())
sink = find_sink(my_sinks[device])
input_sinks = available_input_sinks()
active_sink()
available_sinks() 
available_clients()
default_sink()

pulse.sink_default_set(sink)
for input_sink in input_sinks:
    try:
        pulse.sink_input_move(input_sink.index, sink.index)
    except PulseOperationFailed:
        print("failed",input_sink.proplist["application.name"])



