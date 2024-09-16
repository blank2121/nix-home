{ ... }:

{
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    keymap = {
      manager = {
        prepend_keymap = [
	  { desc = "Set hovered file as wallpaper"; on = [ "b" "g" ]; run = "shell --confirm \"swww img --transition-type=any $0\""; } 
	  ];
      }; 
    };
  };
}
