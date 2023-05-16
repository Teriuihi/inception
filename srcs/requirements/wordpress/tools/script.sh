#!/bin/bash


echo "test1"
# create directory to use in nginx container later and also to setup the wordpress conf
mkdir -p /var/www/html

cd /var/www/html

echo "test2"
rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

chmod +x wp-cli.phar 

mv wp-cli.phar /usr/local/bin/wp

echo "test3"
wp core download --allow-root

echo "test4"
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

echo "test5"
mv /wp-config.php /var/www/html/wp-config.php

echo "test6"
sed -i -r "s/db1/$db_name/1"   wp-config.php
sed -i -r "s/user/$db_user/1"  wp-config.php
sed -i -r "s/pwd/$db_pwd/1"    wp-config.php

echo wp core install --url="$DOMAIN_NAME/" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USR" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
wp core install --url="$DOMAIN_NAME/" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USR" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root

echo "test8"


wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

echo "test9"
wp theme install astra --activate --allow-root

echo "test10"
wp plugin update --all --allow-root

echo "test11"
 
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

echo "test12"
mkdir pp /run/php
/usr/sbin/php-fpm7.3 -F
