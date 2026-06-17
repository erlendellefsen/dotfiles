# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository. It manages system dotfiles with GNU Stow for symlink creation and houses Claude Code customizations in the `.claude` folder. The `.claude` folder is symlinked to `$HOME/.claude`.

## Configuration Structure

### Git Configuration
- **Signing**: Configured for SSH-based commit signing
- **Template**: Uses commit template from `.config/git/template`
- **Custom URLs**: Shortcuts for GitHub repositories (`ee:` for personal, `it:` for Intility)

## File Management

When adding new dotfiles or Claude Code configurations:
1. Maintain the same directory structure as in `$HOME`
2. Remove the original file from `$HOME` after copying to dotfiles directory
3. Use `stow --adopt .` to create symlinks
4. Claude Code files in `.claude/` will be automatically available after symlinking

## Git Workflow

- **Never commit or push** — only suggest, never execute git commits or pushes
- When a logical checkpoint is reached, suggest committing and provide a ready-to-copy conventional commit message
- Commit format: `type(scope): short description` — scope is optional but used when it adds clarity; message is short and precise
- For bigger features not already on a branch, suggest a branch name
- When a feature is complete, suggest a PR description: concise title and bullet summary
