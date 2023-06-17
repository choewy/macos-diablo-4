#!/bin/zsh

LANG=en_US.UTF-8

WINE_PREFIX=~/Games

arch -x86_64 gameportingtoolkit-no-hud $WINE_PREFIX 'C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe'

exit 0