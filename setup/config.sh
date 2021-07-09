#!/bin/sh

set -e

if
  ! (command -v force_print >/dev/null 2>&1) ||
  ! (force_print 3 a b >/dev/null 2>&1) ||
  test "$(force_print 3 a b)" != "a  b";
then
  printf "Please run this script through \"install.sh\" instead"
  exit 1
fi

add_setup 'setup_config'

setup_config() {
  step "Setting up configurations..."

  if has_package alacritty; then
    link alacritty/alacritty.yml .alacritty.yml
  fi

  # asdf
  link asdf/asdf .tool-versions
  link asdf/npm-packages .default-npm-packages
  link asdf/python-packages .default-python-packages

  if ! test -d "$HOME/.config"; then
    cmd mkdir -p "$HOME/.config"
  fi

  # bat
  link bat/ .config/bat

  # git
  link git/gitalias .gitalias
  link git/gitconfig .gitconfig
  if test -f "$HOME/$DOTFILES/configs/git/gitconfig.$OS"; then
    link "git/gitconfig.$OS" .gitconfig.platform
  elif test -f "$HOME/$DOTFILES/configs/git/gitconfig.$OSKIND"; then
    link "git/gitconfig.$OSKIND" .gitconfig.platform
  else
    warn "No platform specific git configuration for \"$OSNAME\""
  fi
  link git/gitignore .gitignore_global

  # github
  link github/ .config/github

  if has_package iterm2; then
    link iterm2/ "Library/Application Support/iTerm2"
  fi

  if has_package kitty; then
    link kitty/ .config/kitty
  fi

  # mpd
  link mpd/ .mpd

  # mycli
  link mycli/myclirc .myclirc

  # ncmpcpp
  link ncmpcpp/ .ncmpcpp

  # neomutt
  link neomutt/ .config/neomutt

  # nvim
  link nvim/ .config/nvim
  add_post_install_message "Run 'nvim' for the first time setup"

  # ssh
  link ssh/ .ssh

  # tig
  link tig/tig.conf .tigrc

  # tmux
  link tmux/tmux.conf .tmux.conf

  # wakatime
  if ! test -f "$HOME/.wakatime.cfg"; then
    # copy instead as file can contain a secret
    copy wakatime/wakatime.cfg .wakatime.cfg
  fi

  # w3m
  link w3m/ .w3m

  # zsh
  link zsh/zshrc .zshrc
}
