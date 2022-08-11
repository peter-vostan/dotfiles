# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

export EDITOR="nano"
export PATH=/sbin:$PATH                                             # Add system binaries to the path
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=never'"    # Use bat to format man page output
export ENABLE_CORRECTION="true"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(direnv hook zsh)"
eval "$(conda shell.zsh hook)"

plugins=(dotenv extract timer urltools zsh-autosuggestions zsh-syntax-highlighting)

source $HOME/.oh-my-zsh/oh-my-zsh.sh
source $HOME/.cargo/env
source $HOME/.aliases
source $HOME/.functions

bindkey "\e[1;3D" backward-word     # ⌥←
bindkey "\e[1;3C" forward-word      # ⌥→

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
