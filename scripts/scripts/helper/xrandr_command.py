from helper.display import display_list
from helper.process import command_silent, command_print


class XrandrCommand:
    def __init__(self, primary: str = "eDP-1"):
        self.primary = primary
        self.displays = display_list()
        self.monitors = {}
        self.setups = {}
        self.command = ""

    def set_setups(self, setups):
        self.setups = setups

    def set_monitors(self, monitors):
        self.monitors = monitors

    def disable(self, display):
        return f" --output {display} --off "

    def enable(self, display, mode, pos, rotate):
        primary = ""
        if display == self.primary:
            primary = "--primary"
        return f"--output {display} {primary} --mode {mode} --pos {pos} --rotate {rotate}"

    def build(self, setup_name: str) -> str:
        print("enable: ", setup_name)
        monitor_setup = []
        for mon in self.setups[setup_name]:
            monitor_setup.append(self.monitors[mon])
        print("monitor_setups:", monitor_setup)
        command = "xrandr -display :0.0 "
        for display in self.displays:
            for setup in monitor_setup:
                if display == setup[0]:
                    print(*setup)
                    command += self.enable(*setup)
                    continue
            command += self.disable(display)
        self.command = command
        return command

    def run(self):
        command_silent(self.command)
