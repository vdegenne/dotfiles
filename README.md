
# pm2/nginx

To run all the pm2 services on boot :

- clone the `nginx` repo in the system
- make sure the `pm2.start.sh` script is executable
- then transfer `~/.config/systemd/user/pm2.service` file
- enable it `systemctl --user enable pm2` for boots
- start it for the current session `systemctl --user start pm2`

# Emacs keybindings in Chrome

## option 1: autokey

- transfer `~/.config/autokey/data/Emacs/` (there are hidden files too)
- run `autokey`

*note: recommended. switch to systemd if not working*

## option 2: systemd

- transfer `/usr/local/bin/chrome-emacs`, `~/.xbindkeysrc` and `~/.config/systemd/user/chrome-emacs.service`
- make sure `chrome-emacs` is executable
- enable it `systemctl --user enable chrome-emacs` for boots
- start it for the current session `systemctl --user start chrome-emacs`

## options 3: gnome tweak

- open `tweak` (after installing gnome-tweak)
- in `keyboard` menu check `emacs shortcuts`

*note: not recommended because no copy/paste support*

# Configure Emacs for Vim

- Install [Vimacs](https://www.vim.org/scripts/script.php?script_id=300).


# Color Emojis (fedora)

- Install the font
```bash
dnf install google-noto-emoji-color-fonts
```
- Transfer `/etc/fonts/local.conf`

# Rebind Caps Lock (fedora)

- install `gnome-tweaks-3` and open it
- go in `Keyboard & Mouse > Keyboard > Addtional Layout Options > Caps Lock behavior`

# Prevent Ctrl+S from freezing the terminal

`stty -ixon` or `stty stop undef`

[source](https://superuser.com/a/251455/686498)
