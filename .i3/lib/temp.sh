#!/bin/bash
# Displays the CPU Temperature
# Eg: Temp: +31.0°

echo "<span background='#2aa198' foreground='#073642'></span><span background='#073642' foreground='#fdf6e3'> $(sensors coretemp-isa-0000 | awk '/Physical/ {print $4}') </span>"
