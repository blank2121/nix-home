#!/bin/sh

# Function to get the current workspace number
get_current_workspace() {
  hyprctl activeworkspace -j | jq '.id'
}

# Check if exactly one argument is provided
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <workspace_number>"
  exit 1
fi

# Get the workspace number from the first argument
workspace_number="$1"

# Get the current workspace ID
current_workspace=$(get_current_workspace)

# Compare workspace number and current workspace
if [[ $workspace_number -eq $current_workspace ]]; then
  echo "◆"  # Active workspace symbol
else
  echo "◇"  # Inactive workspace symbol
fi
