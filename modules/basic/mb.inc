# elbina main include
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

NOFORMAT=''
start_time=$(date +%s)

function backtrace() {
    local deptn=${#FUNCNAME[@]}

    echo "linenumber diff: ""$__DIFF_LINENO__"
    for ((i=1; i<$deptn; i++)); do
        local func="${FUNCNAME[$i]}"
        local line="${BASH_LINENO[$((i-1))]}"
        local src="${BASH_SOURCE[$((i-1))]}"
        printf '%*s' $i '' # indent
        echo "at: $func(), $src, line $line"
    done
}

function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds\n' $S
}

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h]

Script description here.

Available options:

-h, --help      Print this help and exit
EOF
  exit
}

cleanup() {
  exit_code=$?

  end_time=$(date +%s)
  runtime=$[ $end_time - $start_time ]
  echo -n "runtime: "
  displaytime "$runtime"

  trap - SIGINT SIGTERM ERR EXIT
  if [ "$exit_code""x" == "0x" ]; then
    echo "---  END  ---"
  else
    echo "ERR:""$exit_code"
    echo "*** ERROR ***"
  fi

  # TODO: script cleanup here?
  msg "${NOFORMAT}"
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

function mb_getarch() {
  try1=$(cat /etc/os-release |grep '^ID='|sed -e 's#^.*="##'|sed -e 's#^ID=##'|tr -d '"')
  mb_arch="$try1"
}

function mb_cutorpaddstr() {
 len=$1
 STRING="$2"
 if [ ${#STRING} -gt $len ]; then
    STR2="${STRING:0:$len}.." 2>/dev/null
 else
    STR2="$STRING                                                                                                                                                                                                               " 2>/dev/null    # add spaces here
    STR2="${STR2:0:$len}" 2>/dev/null
 fi
 echo "$STR2" 2>/dev/null
}

c1grep() { grep "$@" || test $? = 1; }

parse_params() {
  # default values of variables set from params
  flag=0
  param=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    --no-color) NO_COLOR=1 ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}


parse_params "$@"
setup_colors

msg "${NOFORMAT}"

######### load basic modules #########
curdir=$(pwd)
cd "$script_dir"/modules/basic/
for i in $(ls -1 *.sh) ; do
        . "$i"
done
cd "$curdir"
######### load basic modules #########

######### load custom modules #########
curdir=$(pwd)
cd "$script_dir"/modules/custom/
for i in $(ls -1 *.sh) ; do
        . "$i"
done
cd "$curdir"
######### load custom modules #########

