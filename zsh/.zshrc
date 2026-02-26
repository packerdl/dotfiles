# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy/mm/dd"

plugins=(
  colored-man-pages
  docker
  docker-compose
  git
  nvm
  rsync
  you-should-use
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Lazy-load nvm on first use for faster startup
zstyle ':omz:plugins:nvm' lazy yes

# Skip the update check run on every new shell
DISABLE_AUTO_UPDATE="true"

# Skip $fpath permission checks before compinit runs. These checks guard
# against another user on a shared system injecting malicious autoloaded
# functions, a threat that doesn't apply on a single-user machine where
# only you can write to $fpath.
DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

# Only allow unique entries in the PATH variable.
# This avoids duplicate path entries in nested zsh sessions.
typeset -U path
path+=(
  "${HOME}/.cargo/bin"
  "${HOME}/.local/bin"
  "${HOME}/.rbenv/bin"
  "${HOME}/scripts"
)

fpath+=(
  # Additional completion definitions
  # https://github.com/zsh-users/zsh-completions
  "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src"
)

# Starship prompt
# https://github.com/starship/starship
if type starship > /dev/null; then
  eval "$(starship init zsh)"
fi

# Ruby version manager
# https://github.com/rbenv/rbenv
if type rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

# Bitwarden SSH Agent support
[ -S "$HOME/.bitwarden-ssh-agent.sock" ] && export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

[ -f ~/.aliases ] && source ~/.aliases

if [ -f ~/.env ]; then
  source ~/.env
fi

# Ensure GPG_TTY is properly set for gpg-agent's Pinentry program
# https://www.gnupg.org/(it)/documentation/manuals/gnupg/Common-Problems.html
export GPG_TTY=$(tty)

# Load command-line fuzzy finder if present
# https://github.com/junegunn/fzf
type fzf > /dev/null && source <(fzf --zsh)
