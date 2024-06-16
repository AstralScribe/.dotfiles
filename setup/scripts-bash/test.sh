scrDir=$(dirname "$(realpath "$0")")
CfgLst="${1:-"${scrDir}/restore_cfg.lst"}"
cat "${CfgLst}" | while read lst; do

    echo -e "${lst}" | awk -F '|' '{print $1}'
	echo -e "${lst}" | awk -F '|' '{print $2}'
    pth=$(echo "${lst}" | awk -F '|' '{print $3}')
    pth=$(eval echo "${pth}")
    echo -e "$pth"
	echo -e "${lst}" | awk -F '|' '{print $4}'
	echo -e "${lst}" | awk -F '|' '{print $5}'

done
