#
# add unix user
#
# all params mandatory
#
# $1 <name>            username to create
# $2 <uid number>      user id number
# $3 <homedir>         user homedir
# $4 <comment>         text in the comment field of /etc/passwd
# $5 <gid>             login group id
#

echo "loading ${BASH_SOURCE[0]}"

mb_useradd() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

username="$1"
userid="$2"
homedir="$3"
comment="$4"
gid="$5"
shell="/bin/bash"

mb_getarch
if [ "$mb_arch""x" = "Darwinx" ]; then
  set +Eeuo pipefail
  dscl . -read /Users/"$username"
  res_num1=$?
  set -Eeuo pipefail

  if [ "$res_num1""x" == "0x" ]; then
    msg "${RED}user $username already exists${NOFORMAT}"
  else
    dscl . -create /Users/"$username"
    dscl . -create /Users/"$username" UserShell "$shell"
    dscl . -create /Users/"$username" RealName "$comment"
    dscl . -create /Users/"$username" UniqueID "$userid"
    dscl . -create /Users/"$username" PrimaryGroupID "$gid"
    dscl . -create /Users/"$username" NFSHomeDirectory "$homedir"
  fi
else

  res_num=$(c1grep '^'"$username"':' /etc/passwd|wc -l)

  if [ "$res_num""x" == "1x" ]; then
    msg "${RED}user $username already exists${NOFORMAT}"
  else
    useradd -c "$comment" -d "$homedir" -u "$userid" -g "$gid" -s "$shell" "$username"
  fi
fi

}
