#
# edit an existing file
#
# all params mandatory
#
# $1 <dest file>       absolute path of the destination file
# $2 <regex>           regex to replace
# $3 <replacemnt txt>  string (no regex) to replace with
#

echo "loading ${BASH_SOURCE[0]}"

mb_editfile() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""

file="$1"
regexin="$2"
textout="$3"

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

sperator='/'
sep=0
if [[ "$regexin" == *'/'* ]]; then
  sep=1
fi
if [[ "$textout" == *'/'* ]]; then
  sep=1
fi

if [ $sep == 1 ]; then
  sperator='#'
  if [[ "$regexin" == *'#'* ]]; then
    echo "can not find a seperator"
    exit 99
  elif [[ "$textout" == *'#'* ]]; then
    echo "can not find a seperator"
    exit 99
  fi
fi

echo "using seperator char: ""$sperator"

mb_getarch
if [ "$mb_arch""x" = "rhelx" ]; then
  sed -i -e "s"$sperator"${regexin}"$sperator"${textout}"$sperator "$file"
elif [ "$mb_arch""x" = "solarisx" ]; then
  gsed -i -e "s"$sperator"${regexin}"$sperator"${textout}"$sperator "$file"
else
  sed -i -e "s"$sperator"${regexin}"$sperator"${textout}"$sperator "$file"
fi

}
