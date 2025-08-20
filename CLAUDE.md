# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that serves dual purposes:
1. Managing system dotfiles with GNU Stow for symlink creation
2. Housing Claude Code customizations (commands, actions, settings) in the `.claude` folder

The `.claude` folder is symlinked to `$HOME/.claude` and contains Claude Code-specific configurations and custom commands.

## Setup and Installation Commands

```bash
# Install GNU Stow (required for symlink management)
brew install stow

# Install dotfiles and Claude Code configs in home directory
cd $HOME/dotfiles
stow --adopt .

# Clone repository to dotfiles directory
cd $HOME
mkdir dotfiles
cd dotfiles
git clone git@github.com:ErlendEllefsen/dotfiles.git
```

## Claude Code Configuration

### Custom Commands
- Custom Claude Code commands are stored in `.claude/commands/`
- Use these commands to extend Claude Code functionality
- Command files should follow the documented Claude Code command format

### Settings and Actions
- Claude Code settings are managed in `.claude/settings.json`
- Local settings overrides can be placed in `.claude/settings.local.json` (gitignored)
- Custom actions and workflows can be added to extend Claude Code capabilities

## Shell Configuration Architecture

### Core Shell Setup
- **Zsh**: Primary shell with extensive customization
- **Oh My Posh**: Prompt theming using custom TOML configuration
- **Zinit**: Plugin manager for zsh plugins
- **Key plugins**: zsh-autosuggestions, zsh-completions, zsh-syntax-highlighting, fzf-tab

### Claude Code Integration
- The shell configuration includes a `CLAUDECODE` environment variable check
- Disables zoxide integration when running in Claude Code to prevent conflicts
- Ensures optimal compatibility with Claude Code's environment

## Configuration Structure

### Git Configuration
- **Signing**: Configured for SSH-based commit signing
- **Template**: Uses commit template from `.config/git/template`
- **Custom URLs**: Shortcuts for GitHub repositories (`ee:` for personal, `it:` for Intility)

### Application Configurations
- **Ghostty**: Terminal with catppuccin-frappe theme
- **Linear Mouse**: Custom mouse settings for Logitech devices
- **GitHub CLI**: Configured with aliases and HTTPS protocol

### Directory Layout
```
.claude/           # Claude Code configurations (symlinked to HOME)
├── commands/      # Custom Claude Code commands
├── settings.json  # Claude Code settings
└── ...           # Other Claude Code files

.config/
├── git/          # Git configuration and templates
├── ohmyposh/     # Prompt theme configuration
├── ghostty/      # Terminal configuration
├── linearmouse/  # Mouse settings
└── gh/           # GitHub CLI settings
```

## Git Aliases Reference

Key aliases available in the shell:
- `gs` → `git switch` (branch switching)
- `gst` → `git status --short` (concise status)
- `ga` → `git add`
- `gc` → `git commit`
- `gp` → `git push`
- `gu` → `git pull`
- `gl` → `git log --graph --all --pretty` (visual log)

## File Management

When adding new dotfiles or Claude Code configurations:
1. Maintain the same directory structure as in `$HOME`
2. Remove the original file from `$HOME` after copying to dotfiles directory
3. Use `stow --adopt .` to create symlinks
4. Claude Code files in `.claude/` will be automatically available after symlinking

## Development Workflow

- **Editor**: VS Code is configured as the default Git editor
- **Terminal**: Ghostty with Catppuccin Frappe theme
- **Shell History**: Extensive history configuration with deduplication
- **Completions**: Advanced tab completion with fzf integration