#!/bin/bash
# Shows the amount of RAM being used (change from percent to actual number on click)
# example : "RAM : 58%"

used=$(free -m | grep Mem | awk '{ print $3;}')
total=$(free -m | grep Mem | awk '{ print $2;}')
ratio=$(awk "BEGIN { pc=100*${used}/${total}; i=int(pc); print (pc-i<0.5)?i:i+1 }")
string=""
case $1 in
"1" | "2" | "3") # Show actual value
	string="RAM : $ratio% (${used})"
	;;
*) # Don't show actual value
	string="RAM : $ratio%"
	;;
esac

echo "<span background='#b58900' foreground='#002b36'></span><span background='#002b36' foreground='#fdf6e3'> $string </span><span foreground='#2aa198' background='#002b36'></span>"
