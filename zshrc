export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"               # Brew completions
export FPATH="$(brew --prefix curl)/share/zsh/site-functions:${FPATH}"          # Curl completions (missing from macos)
export FPATH="${HOME}/.oh-my-zsh/custom/plugins/zsh-completions/src:${FPATH}"   # ZSH extra completions (issue with adding to plugins https://github.com/zsh-users/zsh-completions/issues/603)
export FPATH="/nix/var/nix/profiles/default/share/zsh/site-functions:${FPATH}"  # Nix completions

export EDITOR='nano'
export VISUAL='nano'

export LESS="iRFM" # i=ignore case, R=raw characters (colors), F=quit if everything fits on one page, M=long prompt
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=never'"                # Use bat to format man page output
export BAT_THEME="ansi"
export NAVI_CONFIG="${HOME}/.config/navi/config.yml"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
 --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
 --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
 --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'

export ZSH_DOTENV_FILE=".env"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
# export ENABLE_CORRECTION="true"

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(direnv hook zsh)"
eval "$(conda shell.zsh hook)"
eval "$(navi widget zsh)"       # ⌃G to open widget

plugins=(dotenv extract rust timer urltools
    fzf fzf-tab zsh-autosuggestions zsh-syntax-highlighting)

. ~/.oh-my-zsh/oh-my-zsh.sh
. ~/.aliases
. ~/.functions

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:complete:*:options' sort false
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

zstyle ':fzf-tab:*' switch-group ',' '.'        # switch group using `,` and `.`
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
        exa -lbFa --icons --git --no-user --no-time --no-permissions "${realpath}";
    elif which ${word} > /dev/null; then
        (out=$(man "$word") 2>/dev/null && echo $out | bat -l man --color=always --style="plain") ||
        (out=$(which "$word") && echo $out) ||
        echo "${(P)word}";
    elif [[ -f ${realpath} ]]; then
        case "${realpath:l}" in
            (*.tar|*.tar.*|*.tgz|*.zip)  tar -tvf "${realpath}" ;;
            (*.png|*.jpg|*.jpeg) chafa -f symbols -s ${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES} "${realpath}" ;;
            (*) bat --color=always --style="plain" "${realpath}" ;;
        esac
    else
        echo "${desc}";
    fi'

# Press ⌃V to check sequence
bindkey "^[[1;3D" backward-word     # ⌥ <-
bindkey "^[[1;3C" forward-word      # ⌥ ->
bindkey "^[[1;9D" beginning-of-line # ⌘ ->
bindkey "^[[1;9C" end-of-line       # ⌘ <-
bindkey "^U" backward-kill-line     # ⌘ delete

# The nix-daemon should be sourced within /etc/zshrc however it has gone missing on me a couple of times
if ! which nix > /dev/null && [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
