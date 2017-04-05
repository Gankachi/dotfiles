#!/bin/bash
# Shows WiFi information
# Example: "W : 192.168.1.50 (130 Mb/s at 70%) on My Wifi" 

data=$(iwconfig wlan0)
ssid=$(echo "$data" | grep 'ESSID:' | cut -d " " -f 9- | sed 's/ESSID://g' | sed 's/"//g' | sed 's/ *$//g')
bitrate=$(echo "$data" | grep 'Bit Rate' | awk '{print $2" "$3;}'| sed 's/^Rate=//g')
quality=$(echo "scale=1; "$(echo "$data" | grep 'Link Quality' | awk '{print $2;}' | sed 's/^Quality=//g')"*100" | bc | sed "s/\..*$/%/g")
ip=$(ip a | grep -n2 wlan0 | grep "inet " | awk '{print $3;}' | sed 's/\/.*$//g') 
echo "W : $ip ($bitrate at $quality) on $ssid"
