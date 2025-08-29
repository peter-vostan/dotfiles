{ lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "c2b4aa5";
          sha256 = "sha256-gvZp8P3quOtcy1Xtt1LAW1cfZ/zCtnAmnWqcwrKel6w=";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.35.0";
          sha256 = "sha256-GFHlZjIHUWwyeVoCpszgn4AmLPSSE8UVNfRmisnhkpg=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
      {
        name = "zsh-window-title";
        src = pkgs.fetchFromGitHub {
          owner = "olets";
          repo = "zsh-window-title";
          rev = "v1.2.0";
          sha256 = "sha256-RqJmb+XYK35o+FjUyqGZHD6r1Ku1lmckX41aXtVIUJQ=";
        };
      }
    ];
    profileExtra = ''
      [ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    # lib.mkOrder 1200 forces this to be loaded after other default initContent which is 1000
    initContent = lib.mkOrder 1200 ''
      . ~/.functions

      # Rebind navi to Ctrl-H so that fzf-git-sh can use Ctrl-G
      bindkey -r '^G'
      bindkey '^H' _navi_widget

      # Source fzf-git.sh for Git fuzzy bindings (e.g., Ctrl-G Ctrl-B for branches).
      source ${pkgs.fzf-git-sh}/share/fzf-git-sh/fzf-git.sh

      bindkey "\e[1;9C" end-of-line
      bindkey "\e[1;9D" beginning-of-line

      # ⌥+C binding for iterm2
      bindkey "ç" fzf-cd-widget

      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

      zstyle ':fzf-tab:*' switch-group ',' '.'
      zstyle ':fzf-tab:complete:(-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ''${(P)word}'
      zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps -p $word -o command -w'
      zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
      zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
      zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
      zstyle ':fzf-tab:complete:*:options' fzf-preview
      zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
      zstyle ':fzf-tab:complete:*:*' fzf-flags --preview-window=right:60% --height=80%
      zstyle ':fzf-tab:complete:*:*' fzf-preview '
          if   [[ -d ''${realpath} ]]; then
              lsd -l --color always --blocks size,name "''${realpath}";
          elif which ''${word} > /dev/null; then
              (out=$(man "$word") 2>/dev/null && echo $out | bat -l man --color=always --style=plain) ||
              (out=$(which "$word") && echo $out) ||
              echo "''${(P)word}";
          elif [[ -f ''${realpath} ]]; then
              case "''${realpath:l}" in
                  (*.tar|*.tar.*|*.tgz|*.zip) tar -tvf "''${realpath}" ;;
                  (*) bat --color=always --style=plain "''${realpath}" ;;
              esac
          else
              echo "''${desc}";
          fi'
    '';
  };
}
