
# pm2/nginx

To run all the pm2 services on boot :

- clone the `nginx` repo in the system
- make sure the `pm2.start.sh` script is executable
- then transfer `~/.config/systemd/user/pm2.service` file
- enable it `systemctl --user enable pm2` for boots
- start it for the current session `systemctl --user start pm2`

# Emacs keybindings in Chrome

- transfer `/usr/local/bin/chrome-emacs` and `~/.config/systemd/user/chrome-emacs.service`
- make sure `chrome-emacs` is executable
- enable it `systemctl --user enable chrome-emacs` for boots
- start it for the current session `systemctl --user start chrome-emacs`