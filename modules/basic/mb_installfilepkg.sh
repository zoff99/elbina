#
# install os pkg from local file
#
# all params mandatory
#
# $1 <name>            package file to install, with path
#

echo "loading ${BASH_SOURCE[0]}"

mb_installfilepkg() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

filename="$1"

mb_getarch
if [ "$mb_arch""x" = "rhelx" ]; then
  yum install -q -y -- "$filename"
elif [ "$mb_arch""x" = "rockyx" ]; then
  yum install -q -y -- "$filename"
elif [ "$mb_arch""x" = "ubuntux" ]; then
  dpkg -i -- "$filename"
elif [ "$mb_arch""x" = "solarisx" ]; then
  echo "Unsupported arch/os: ""$mb_arch"
  exit 98
else
  echo "Unknown arch/os: ""$mb_arch"
  exit 99
fi

}
