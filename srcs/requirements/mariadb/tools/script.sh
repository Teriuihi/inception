#!/bin/bash



service mysql start 

mysql -e "CREATE DATABASE IF NOT EXISTS $db1_name ;"
mysql -e "CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;"
mysql -e "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pwd' ;"
mysql -e "CREATE DATABASE IF NOT EXISTS $db_name ;"
mysql -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%' ;"
mysql -e "GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '' ;"
mysql -e "FLUSH PRIVILEGES;"

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
