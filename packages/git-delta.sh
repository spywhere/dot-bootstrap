#!/bin/sh

set -e

if
  (! command -v force_print >/dev/null 2>&1) ||
  ! $(force_print 3 a b >/dev/null 2>&1) ||
  test "$(force_print 3 a b)" != "a  b";
then
  printf "Please run this script through \"install.sh\" instead"
  exit 1
fi

require 'curl'

use_brew formula 'git-delta'
use_dpkg 'git-delta' 'https://github.com/dandavison/delta/releases/download/0.6.0/git-delta_0.6.0_armhf.deb'
