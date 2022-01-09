#
# unpack file to destination directory
#
# all params mandatory
#
# $1 <archive file>    src with relative path to "$script_dir"/data/
# $2 <dest dir>        absolute path of the destination directory
# $3 <archive type>    supported types for now: "tgz"
#

echo "loading ${BASH_SOURCE[0]}"

mb_unarchive() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

archfile="$script_dir""/data/""$1"
dstdir="$2"
archtype="$3"

if [ ! -f "$archfile" ]; then
  echo "$archfile"" does not exist"
  exit 99
fi

if [ ! -r "$archfile" ]; then
  echo "$archfile"" is not readable"
  exit 99
fi

if [ ! -d "$dstdir" ]; then
  echo "$dstdir"" does not exists or is not a directory"
  exit 99
fi

if [ "$archtype""x" != "tgzx" ]; then
  echo "archive type $archtype not supported"
  exit 99
fi

curdir=$(pwd)

cd "$dstdir"

if [ "$archtype""x" == "tgzx" ]; then
  tar -xzf "$archfile"
fi

cd "$curdir"

}
