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

depends 'tmux'

add_setup 'setup_tmux_plugins'

setup_tmux_plugins() {
  # install tmux plugin manager and its plugins
  if test -d "$HOME/.tmux/plugins/tpm"; then
    return
  fi

  step "Installing tmux plugin manager..."
  clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" "tpm"

  add_post_install_message 'Press <Prefix+I> for tmux plugins installation'
}
