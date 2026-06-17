# Aliases

## Git
alias ga='git add'
alias gap='ga --patch'
alias gs='git switch'
alias gst='git status --short'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias gb='git branch'
alias gn='git checkout -b'
alias gi='git init'
alias gcl='git clone'

## System
alias ls='ls --color'
alias c='clear'
alias code='code .'
alias zed='zed .'

# Load Oh My Posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/theme.toml)"

# Set dir to store zinit and plugins
export ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Download zinit if not already installed
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  gcl https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source and load zinit
source "$ZINIT_HOME/zinit.zsh"

# Load plugins using zinit
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

autoload -Uz compinit && compinit

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"
if [[ "$CLAUDECODE" != "1" ]]; then
    eval "$(zoxide init --cmd cd zsh)"
fi

source <(echo 'export PATH="$HOME/.asdf/shims:$PATH"')

export PATH="$PATH:$DOTNET_ROOT"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$HOME/.local/bin:$PATH"

# Opt out of Azure Functions telemetry
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1

# SSH Agent
# ssh-add --apple-use-keychain ~/.ssh/git_signing_key
eval "$(ssh-agent -s)" > /dev/null
ssh-add --apple-use-keychain ~/.ssh/git_signing_key
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
# bun completions
[ -s "/Users/ekbe/.bun/_bun" ] && source "/Users/ekbe/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(/Users/ekbe/.local/bin/mise activate zsh)" # added by https://mise.run/zsh
eval "$(mise activate zsh)"
