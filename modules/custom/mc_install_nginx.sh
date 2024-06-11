#
# install nginx with self signed cert listen on all IPs on port 443
#
#

echo "loading ${BASH_SOURCE[0]}"

mc_install_nginx() {

echo -n "${FUNCNAME[0]}"
for ARG in "$@"; do
    echo -n " "'"'
    echo -n $ARG
    echo -n '"'
done
echo ""


mb_getarch
if [ "$mb_arch""x" = "rhelx" ]; then
  mb_installrepopkg nginx u
  mb_installrepopkg openssl

  openssl req -new -newkey rsa:4096 -nodes \
    -keyout localhost.key -out localhost.csr \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"
  openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
    -keyout localhost.key  -out localhost.crt

  mkdir -p /etc/ssl/certs/
  mkdir -p /etc/ssl/private/
  cp localhost.crt /etc/ssl/certs/localhost.crt
  cp localhost.key /etc/ssl/private/localhost.key
  mkdir -p /etc/nginx/sites-available/
  mkdir -p /etc/nginx/sites-enabled/
  mkdir -p /usr/share/nginx/logs/
  mkdir -p /var/www/html/
  mb_addfile mc_install_nginx/default.cfg /etc/nginx/sites-enabled/default 644 root root
  mb_addfile mc_install_nginx/rhdefault.cg /etc/nginx/nginx.conf 644 root root
  mb_addfile mc_install_nginx/index.html /var/www/html/index.html 644 root root

  /usr/bin/rm -f /run/nginx.pid
  /usr/sbin/nginx -t
  /usr/sbin/nginx

elif [ "$mb_arch""x" = "rockyx" ]; then
  mb_installrepopkg nginx u
  mb_installrepopkg openssl

  openssl req -new -newkey rsa:4096 -nodes \
    -keyout localhost.key -out localhost.csr \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"
  openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
    -keyout localhost.key  -out localhost.crt

  mkdir -p /etc/ssl/certs/
  mkdir -p /etc/ssl/private/
  cp localhost.crt /etc/ssl/certs/localhost.crt
  cp localhost.key /etc/ssl/private/localhost.key
  mkdir -p /etc/nginx/sites-available/
  mkdir -p /etc/nginx/sites-enabled/
  mkdir -p /usr/share/nginx/logs/
  mkdir -p /var/www/html/
  mb_addfile mc_install_nginx/default.cfg /etc/nginx/sites-enabled/default 644 root root
  mb_addfile mc_install_nginx/rhdefault.cg /etc/nginx/nginx.conf 644 root root
  mb_addfile mc_install_nginx/index.html /var/www/html/index.html 644 root root

  /usr/bin/rm -f /run/nginx.pid
  /usr/sbin/nginx -t
  /usr/sbin/nginx

elif [ "$mb_arch""x" = "Darwinx" ]; then
  echo "not supported yet, NOOP"
elif [ "$mb_arch""x" = "ubuntux" ]; then
  mb_installrepopkg nginx u
  mb_installrepopkg openssl

  openssl req -new -newkey rsa:4096 -nodes \
    -keyout localhost.key -out localhost.csr \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"
  openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
    -keyout localhost.key  -out localhost.crt

  mkdir -p /etc/ssl/certs/
  mkdir -p /etc/ssl/private/
  cp localhost.crt /etc/ssl/certs/localhost.crt
  cp localhost.key /etc/ssl/private/localhost.key
  mb_addfile mc_install_nginx/default.cfg /etc/nginx/sites-available/default 644 root root
  mb_addfile mc_install_nginx/index.html /var/www/html/index.html 644 root root
  /etc/init.d/nginx start

elif [ "$mb_arch""x" = "debianx" ]; then
  mb_installrepopkg nginx u
  mb_installrepopkg openssl

  openssl req -new -newkey rsa:4096 -nodes \
    -keyout localhost.key -out localhost.csr \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"
  openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
    -keyout localhost.key  -out localhost.crt

  mkdir -p /etc/ssl/certs/
  mkdir -p /etc/ssl/private/
  cp localhost.crt /etc/ssl/certs/localhost.crt
  cp localhost.key /etc/ssl/private/localhost.key
  mb_addfile mc_install_nginx/default.cfg /etc/nginx/sites-available/default 644 root root
  mb_addfile mc_install_nginx/index.html /var/www/html/index.html 644 root root
  /etc/init.d/nginx start

elif [ "$mb_arch""x" = "solarisx" ]; then
  echo "Unsupported arch/os: ""$mb_arch"
  exit 98
else
  echo "Unknown arch/os: ""$mb_arch"
  exit 99
fi

}
