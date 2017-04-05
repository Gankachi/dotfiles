#!/bin/bash
ethState=$(ethtool enp0s25 | grep 'Link detected' | awk '{print $3;}');
wlanState=$(ethtool wlp2s0 | grep 'Link detected' | awk '{print $3;}');
if [ $ethState == "yes" ]; then
	string=$(~/.i3/lib/eth.sh);
fi


if [ $wlanState == "yes" ]; then
	string=$(~/.i3/lib/wifi.sh);
fi

echo "<span background='#002b36' foreground='#b58900'></span><span background='#b58900' foreground='#fdf6e3'>$string </span>"
