# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

export PATH=/sbin:$PATH                                             # Add system binaries to the path
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=never'"    # Use bat to format man page output
export ENABLE_CORRECTION="true"

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(direnv hook zsh)"
eval "$(conda shell.zsh hook)"

plugins=(dotenv extract timer urltools zsh-autosuggestions zsh-syntax-highlighting)

. $HOME/.oh-my-zsh/oh-my-zsh.sh
. $HOME/.aliases
. $HOME/.functions

bindkey "\e[1;3D" backward-word     # ⌥←
bindkey "\e[1;3C" forward-word      # ⌥→

# Kitty shell integration
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
