export EDITOR='nano'
export VISUAL='nano'

export LESS="iRFM"                                                      # i=ignore case, R=raw characters (colors), F=quit if everything fits on one page, M=long prompt
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=never'"        # Use bat to format man page output
export BAT_THEME="ansi"

export DOTFILES="${HOME}/dotfiles"
export NAVI_CONFIG="${DOTFILES}/navi/config.yml"
export ZSH_CUSTOM="${DOTFILES}/omz"
export STARSHIP_CONFIG="${DOTFILES}/starship.toml"

if which brew > /dev/null; then
    export HOMEBREW_BUNDLE_DIR="${DOTFILES}/brew"
    export HOMEBREW_BUNDLE_FILE="${HOMEBREW_BUNDLE_DIR}/Brewfile"
    export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"       # Brew completions
fi

export FPATH="$ZSH_CUSTOM/plugins/zsh-completions/src${FPATH:+:$FPATH}" # https://github.com/zsh-users/zsh-completions/issues/603

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS='--color=fg:#d0d0d0,bg:#121212,hl:#5f87af --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview-window=right:60% --height=80% --preview='bat --color=always --style=\"plain\" {}'"

export ZSH_DOTENV_FILE=".env"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
# export ENABLE_CORRECTION="true"

export ITERM2_SQUELCH_MARK=1 # disable iterm2_zsh_integration from automatically adding the prompt marks, we can configure this in starship instead

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(navi widget zsh)"       # ⌃G to open widget

unsetopt beep

plugins=(dotenv extract rust timer urltools
    fzf-tab zsh-autosuggestions zsh-syntax-highlighting)

. ~/.oh-my-zsh/oh-my-zsh.sh
. "${DOTFILES}/aliases"
. "${DOTFILES}/functions"
. "${DOTFILES}/iterm2/zsh_integration"

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:complete:*:options' sort false
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:(-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps -p $word -o command -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
zstyle ':fzf-tab:complete:*:*' fzf-flags --preview-window=right:60% --height=80%
zstyle ':fzf-tab:complete:*:*' fzf-preview '
    if   [[ -d ${realpath} ]]; then
        lsd -l --color always --blocks size,name "${realpath}";
    elif which ${word} > /dev/null; then
        (out=$(man "$word") 2>/dev/null && echo $out | bat -l man --color=always --style=plain) ||
        (out=$(which "$word") && echo $out) ||
        echo "${(P)word}";
    elif [[ -f ${realpath} ]]; then
        case "${realpath:l}" in
            (*.tar|*.tar.*|*.tgz|*.zip) tar -tvf "${realpath}" ;;
            (*) bat --color=always --style=plain "${realpath}" ;;
        esac
    else
        echo "${desc}";
    fi'
