#!/bin/bash
# Shows eth information
# Example: "E : 192.168.1.50 (at 130 Mb/s)" 

data=$(sudo ethtool enp0s25)
bitrate=$(echo "$data" | grep 'Speed' | awk '{print $2;}' | sed 's/000M/G/g')
ip=$(ip a | grep -n2 enp0s25 | grep "inet " | awk '{print $3;}' | sed 's/\/.*$//g') 
echo "$BLOCK_BUTTON E : $ip (at $bitrate)";
