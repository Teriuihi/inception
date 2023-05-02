#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	chown -R mysql:mysql /var/lib/mysql

	# init database
	mysqld --initialize --basedir=/usr --datadir=/var/lib/mysql --user=mysql --verbose > /dev/null

	tmpfile=$(mktemp)
	if [ ! -f "$tmpfile" ]; then
		exit 1
	fi

	# https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
	cat << EOF > "$tmpfile"
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';

CREATE DATABASE $WP_DATABASE_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$WP_DATABASE_USR'@'%' IDENTIFIED by '$WP_DATABASE_PWD';
GRANT ALL PRIVILEGES ON $WP_DATABASE_NAME.* TO '$WP_DATABASE_USR'@'%';

FLUSH PRIVILEGES;
EOF
	# run init.sql
	/usr/sbin/mysqld --user=mysql --bootstrap < "$tmpfile"
	rm -f "$tmpfile"
fi

# allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/mysql/my.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/my.cnf

exec /usr/sbin/mysqld --user=mysql --console
