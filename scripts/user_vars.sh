#|------------------------------------------------------|#
#|Script to setup system-wide, dm agnostic variables    |#
#|------------------------------------------------------|#

export XDG_CONFIG_HOME="$HOME/.config"
sysScrPath="$XDG_CONFIG_HOME/myde/sysScripts"
custScrPath="$XDG_CONFIG_HOME/myde/custScripts"

append_path "$sysScrPath"
append_path "$custScrPath"
export PATH
