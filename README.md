# My dotfiles

## Included
- zshrc
- zprofile
- ghostty
- linearmouse
- gh
- gitconfig

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

