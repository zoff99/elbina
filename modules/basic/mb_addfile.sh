#
# add a file to a destination
#
# all params mandatory
#
# $1 <source file>     src with relative path to "$script_dir"/data/
# $2 <dest file>       absolute path of the destination file
# $3 <mode as number>  mode to create the destination file
# $4 <user>            owner of file to create
# $5 <group>           group of file to create
#

echo "loading ${BASH_SOURCE[0]}"

mb_addfile() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

srcfile="$script_dir""/data/""$1"
dstfile="$2"
mode="$3"
user="$4"
group="$5"

if [ ! -f "$srcfile" ]; then
  echo "$srcfile"" does not exist"
  exit 99
fi

if [ ! -r "$srcfile" ]; then
  echo "$srcfile"" is not readable"
  exit 99
fi

cp "$srcfile" "$dstfile"
chmod "$mode" "$dstfile"
chown "$user":"$group" "$dstfile"

}
