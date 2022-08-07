#
# add unix group
#
# all params mandatory
#
# $1 <name>            groupname to create
# $2 <id number>       group id number
#

echo "loading ${BASH_SOURCE[0]}"

mb_groupadd() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

groupname="$1"
groupid="$2"

mb_getarch
if [ "$mb_arch""x" = "Darwinx" ]; then
  set +Eeuo pipefail
  dscl . -read /Groups/"$groupname"
  res_num1=$?
  set -Eeuo pipefail

  if [ "$res_num1""x" == "0x" ]; then
    msg "${RED}group $groupname already exists${NOFORMAT}"
  else
    dscl . -create /Groups/"$groupname"
    dscl . -append /Groups/"$groupname" gid "$groupid"
    dscl . -append /Groups/"$groupname" passwd "*"
  fi
else
  res_num=$(c1grep '^'"$groupname"':' /etc/group|wc -l)

  if [ "$res_num""x" == "1x" ]; then
    msg "${RED}group $groupname already exists${NOFORMAT}"
  else
    groupadd -g "$groupid" "$groupname"
  fi
fi

}
