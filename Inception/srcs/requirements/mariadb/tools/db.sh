#!/usr/bin/env bash

# Config
mv /tools_dir/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Права
chown -R mysql:mysql /var/lib/mysql
chmod 755 -R /var/lib/mysql

# 
mysql_install_db --user=mysql --ldata=/var/lib/mysql
service mysql start

db_name='wp_base'
username='bmarilli'
password='dbpass'
hostname='localhost'

# WordPress database create and add users
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $db_name;"
mysql -u root -e "CREATE USER  IF NOT EXISTS '$username'@'%' IDENTIFIED BY '$password';"
mysql -u root -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'root';"
#mysql  -e "CREATE USER 'adminwp'@'localhost' IDENTIFIED BY 'adminwp';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$username'@'%' WITH GRANT OPTION;"
mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO 'root'@'%' WITH GRANT OPTION;"
mysql -u root -e "UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='$username';"
mysql -u root -e "FLUSH PRIVILEGES;"

#mysql < create_db.sql

exec "$@"