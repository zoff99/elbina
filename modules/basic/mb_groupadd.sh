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

res_num=$(c1grep '^'"$groupname"':' /etc/group|wc -l)

if [ "$res_num""x" == "1x" ]; then
  msg "${RED}group $groupname already exists${NOFORMAT}"
else
  groupadd -g "$groupid" "$groupname"
fi

}
