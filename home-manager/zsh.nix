{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true; # TODO: something like environment.pathsToLink = [ "/share/zsh" ]; will also be needed for the system packages
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
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
    ];
    initExtra = ''
      git-prune-branches () {
        local branches
        gum spin --spinner points --title "Fetching..." -- git fetch --prune --tags
        echo "Branches"
        git --no-pager branch -vv
        echo ""
        branches=$(git branch -vv | grep gone | awk "{print $1}")
        if [[ "''${branches}" ]]; then
          echo "Dangling branches found"
          echo "''${branches}" | gum choose --no-limit | xargs git branch -D
        else
          echo "No dangling branches found"
        fi
      }

      enable-sudo-touch-id () {
        if [[ "$OSTYPE" == "darwin"* ]]; then
          if ! grep 'pam_tid.so' /etc/pam.d/sudo > /dev/null; then
            sudo sed -i "" "1a\
      auth       sufficient     pam_tid.so
            " /etc/pam.d/sudo
          else
            echo "Already enabled"
          fi
        else
          echo "Unsupported OS Type '$OSTYPE'"
        fi
      }

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
