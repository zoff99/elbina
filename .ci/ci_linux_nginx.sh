#!/bin/sh
apt-get update -qq
# apt-get install -y --force-yes --no-install-recommends git ca-certificates iproute2
git clone https://github.com/zoff99/elbina
cd elbina/

echo 'mc_install_nginx
' > test.txt

./elbina.sh test.txt
