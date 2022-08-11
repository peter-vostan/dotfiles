# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

export EDITOR="nano"

export ZSH="$HOME/.oh-my-zsh"
plugins=(dotenv extract timer urltools zsh-autosuggestions zsh-syntax-highlighting)

# Add system binaries to the path
export PATH=/sbin:$PATH

# Use bat to format man page output
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=never'"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(direnv hook zsh)"
eval "$(conda shell.zsh hook)"

source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env
source $HOME/.aliases
source $HOME/.functions

bindkey "\e[1;3D" backward-word     # ⌥←
bindkey "\e[1;3C" forward-word      # ⌥→

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"