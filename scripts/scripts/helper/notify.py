from helper.process import command_print

def notify(appname: str, id: int, msg: str, icon: str = "omputer.png"):
    #icon = f'--icon="{icon}"'
    icon = ""
    command = f'dunstify --appname="{appname}" --replace="{id}" {icon} "{msg}"'
    command_print(command)
    
