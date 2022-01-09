#!/usr/bin/env bash
############################################################
#
# [elbina], and open source application-deployment tool in pure bash
# using only POSIX shell commands and tools.
#
# requires `bash`
#
# Copyright (C) 2022 Zoff <zoff@zoff.cc>
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#
############################################################

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM EXIT
trap backtrace ERR

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
echo "script_dir=$script_dir"

. "$script_dir"/modules/basic/mb.inc

######### YOUR CUSTOM commands start HERE #########
######### YOUR CUSTOM commands start HERE #########

msg "throwing: ""$1"

if [ -d "$1" ]; then
  echo "$1"" is a directory"
  exit 99
fi

if [ ! -f "$1" ]; then
  echo "$1"" does not exist"
  exit 99
fi

if [ ! -r "$1" ]; then
  echo "$1"" is not readable"
  exit 99
fi

if [[ "$1" != *.txt ]]; then
  echo "$1"" does not have .txt ending"
  exit 99
fi

__DIFF_LINENO__=$LINENO
. "$1"

######### YOUR CUSTOM commands end   HERE #########
######### YOUR CUSTOM commands end   HERE #########
