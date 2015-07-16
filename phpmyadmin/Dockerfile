FROM phusion/baseimage
MAINTAINER Alejandro F. Carrera <alej4fc@gmail.com>

# Exports
ENV HOME="/root" \
	MYSQL_USER=root \
    MYSQL_PASS=secret \
    MYSQL_ADDR=mysql \
    MYSQL_PORT=3306 \
    PMA_USERNAME="pma" \
    PMA_PASSWORD="secret" \
    PMA_SECRET="blow_secret" \
	DEBIAN_FRONTEND="noninteractive" \
	PHPMYADMIN="4.4.9" \
	PHP_MAX="50M"

RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

# Install Nginx & PHP5
RUN apt-get -qq update && \
	apt-get install -qq -y nginx \
	php5-fpm php5-cli php5-json \
	php5-mcrypt php5-mysql php5-gd \
	php5-curl mysql-client wget
RUN rm /etc/nginx/sites-enabled/default
ADD files/site /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site
RUN sed -i "s/http {/http {\n        client_max_body_size $PHP_MAX;/" /etc/nginx/nginx.conf
RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = $PHP_MAX/" /etc/php5/fpm/php.ini
RUN sed -i "s/post_max_size = 8M/post_max_size = $PHP_MAX/" /etc/php5/fpm/php.ini

# Install PHPMyAdmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN}/phpMyAdmin-${PHPMYADMIN}-english.tar.bz2 && \
	tar -jxvf phpMyAdmin-${PHPMYADMIN}-english.tar.bz2 && \
	rm phpMyAdmin-${PHPMYADMIN}-english.tar.bz2 && \
	mv phpMyAdmin-${PHPMYADMIN}-english /www
ADD ./files/config.inc.php /www/config.inc.php
ADD ./files/users.sql /users.sql

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ./my_init.d/ /etc/my_init.d/

CMD ["/sbin/my_init"]

EXPOSE 80

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

