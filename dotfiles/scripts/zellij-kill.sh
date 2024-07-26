#!/bin/sh

# Get the session number from command-line argument
nth_session_to_kill=$1

# Check if the argument is provided
if [ -z "$nth_session_to_kill" ]; then
	echo "Usage: $0 <session_number>"
	exit 1
fi

# Define the zellij ls output
zellij_output="$(zellij ls)"

# Function to kill the specified session
kill_specified_session() {
	# Get the specified session name
	session_name=$(echo "$zellij_output" | sed -n "${1}p" | sed 's/\x1B\[[0-9;]*[a-zA-Z]//g' | awk '{print $1}')

	# Check if the session name is not empty
	if [ -n "$session_name" ]; then
		# Kill the session
		zellij d "$session_name"
		echo "Deleted session: $session_name"
	else
		echo "Session not found."
	fi
}

# Call the function to kill the specified session
kill_specified_session "$nth_session_to_kill"
