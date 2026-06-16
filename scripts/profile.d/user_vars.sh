#|------------------------------------------------------|#
#|Script to setup system-wide, dm agnostic variables    |#
#|------------------------------------------------------|#

export XDG_CONFIG_HOME="$HOME/.config"
sysScrPath="$XDG_CONFIG_HOME/myde/sysScripts"
custScrPath="$XDG_CONFIG_HOME/myde/custScripts"
userLocalPath="$HOME/.local/bin"

append_path "$userLocalPath"
append_path "$sysScrPath"
append_path "$custScrPath"
export PATH
