#!/bin/bash
# Shows amount of disk left on the three disks (Local, Windows, Data)
# ex: W:45G D:120G L:12G
data=$(df -h)

lin=$(echo "$data" | grep "/dev/sda6" | awk '{print $4}')
win=$(echo "$data" | grep "/dev/sda2" | awk '{print $4}')
dat=$(echo "$data" | grep "/dev/sda4" | awk '{print $4}')
echo "<span background='#000000' foreground='#268bd2'></span><span background='#268bd2' foreground='#fdf6e3'> W:$win D:$dat L:$lin </span>"
