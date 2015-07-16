#!/bin/sh

# Wait to start mysql server
sleep 25

sed -i.bak 's|$PMA_USERNAME|'"$PMA_USERNAME"'|g' /users.sql && \
	sed -i.bak 's|$PMA_PASSWORD|'"$PMA_PASSWORD"'|g' /users.sql && \
	mysql -h $MYSQL_ADDR -P $MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASS < /www/sql/create_tables.sql && \
	mysql -h $MYSQL_ADDR -P $MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASS < /users.sql && \
	rm /users.sql

sed -i \
    -e "s|\$PMA_SECRET|$PMA_SECRET|g" \
    -e "s|\$PMA_USERNAME|$PMA_USERNAME|g" \
    -e "s|\$PMA_PASSWORD|$PMA_PASSWORD|g" \
    -e "s|\$MYSQL_ADDR|$MYSQL_ADDR|g" \
    -e "s|\$MYSQL_PORT|$MYSQL_PORT|g" \
    /www/config.inc.php

service php5-fpm start

service nginx start