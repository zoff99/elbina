#
# install essential os pkg from repo
#

echo "loading ${BASH_SOURCE[0]}"

mb_install_essentials() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

mb_getarch

if [ "$mb_arch""x" = "rhelx" ]; then
  yum install -q -y -- rsync
  yum install -q -y -- vim
  dnf install -q -y telnet
  yum install -q -y -- nano
elif [ "$mb_arch""x" = "Darwinx" ]; then
  echo "not supported yet, NOOP"
elif [ "$mb_arch""x" = "ubuntux" ]; then
  DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --force-yes rsync
  DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --force-yes vim
  DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --force-yes telnet
  DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --force-yes nano
elif [ "$mb_arch""x" = "solarisx" ]; then
  echo "Unsupported arch/os: ""$mb_arch"
  exit 98
else
  echo "Unknown arch/os: ""$mb_arch"
  exit 99
fi

}
