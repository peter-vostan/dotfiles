eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Enable sudo touch id auth if it isn't already
    if ! grep 'pam_tid.so' /etc/pam.d/sudo > /dev/null && gum confirm "Enable sudo touch id?"; then
        sudo sed -i '' '1a\
auth       sufficient     pam_tid.so
        ' /etc/pam.d/sudo
    fi
fi
