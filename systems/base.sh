#!/bin/sh

set -e

if
  (! command -v print >/dev/null 2>&1) ||
  ! $(print 3 a b >/dev/null 2>&1) ||
  test "$(print 3 a b)" != "a  b";
then
  printf "Please run this script through \"install.sh\" instead"
  exit 1
fi

setup() {
  return
}

# update <mode>
#  mode:
#    update
#    upgrade
update() {
  return
}

# use_apk <repo> <package>
use_apk() {
  return
}

# use_apt <package>
use_apt() {
  return
}

# use_brew <package>
use_brew() {
  return
}

# use_dpkg <name> <url>
use_dpkg() {
  return
}

# use_docker <package>
use_docker_build() {
  if test -n "$_ADDED"; then
    return
  fi

  local package="$1"
  add_package docker "$package"
}
