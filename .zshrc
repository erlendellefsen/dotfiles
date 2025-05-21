# Git alias
alias ga='git add'
alias gap='ga --patch'
alias gs='git status --short'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias gb='git branch'
alias gn='git checkout -b'
alias gi='git init'
alias gcl='git clone'

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

DISABLE_MAGIC_FUNCTIONS="true"

plugins=(git
	 asdf
	 azure
 	 brew
	 docker
	 docker-compose
	 deno
	 mix
	 mix-fast
	 npm
	 ssh
	 ssh-agent
	 vscode
	 colorize 
	 zsh-autosuggestions
	 command-time
)

source $ZSH/oh-my-zsh.sh

source <(echo 'export PATH="$HOME/.asdf/shims:$PATH"')

export DOTNET_ROOT="/Users/ekbe/.asdf/installs/dotnet/9.0.101"
export PATH="$PATH:$DOTNET_ROOT"
export PATH="$PATH:$HOME/.dotnet/tools"

source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
