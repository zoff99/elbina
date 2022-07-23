#
# create dir or dirs
#
# all params mandatory
#
# $1 <name>            absolute path of directory to create
# $2 y|n               create directories in between also if missing
# $3 <mode as number>  mode to create directories with
# $4 <user>            owner of directory to create
# $5 <group>           group of directory to create
#

echo "loading ${BASH_SOURCE[0]}"

mb_createdir() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

dir="$1"
between="$2"
mode="$3"

if [ "$2x" == "yx" ]; then
	mkdir -p --mode="$3" "$1"
else
	mkdir --mode="$3" "$1"
fi

# change mode again, if directory already exists
chmod "$3" "$1"

chown "$4":"$5" "$1"

}
