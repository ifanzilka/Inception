FROM debian:buster



RUN apt-get update
# Устанавливаем php и php-fpm, а так-же инструмент curl 
# (альтернатива для нашего случая wget)
# Чтобы скачать и установить wp-cli
RUN apt-get install -y php php-fpm php-common php-iconv php-json \
						php-gd php-curl php-xml php-mysqli php-imap\
						php-cgi php-pdo php-soap \
						php-xmlrpc php-posix php-gettext \
						php-ldap php-ctype php-dom \
						php-mbstring php-phar
RUN apt-get install -y curl
RUN apt-get install -y sudo



# Скачиваем wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Даем права на испольнения и переносить в /usr/local/bin/ 
# чтобы можно было исполнить из любой точки
# оболочки
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Подготовим место для wordpress файлов
RUN mkdir /var/www
RUN mkdir /var/www/html


COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Установить wordpress в указанную директорию


COPY ./tools/wordpress_start.sh /

CMD sh wordpress_start.sh
