#!/bin/sh
git clone https://github.com/zoff99/elbina
cd elbina/

echo 'mb_groupadd gg 776
mb_useradd xxx 333 /home/xxx2 "reowprü3+3+ür23+" gg
mb_install_essentials
' > test.txt

./elbina.sh test.txt
