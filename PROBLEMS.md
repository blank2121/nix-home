# Issues List

### **kitty:** nixvim crashes when using that terminal and that terminal only

**Fix:** Unknown. Just gonna use Alacritty or Foot for now.

**Status:** Unfixed; problem avoided.


### ✔️ **[Ueberzugpp](https://github.com/blank2121/nix-home/blob/3371726177041c17d9d6ba4688e519cbf2bf73bb/modules/default/home-manager/clis-apps.nix#L59) fails to compile via CMake**
**Details:** When trying to compile `ueberzugpp`, the process fails during the CMake step.


**Fix:** waited until new version was out, and it now works as of 2.9.6.

**Status:** Fixed! 

---

### ❌ **[Ansel](https://github.com/blank2121/nix-home/blob/3371726177041c17d9d6ba4688e519cbf2bf73bb/modules/default/home-manager/clis-apps.nix#L13) fails to build**
**Details:** The build process for `ansel` fails with the following error:
  ```bash
  error: builder for '/nix/store/h1j5z8ndqqdnpsv3kanamx4ggwq6ic7i-ansel-0-unstable-2024-07-09.drv' failed with exit code 1;
         last 10 log lines:
         > -- Missing xsltproc
         > -- Missing Saxon-XSLT
         > -- No XSLT interpreter found
         > -- Found xmllint
         > -- Found exiftool
         > CMake Error at CMakeLists.txt:423 (message):
         >   Some external programs couldn't be found
         >
         >
         > -- Configuring incomplete, errors occurred!
```

**Status:** Removed

### ⚠️ [Hyprland](https://github.com/blank2121/nix-home/blob/3371726177041c17d9d6ba4688e519cbf2bf73bb/modules/default/home-manager/wayland/hyprland.nix#L16) configuration causes home-manager service to fail

**Details:** The configuration for Hyprland in [hyprland.nix](https://github.com/blank2121/nix-home/blob/3371726177041c17d9d6ba4688e519cbf2bf73bb/modules/default/home-manager/wayland/hyprland.nix) breaks configuration and makes the home-manager.service fail.

**Fix:** As all it does is symlink the dotfile hyprland.conf to `~/.config/hypr/hyprland.conf` I just commented it out and copied it myself.

**Status:** Removed. Set config manually.
