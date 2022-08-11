tap "homebrew/bundle"
tap "homebrew/core"
tap "homebrew/cask"
tap "homebrew/cask-fonts"

brew "awscli"                       # AWS cli
brew "azure-cli"                    # Azure cli
brew "bat"                          # cat but with formatting
brew "direnv"                       # directory environment loader with nix support
brew "dua-cli"                      # Disk Usage Analyzer $ dua i
brew "exa"                          # modern replacement for ls
brew "fd"                           # find alternative
brew "fnm"                          # faster nvm
brew "fzf"                          # Fuzzy finder
brew "git"                          # Git
brew "git-town"                     # Git workflows
brew "htop"                         # Realtime info on running processes
brew "jq"                           # Json processor
brew "mas"                          # Mac Apple Store cli
# brew "openvpn"                      # openvpn client
brew "shellcheck"                   # linting for shell scripts
brew "socat"                        # SOcket CAT: netcat on steroids
brew "starship"                     # Starship prompt
brew "terraform"                    # Terraform
brew "tldr"                         # Simplified manpages
brew "websocat"                     # CLI for WebSockets

# cask "bitwarden"                    # Bitwarden from brew
cask "drawio"                       # drawio app
cask "fig"                          # Terminal autocomplete ui
cask "font-fira-code-nerd-font"     # nerd font
# cask "freecad"                      # 3D CAD
cask "firefox"                      # firefox browser
# cask "google-chrome"                # chrome browser
cask "iina"                         # modern media player
cask "kap"                          # sudo softwareupdate --install-rosetta
cask "kitty"                        # kitty terminal
cask "messenger"                    # Facebook messenger
cask "microsoft-teams"              # sudo softwareupdate --install-rosetta
cask "miniconda"                    # Environment management for python
# cask "ngrok"                        # Reverse proxy, secure introspectable tunnels to localhost
cask "raycast"                      # spotlight alternative
cask "rectangle"                    # drag / drop window docking
# cask "ultimaker-cura"               # 3D printing slicer
cask "visual-studio-code"           # vscode

# Containers / Virtualisation

brew "podman"                       # Open source alternative to docker ($ podman machine init -v $HOME:$HOME)
brew "podman-compose"               # docker-compose support for podman
cask "podman-desktop"               # Test this out
brew "qemu"                         # machine emulator and virtualizer
cask "utm"                          # UI for qemu
# cask "xquartz"                      # XQuartz - X11

# For X11 Forwarding: Tell XQuartz to Allow Connections from Network Clients
# $ defaults write org.xquartz.X11 nolisten_tcp 0;
# Run XQuartz in the background
# $ open -a /Applications/Utilities/XQuartz.app/
# Podman Args
# $ -e DISPLAY="$(localip)":0 -e XAUTHORITY=/.Xauthority -v ~/.Xauthority:/.Xauthority