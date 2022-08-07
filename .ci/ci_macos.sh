#!/bin/sh
git clone https://github.com/zoff99/elbina
cd elbina/

echo 'mb_groupadd gg 776
mb_useradd xxx 333 /home/xxx2 "reowprü3+3+ür23+" gg
mkdir -p /Users/xxx2
chown xxx:gg /Users/xxx2
mb_install_essentials
mb_installrepopkg qtox
' > test.txt

./elbina.sh test.txt
