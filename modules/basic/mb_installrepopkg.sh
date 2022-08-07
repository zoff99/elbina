#
# install os pkg from repo
#
# 1st param mandatory
#
# $1 <name>            packagename to install
# $2 u                 update pkg repo before installing selected package
#

echo "loading ${BASH_SOURCE[0]}"

mb_installrepopkg() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

pkgname="$1"

mb_getarch
if [ "$mb_arch""x" = "rhelx" ]; then
  yum install -q -y -- "$pkgname"
elif [ "$mb_arch""x" = "Darwinx" ]; then
  echo "not supported yet, NOOP"
elif [ "$mb_arch""x" = "ubuntux" ]; then
  if [ "${2:-''}""x" == "ux" ]; then
    DEBIAN_FRONTEND=noninteractive apt-get update
  fi
  DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --force-yes -- "$pkgname"
elif [ "$mb_arch""x" = "debianx" ]; then
  if [ "${2:-''}""x" == "ux" ]; then
    DEBIAN_FRONTEND=noninteractive apt-get update
  fi
  DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --force-yes -- "$pkgname"
elif [ "$mb_arch""x" = "solarisx" ]; then
  echo "Unsupported arch/os: ""$mb_arch"
  exit 98
else
  echo "Unknown arch/os: ""$mb_arch"
  exit 99
fi

}
