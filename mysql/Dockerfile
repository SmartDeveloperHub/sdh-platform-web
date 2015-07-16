FROM phusion/baseimage
MAINTAINER Alejandro F. Carrera <alej4fc@gmail.com>

# Exports
ENV HOME="/root" \
    MYSQL_PASS="secret" \
	DEBIAN_FRONTEND="noninteractive"

RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

# MySQL Installation
RUN apt-get update
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PASS" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PASS" | debconf-set-selections
RUN apt-get install -y mysql-server

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN service mysql start && \
	mysql -u root -p$MYSQL_PASS -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' \
    IDENTIFIED BY '${MYSQL_PASS}' WITH GRANT OPTION; FLUSH PRIVILEGES;"

#Share mysql data directory
VOLUME ["/var/lib/mysql"]

CMD mysqld_safe

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ./my_init.d/ /etc/my_init.d/

CMD ["/sbin/my_init"]

EXPOSE 3306

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
