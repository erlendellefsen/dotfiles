# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository. It manages system dotfiles with GNU Stow for symlink creation and houses Claude Code customizations in the `.claude` folder. The `.claude` folder is symlinked to `$HOME/.claude`.

Skills live as real directories in `.claude/skills/`. `$HOME/.agents/skills` is a symlink pointing there, so other agent tooling sees the same skills.

## Configuration Structure

### Git Configuration
- **Signing**: Configured for SSH-based commit signing
- **Template**: Uses commit template from `.config/git/template`
- **Custom URLs**: Shortcuts for GitHub repositories (`ee:` for personal, `it:` for Intility)

## File Management

When adding new dotfiles or Claude Code configurations:
1. Maintain the same directory structure as in `$HOME`
2. Copy the file into the dotfiles directory, then remove the original from `$HOME`
3. Run `stow .` from the repo root to create the symlinks
4. Claude Code files in `.claude/` are automatically available after symlinking

Only use `stow --adopt .` when intentionally pulling existing `$HOME` files into the repo; it overwrites repo content with the `$HOME` versions, so review the diff afterwards.

## Privacy & Sharing

This repo is shared with colleagues. Never commit secrets, tokens, or machine-specific private data. Runtime state under `.claude/` stays gitignored.

## Git Workflow

- **Never commit or push**: only suggest, never execute git commits or pushes
- When a logical checkpoint is reached, suggest committing and provide a ready-to-copy conventional commit message
- Commit format: `type(scope): short description`. Scope is optional but used when it adds clarity; message is short and precise
- For bigger features not already on a branch, suggest a branch name
- When a feature is complete, suggest a PR description: concise title and bullet summary
