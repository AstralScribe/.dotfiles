#!/usr/bin/env sh

while getopts "nps:" option ; do
    case $option in

    n ) 
        Theme_Change n
        export xtrans="grow" ;;

    p ) # set previous theme
        Theme_Change p
        export xtrans="outer" ;;

    s ) # set selected theme
        themeSet="$OPTARG" ;;

    * ) # invalid option
        echo "... invalid option ..."
        echo "$(basename "${0}") -[option]"
        echo "n : set next theme"
        echo "p : set previous theme"
        echo "s : set input theme"
        exit 1 ;;
    esac
done
