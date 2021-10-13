# Запускаем СУБД

#для сокет файла
service mysql start


# Проверяем существует ли пользователь, если нет то создаем
find_my_user=$(echo "SELECT USER from mysql.user;" | mysql --no-defaults -u root | grep "$DB_USER" | wc -l)

# -ne (not equal)
if [ "1" -ne $find_my_user ] ;
	then 
		echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" | mysql --no-defaults -u root
		echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;" | mysql --no-defaults -u root
		echo "FLUSH PRIVILEGES;" | mysql --no-defaults -u root ;
fi

# Проверяем существует ли база данных, если нет то создаем
find_my_database=$(echo "SHOW DATABASES;" | mysql --no-defaults -u root | grep "$DB_NAME" | wc -l)

if [ "1" -ne $find_my_database ] ;
	then echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" | mysql --no-defaults -u $DB_USER --password="$DB_PASSWORD" ;
	echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');" | mysql --no-defaults -u root ;
fi


# Отключаем, чтобы перезапустить вне фонового режима
service mysql stop

#ытается запустить исполнимую программу, названную mysqld.
mysqld_safe