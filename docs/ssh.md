# SSH

## New Key

Refer to <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>

## Multiple Github Accounts

In order to manage SSH key's for multiple github accounts, create separate host configurations in `~/.ssh/config`

For example

```txt
Host github.com
  HostName github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/github.com

Host other.github.com
  HostName github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/other.github.com
```
