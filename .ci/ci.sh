#!/bin/sh
apt-get update
apt-get install -y --force-yes --no-install-recommends git ca-certificates
git clone https://github.com/zoff99/elbina
cd elbina/

echo 'mb_groupadd gg 776
mb_useradd xxx 333 /home/xxx2 "reowprü3+3+ür23+" gg
mkdir -p /home/xxx2
chown xxx:gg /home/xxx2
mb_install_essentials
mb_installrepopkg qtox
' > test.txt

./elbina.sh test.txt
