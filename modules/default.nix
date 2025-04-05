{
  username ? "default",
  ... 
}:
{
  imports = [
    ./clis
    ./guis
    ./sys
  ];
  
  home-manager.users.${username}.home.stateVersion = "23.11";
}
