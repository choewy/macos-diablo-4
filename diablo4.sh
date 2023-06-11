#!/bin/zsh

LANG=en_US.UTF-8

WINE_PREFIX=~/battle.net

PROGRAM_DIR='C:\Program Files (x86)'
PROGRAM_PATH='Diablo IV/Diablo IV Launcher.exe'

arch -x86_64 gameportingtoolkit-no-hud $WINE_PREFIX "'${PROGRAM_DIR}/${PROGRAM_PATH}'"

exit 0