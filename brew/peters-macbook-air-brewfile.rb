tap "azure/functions"

# cask "android-studio"               # Android Studio (~/Library/Android/sdk/platform-tools/adb, ~/Library/Android/sdk/emulator/emulator)
brew "awscli"
brew "azure-cli"
brew "azure-functions-core-tools@4"   # Azure Functions Core Tools 4.0.0
cask "discord"
cask "firefox"
cask "google-chrome"
cask "iina"
cask "messenger"
cask "microsoft-teams"
# cask "ngrok"                        # Reverse proxy, secure introspectable tunnels to localhost
# cask "raycast"                      # spotlight alternative
cask "rectangle"
cask "shottr"
cask "steam"
cask "vpn-by-google-one"

#### VIRTUALISATION / CONTAINERISATION
# cask "docker"                       # Docker binary and desktop
# brew "qemu"                         # machine emulator and virtualizer
# cask "utm"                          # UI for qemu
# cask "xquartz"                      # XQuartz - X11
                                      # $ defaults write org.xquartz.X11 nolisten_tcp 0; # Allow Connections from Network Clients
                                      # $ open -a /Applications/Utilities/XQuartz.app/
                                      # Docker Args: -e DISPLAY="$(localip)":0 -e XAUTHORITY=/.Xauthority -v ~/.Xauthority:/.Xauthority

#### 3D PRINTING
# cask "freecad"                      # 3D CAD
# cask "ultimaker-cura"               # 3D printing slicer
