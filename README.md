# My dotfiles

This is a personal dotfiles repository that serves dual purposes:
1. Managing system dotfiles with GNU Stow for symlink creation
2. Housing Claude Code customizations (commands, actions, settings) in the `.claude` folder

## Included
- zshrc
- zprofile
- ghostty
- linearmouse
- gh
- gitconfig
- ohmyposh
- **Claude Code integration** (.claude folder with custom commands, settings, and documentation)

---

`dotfiles` directory is placed in the `$HOME` folder.

```bash
cd $HOME
mkdir dotfiles
cd dotfiles
git clone git@github.com:ErlendEllefsen/dotfiles.git
```

## Adding dotfiles
**Important**
- When copying over dotfiles to the `dotfiles` directory they need to keep the same layout as if they were in the `$HOME` folder.
- Remember to delete the dotfile in the `$HOME` directory after copying it to the `dotfiles` directory.

## Using GNU Stow to create symlinks
Just install `stow` and run `stow .` in your `dotfiles` directory.
```bash
brew install stow
cd dotfiles
stow --adopt .
```

## Claude Code Configuration

The `.claude` folder contains Claude Code-specific configurations and is symlinked to `$HOME/.claude`:

### Custom Commands
- **create-command.md**: Utility for creating new Claude Code commands
- **pre-commit-review.md**: Workflow command for automated pre-commit code reviews

### Documentation
- **commands-guide.md**: Comprehensive guide for creating and managing custom commands
- **organization-guide.md**: Best practices for organizing Claude Code workflows

### Settings
- **settings.json**: Claude Code configuration with custom themes, tools, and integrations
- Includes shell integration optimizations and environment variable handling

### Features Added
- Custom command framework for extending Claude Code functionality
- Pre-commit workflow automation for code quality
- Comprehensive documentation and guides
- Optimized shell integration with zoxide conflict prevention

