#!/bin/bash

if [ "$1" == 'n' ]; then
    CONF="--no-configure -N"
    shift
fi

if [ -z "$1" ]; then
    LOC="SpringValley2"
else
    LOC="$1"
fi
shift

FILE='eeprom.bin'
if [ -f "$FILE" ]; then
    echo "Using existing eeprom.bin"
else
    echo "Copying committed eeprom.bin."
    cp eeproms/eeprom_camera.bin eeprom.bin
fi

nice python3 ../../Tools/autotest/sim_vehicle.py -D -G --aircraft test --vehicle ArduPlane -f quadplane:phoenix-camera.json -L $LOC $CONF --add-param-file=PhoenixSITL.parm --add-param-file=PhoenixSITL_additions.parm $@ 2> /tmp/mavproxy_cliwarnings.log

#was quadplane-tilthvec

#for ottano use SpringValley3
#for griffin pro and Volanti use SpringValley2
#Custom (put in ~/.config/ardupilot/locations.txt): 
#MtTennent=-35.54994219,149.04469406,1369,0
#Shortcut=-35.30414085,148.89860101,649,0
