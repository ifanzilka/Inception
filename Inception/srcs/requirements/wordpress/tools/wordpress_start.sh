#!/bin/sh

check=$(find /var/www/html -name index.php | wc -l)

if [ $check -eq "0" ] ;
then
service php7.3-fpm start

# Скачеваем установочные файлы
wp core download    --allow-root --path="/var/www/html"

# Подключение к базе данных
wp core config	--allow-root \
				--skip-check \
				--dbname=$DB_NAME \
				--dbuser=$DB_USER \
				--dbpass=$DB_PASSWORD \
				--dbhost=$DB_HOST \
				--dbprefix=$DB_PREFIX \
				--path="/var/www/html"

# Устанавливаем и создаем администратора
wp core install	--allow-root \
				--url=$DOMAIN_NAME \
				--title="ecole 21" \
				--admin_user="bmarilli" \
				--admin_password="bmarilli" \
				--admin_email="bmarilli@student.21-school.ru" \
				--path="/var/www/html"


# Создаем еще 2 пользователей
wp user create      tor tor@bmarilli.42.com \
                    --role=author \
                    --user_pass="tor" \
                    --allow-root \
					--path="/var/www/html"

wp user create      loki loki@bmarilli.42.com \
                    --role=author \
                    --user_pass="loki" \
                    --allow-root \
					--path="/var/www/html"


#  Без этих записей не подгружеат таблицу стилей и остальной контент
sed "2idefine('WP_HOME','https://$DOMAIN_NAME');" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php
sed "2idefine('WP_SITEURL','https://$DOMAIN_NAME');" /var/www/html/wp-config.php >> /var/www/html/wp-config.php.new
mv /var/www/html/wp-config.php.new /var/www/html/wp-config.php


# Запускаем сервис чтобы создался сокет-файл, отлчючаем и запускаем на переднем плане
service php7.3-fpm stop ;
fi

php-fpm7.3 --nodaemonize
