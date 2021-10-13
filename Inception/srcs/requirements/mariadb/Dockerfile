FROM debian:buster


## Update system and download mariadb
RUN apt-get update && apt-get upgrade -y && \
    apt-get install mariadb-server mariadb-client -y procps && \
    apt-get install net-tools && \
    apt-get install curl -y


# Перекидываем файл конфигурации
# говорим что слушаем всех говорим порт и настривам Volume
COPY ./conf/my.cnf /etc/mysql/my.cnf
RUN chmod 0444 /etc/mysql/my.cnf

##  Тоже различные настройки
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 777 etc/mysql/mariadb.conf.d/50-server.cnf

# Скрипт потом для запуска 
COPY ./tools/mariadb_start.sh /bin/mariadb_start.sh
EXPOSE 3306

#RUN chmod +x    ./db.sh

# ENTYPOINT точка входа CMD аргументы
# sh -c 

#ENTRYPOINT ["./db.sh"] 


CMD sh /bin/mariadb_start.sh

#mysql -u root -h mariadb -p