#!/bin/sh

# Function to generate a button definition with workspace information generate_button() {
generate_button() {
  local workspace_number="$1"
  cmd="hyprctl dispatch workspace $workspace_number && ~/dotfiles/.config/eww/scripts/current-or-not.sh"
  current_workspace=$(get_current_workspace)

  symbol="◆"  # Symbol for the active workspace

  if [[ $workspace_number -eq $current_workspace ]]; then
    symbol="◆"  # Keep "◆" for the active workspace
  else
    symbol="◇"  # Use "◇" for non-active workspaces
  fi

  button_definition=" (button :onclick \\\"$cmd\\\" \\\"$symbol\\\" )"
  echo "$button_definition"
}

# Function to get the current workspace number
get_current_workspace() {
  hyprctl activeworkspace -j | jq '.id'
}

# Generate the Yuck code string
yuck_code="(box :orientation \\\"h\\\" :space-evenly true "

for i in {1..10}; do
  button_definition=$(generate_button "$i")
  yuck_code+="$button_definition"
done

# Close the Yuck code string
yuck_code+=")"

# Print the generated Yuck code string
echo -e "$yuck_code" > ~/dotfiles/.config/eww/scripts/windows
