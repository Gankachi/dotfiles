#!/bin/bash
# Shows volume and allows mute on click
# example: HDA Intel PCH:70% || Headset:MUTED
declare -A nameTable
nameTable=(["Built-in Audio Digital Stereo (HDMI)"]="HDMI"
        ["Built-in Audio Analog Stereo"]="Front Jack"
        ["G930 Analog Stereo"]="Headset"
        ["HDA NVidia Digital Stereo (HDMI)"]="NVidia")

card=$(pactl list short | grep RUNNING | awk '{print $1}')
if [[ $card == "" ]]; then
	defaultCard=$(pactl info | grep "Default Sink:" | awk '{print $3}')
	card=$(pactl list sinks | grep -B2 "Name: $defaultCard" | grep "Sink #" | awk '{print $2};' | sed 's/#//g')
fi
cardInfo=$(pactl list sinks | grep -A14 "Sink #$card")
cardName=$(echo "$cardInfo" | grep Description: | sed -e 's/^.*Description: //g')
if [[ ${nameTable[$cardName]} != "" ]]; then
	cardName=${nameTable[$cardName]}
fi
cardVolume=$(echo "$cardInfo" | grep "Volume:" | grep -vi "Base Volume:" | awk '{print $5}')

isCardMute=$(echo "$cardInfo" | grep "Mute:" | awk '{print $2}')

case "$BLOCK_BUTTON" in
"1" | "2" | "3") # mute/unmute
    if [ $isCardMute == "no" ]; then
	pactl set-sink-mute $card yes
	isCardMute=$(pactl list sinks | grep -A14 "Sink #$card" | grep "Mute:" | awk '{print $2}')
    else
	pactl set-sink-mute $card no
	isCardMute=$(pactl list sinks | grep -A14 "Sink #$card" | grep "Mute:" | awk '{print $2}')
    fi
    ;;
"4") # sound up
    pactl set-sink-volume $card +3%
    cardVolume=$(pactl list sinks | grep -A14 "Sink #$card" | grep "Volume:" | grep -vi "Base Volume:" | awk '{print $5}');
    ;;
"5") # sound down
    pactl set-sink-volume $card -3%
    cardVolume=$(pactl list sinks | grep -A14 "Sink #$card" | grep "Volume:" | grep -vi "Base Volume:" | awk '{print $5}');
    ;;
"9") # card up
    newCard=$(expr $card + 1)
    if [[ $(pactl list sinks | grep "Sink #$newCard") != "" ]]; then
	    card=$newCard
	    pactl set-default-sink $card
	    for i in $(pacmd list-sink-inputs | grep index | awk '{print $2}')
	    do
		pactl move-sink-input $i $card
	    done

	    cardInfo=$(pactl list sinks | grep -A14 "Sink #$card")
	    cardName=$(echo "$cardInfo" | grep Description: | sed -e 's/^.*Description: //g')
	    if [[ ${nameTable[$cardName]} != "" ]]; then
		cardName=${nameTable[$cardName]}
	    fi
	    cardVolume=$(echo "$cardInfo" | grep "Volume:" | grep -vi "Base Volume:" | awk '{print $5}')
	    isCardMute=$(echo "$cardInfo" | grep "Mute:" | awk '{print $2}')
    fi
    ;;
"8") # card down
    newCard=$(expr $card - 1)
    if [[ $(pactl list sinks | grep "Sink #$newCard") != "" ]]; then
	    card=$newCard
	    pactl set-default-sink $card
	    for i in $(pacmd list-sink-inputs | grep index | awk '{print $2}')
	    do
		pactl move-sink-input $i $card
	    done

	    cardInfo=$(pactl list sinks | grep -A14 "Sink #$card")
	    cardName=$(echo "$cardInfo" | grep Description: | sed -e 's/^.*Description: //g')
	    if [[ ${nameTable[$cardName]} != "" ]]; then
		cardName=${nameTable[$cardName]}
	    fi
	    cardVolume=$(echo "$cardInfo" | grep "Volume:" | grep -vi "Base Volume:" | awk '{print $5}')
	    isCardMute=$(echo "$cardInfo" | grep "Mute:" | awk '{print $2}')
    fi
    ;;
*) # default
    ;;
esac
string=""
if [[ $isCardMute == "no" ]]; then
    string="${cardName}: $cardVolume";
else
    string="${cardName}: MUTED"
fi

echo "<span background='#002b36' foreground='#268bd2'></span><span background='#002b36' foreground='#eee8d5'> $string </span>"
