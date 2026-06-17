# My dotfiles

Personal dotfiles repository for macOS managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

### Required
```bash
brew install --cask ghostty      # Terminal emulator
brew install stow                # Symlink manager
brew install oh-my-posh          # Prompt theming
brew install fzf                 # Fuzzy finder
brew install zoxide              # Smarter cd command
brew install mise                # Version manager
```

### Optional
```bash
brew install --cask linear-mouse # Mouse customization
brew install gh                  # GitHub CLI
```

### Installed automatically
- **Zinit** - Plugin manager (auto-installs on first shell load)
- **zsh-autosuggestions** - Command suggestions
- **zsh-completions** - Additional completions
- **zsh-syntax-highlighting** - Syntax coloring
- **fzf-tab** - Fuzzy tab completion

## Installation

```bash
cd $HOME
git clone git@github.com:ErlendEllefsen/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --adopt .
```

## Included Configs
- `.zshrc` / `.zprofile` - Shell configuration
- `.config/ghostty/` - Terminal settings
- `.config/ohmyposh/` - Prompt theme
- `.config/linearmouse/` - Mouse settings
- `.config/gh/` - GitHub CLI
- `.config/git/` - Git configuration
- `.config/tmux/` - tmux configuration
- `.config/zed/` - Zed editor settings
- `.claude/` - Claude Code commands and settings

## Adding New Dotfiles

1. Copy file to `dotfiles/` keeping the same path structure as `$HOME`
2. Delete the original from `$HOME`
3. Run `stow --adopt .` to create symlinks
