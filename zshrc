# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"

export PATH=/sbin:$PATH                                             # Add system binaries to the path
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=never'"    # Use bat to format man page output
export ENABLE_CORRECTION="true"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(direnv hook zsh)"
eval "$(conda shell.zsh hook)"

plugins=(dotenv extract timer urltools zsh-autosuggestions zsh-syntax-highlighting)

. ~/.oh-my-zsh/oh-my-zsh.sh
. ~/.aliases
. ~/.functions

. $(brew --prefix fzf)/shell/key-bindings.zsh   # ^R history, ^T files
. $(brew --prefix fzf)/shell/completion.zsh     # **<TAB> for fzf completions in cd / kill / ssh / unset / export / unalias

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
