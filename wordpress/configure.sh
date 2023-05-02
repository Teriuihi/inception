#!/bin/sh

# wait for mysql
while ! mariadb -h"$MYSQL_HOST" -u"$WP_DATABASE_USR" -p"$WP_DATABASE_PWD" "$WP_DATABASE_NAME" >/dev/null 2>/dev/null; do
    sleep 3
done

if [ ! -f "/var/www/html/index.html" ]; then

    # static website
    mv /tmp/index.html /var/www/html/index.html
fi

echo "Wordpress started on :9000"
/usr/sbin/php-fpm7 -F -R