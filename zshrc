export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"               # Brew completions
export FPATH="$(brew --prefix curl)/share/zsh/site-functions:${FPATH}"          # Curl completions (missing from macos)
export FPATH="${HOME}/.oh-my-zsh/custom/plugins/zsh-completions/src:${FPATH}"   # ZSH extra completions (issue with adding to plugins https://github.com/zsh-users/zsh-completions/issues/603)
export FPATH="/nix/var/nix/profiles/default/share/zsh/site-functions:${FPATH}"  # Nix completions

export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=never'"                # Use bat to format man page output

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export LESS="iRF"
export EDITOR='nano'
export VISUAL='nano'

export ZSH_DOTENV_FILE=".env"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export ENABLE_CORRECTION="true"

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(direnv hook zsh)"
eval "$(conda shell.zsh hook)"

plugins=(dotenv extract rust timer urltools fzf
    fzf-tab zsh-autosuggestions zsh-syntax-highlighting)

. ~/.oh-my-zsh/oh-my-zsh.sh
. ~/.aliases
. ~/.functions

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' switch-group ',' '.'        # switch group using `,` and `.`

zstyle ':completion:complete:*:options' sort false
zstyle ':completion:*:git-checkout:*' sort false

zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

zstyle ':fzf-tab:complete:(-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps -p $word -o command -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr $word' # TODO: tldr completions seem to be missing...
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
zstyle ':fzf-tab:complete:*:*' fzf-preview '
    if   [[ -d ${realpath} ]]; then
        exa -lbFa --icons --git --no-user --no-time --no-permissions "${realpath}";
    elif which ${word} > /dev/null; then
        (out=$(tldr "$word") 2>/dev/null && echo $out) ||
        (out=$(man "$word") 2>/dev/null && echo $out | bat -l man --color=always --style="numbers") ||
        (out=$(which "$word") && echo $out) ||
        echo "${(P)word}";
    elif [[ -f ${realpath} ]]; then
        case "${realpath:l}" in
            (*.tar|*.tar.*|*.tgz|*.zip)  tar -tvf "${realpath}" ;;
            (*.png|*.jpg|*.jpeg) chafa -f symbols -s ${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES} "${realpath}" ;;
            (*) bat --color=always --style="numbers" "${realpath}" ;;
        esac
    else
        echo "${desc}";
    fi'
zstyle ':fzf-tab:complete:*:*' fzf-flags --preview-window=right:60% --height=80%

bindkey "\e[1;3D" backward-word     # ⌥←
bindkey "\e[1;3C" forward-word      # ⌥→

# Kitty shell integration
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

# The nix-daemon should be sourced within /etc/zshrc however it has gone missing on me a couple of times
if ! which nix > /dev/null && [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
