#!/bin/sh

laptopname="eDP-1-0"
hdmiName="HDMI-1-0"
displayportName="DP-0"

query=$(xrandr -q)
vertical=$(echo $query | grep "$hdmiName connected")
laptop=$(echo $query | grep "$laptopname connected")
ultrawide=$(echo $query | grep "$displayportName connected")

vertConfig=""
laptopConfig=""
ultrawideConfig=""

if [ ! -z "$vertical" ]
then
	if [ ! -z "$ultrawide" ]
	then
		echo Setting up Vertical
		vertConfig="--output $hdmiName --mode 2560x1440 --pos 0x0 --rotate right --rate 60.00" 
	else
		echo Setting up horizontal
		vertConfig="--output $hdmiName --mode 2560x1440 --rotate normal --rate 60.00 --primary --left-of $laptopname-1-0"
	fi
	echo $vertConfig
fi
if [ ! -z "$laptop" ]
then
	echo Setting up laptop
	# if [ ! -z "$ultrawide" ]
	# then
	# 	laptopConfig="--output $laptopname --mode 2560x1440 --pos 4880x560 --rotate normal --rate 165.00"
	# else
	# 	laptopConfig="--output $laptopname --mode 2560x1440 --rotate normal --rate 165.00"
	# fi
	# laptopConfig="--output $laptopname --mode 2560x1440 --rotate normal --rate 165.00"
	laptopConfig="--output $laptopname --auto"
	echo $laptopConfig
fi
if [ ! -z "$ultrawide" ]
then
	echo Setting up Ultrawide

	# if [ ! -z "$vertical" ]
	# then
	# 	ultrawideConfig="--output DP-0 --primary --mode 3440x1440 --pos 1440x560 --rotate normal --rate 144.00"
	# else
	# 	ultrawideConfig="--output DP-0 --primary --mode 3440x1440 --rotate normal --rate 144.00 --left-of $laptopname-1-0"
	# fi
	if [ ! -z "$laptop" ]
	then 
		ultrawideConfig="--output $displayportName --primary --mode 3440x1440 --right-of $laptopname --rate 144.00"
		# ultrawideConfig="--output $displayportName --primary --auto"
	else
		ultrawideConfig="--output $displayportName --primary --mode 3440x1440 --rotate normal --rate 144.00"
	fi
	
	echo $ultrawideConfig

	# if [ ! -z "$larptop" ]
	# then 
	# 	xrandr --output DP-0 --left-of $laptopname-1-0
	# fi
fi

echo setup $vertConfig $laptopConfig $ultrawideConfig

xrandr $vertConfig $laptopConfig $ultrawideConfig
# s="$(nvidia-settings -q CurrentMetaMode -t)"

# if [ "${s}" != "" ]; then
#   s="${s#*" :: "}"
#   nvidia-settings -a CurrentMetaMode="${s//\}/, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On\}}"
# fi
# xrandr --output DP-0 --primary --mode 3440x1440 --pos 1440x560 --rotate normal --rate 144.00 --output DP-1 --off --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate right --rate 60.00 --output DP-2 --off --output $laptopname-1-0 --mode 2560x1440 --pos 4880x560 --rotate normal --rate 165.00
