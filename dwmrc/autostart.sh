#!/bin/bash

compton --config ~/.config/compton.conf &
nitrogen --restore &
#Run this command at last
~/Apps/src/dwm/dwmrc/dwm_status.sh 
