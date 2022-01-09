#
# append text to an existing file
#
# all params mandatory
#
# $1 <dest file>       absolute path of the destination file
# $2 <txt>             string to append to file (adding 1 newline before the string)
#                      '\' in text are not allowed!
#                      multiline text is not allowed!
#

echo "loading ${BASH_SOURCE[0]}"

mb_appendtofile() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

file="$1"
text="$2"

if [ ! -f "$file" ]; then
  echo "$file"" does not exist"
  exit 99
fi

if [ ! -r "$file" ]; then
  echo "$file"" is not readable"
  exit 99
fi

if [ ! -w "$file" ]; then
  echo "$file"" is not writeable"
  exit 99
fi

res_num=$(c1grep "$text" "$file"|wc -l)

if [ "$res_num""x" == "1x" ]; then
  msg "${RED}text already exists in file $file${NOFORMAT}"
else
  echo "$text" >> "$file"
fi


}
