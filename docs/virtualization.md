# Virtualization

## Podman

When initializing the podman machine, mount the home directory for volume mounting to work

```sh
podman machine init -v $HOME:$HOME
```

X11 Forwarding args: `-e DISPLAY="$(localip)":0 -e XAUTHORITY=/.Xauthority -v ~/.Xauthority:/.Xauthority`

## Ubuntu VM

Install with UTM

Run the following for a full desktop environment

```sh
sudo apt update && sudo apt install ubuntu-desktop
sudo reboot
```

## X11 Forwarding

Use XQuartz

```sh
brew install --cask xquartz

# Tell XQuartz to Allow Connections from Network Clients
defaults write org.xquartz.X11 nolisten_tcp 0;

# XQuartz needs to be running for X11 forwarding to work
open -a /Applications/Utilities/XQuartz.app/
```
