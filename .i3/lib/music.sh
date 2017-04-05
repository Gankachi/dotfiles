#!/bin/bash
# Music controller
# Example output : ▶ [V.K - Paper Plane's Adventure (2015 Mix)]
case $BLOCK_BUTTON in
	1) data=$(mpc toggle) ;; # Play/Pause on left click
	8) data=$(mpc prev) ;; # Previous song on lower side button
	9) data=$(mpc next) ;; # Next sont on higher side button
	*) data=$(mpc) ;; # Just refresh
esac
data=$(mpc)
stat=$(echo "$data" | grep -E '(playing|paused)' | awk '{print $1;}')
song=$(echo "$data" | sed -n "1p")
string=""
if [[ $stat == "[playing]" ]]; then
	stat="▶"
else
	stat="⏸"
fi
if [[ $song == "" ]]; then
	::
elif [[ $song == "volume: n/a"* ]]; then
	string="■ [NO MUSIC]"
else
	string="$stat [$song]"
fi
echo "<span foreground='#002b36' background='#268bd2'></span><span foreground='#fdf6e3' background='#002b36'> $string </span>"
