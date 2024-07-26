#!/bin/sh

# File to store the previous battery level
prev_battery_file="/tmp/prev_battery_level"

# Check if the previous battery level file exists
if [ -e "$prev_battery_file" ]; then
	# Read the previous battery level from the file
	prev_battery_level=$(cat "$prev_battery_file")

	# Check if the script is called with the argument "testL"
	if [ "$1" == "testL" ]; then
		# Run Dunst notification for testing low battery
		dunstify -u c "Low Battery Test" "Test Notification Triggered"
	elif [ "$1" == "testF" ]; then
		# Run Dunst notification for testing full battery
		dunstify -u fullbat "Battery Charged Test" "Test Notification Triggered"
	else
		# Get the current battery level
		current_battery_level=$(cat /sys/class/power_supply/BAT*/capacity)

		# Check if the battery is fully charged (at least 97%)
		if [ "$current_battery_level" -ge 97 ] && [ "$prev_battery_level" -lt 97 ]; then
			# Run Dunst notification for full battery
			dunstify -u fullbat "Battery Charged" "Battery is Fully Charged"
		fi

		# Check if the current battery level is below 20%
		if [ "$current_battery_level" -lt 20 ] && [ "$prev_battery_level" -ge 20 ]; then
			# Run Dunst notification for low battery
			dunstify -u c "Low Battery" "20% Battery Left"
		fi
	fi
fi

# Update the previous battery level file with the current level
if [ "$1" != "testL" ] && [ "$1" != "testF" ]; then
	echo "$current_battery_level" >"$prev_battery_file"
fi
