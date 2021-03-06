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

use_brew cask 'docker'
use_apk 'community' 'docker'

require 'curl'
use_custom 'install_docker'

install_docker() {
  if has_cmd docker; then
    return
  fi

  # References:
  #   - https://www.docker.com/blog/happy-pi-day-docker-raspberry-pi/
  #   - https://howchoo.com/g/nmrlzmq1ymn/how-to-install-docker-on-your-raspberry-pi

  print "Installing Docker..."

  install_docker__path=$(deps "install-docker.sh")
  print "Downloading installation script..."
  cmd curl -sSL get.docker.com -o "$install_docker__path"
  print "Running installation script..."
  cmd sh "$install_docker__path"
  if test "$(whoami)" = "root"; then
    print "run as root: no user group set"
  else
    sudo_cmd usermod -aG docker "$USER"
  fi
}
