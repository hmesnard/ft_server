FROM	debian:buster

RUN	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
	wget \
	nginx \
	mariadb-server \
	php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

COPY	srcs/server.conf etc/nginx/sites-available

RUN	rm etc/nginx/sites-enabled/default && \
	ln -s /etc/nginx/sites-available/server.conf /etc/nginx/sites-enabled/server.conf

RUN	echo "daemon off;" >> etc/nginx/nginx.conf

WORKDIR	/var/www/html/

RUN rm index.nginx-debian.html

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
	tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz && \
	mv phpMyAdmin-5.0.1-english phpmyadmin

COPY	srcs/config.inc.php phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xf latest.tar.gz && rm -rf latest.tar.gz

COPY	srcs/wp-config.php wordpress

RUN	openssl req -x509 -nodes -days 365 -subj "/C=BE/ST=BXL/O=19/CN=localhost" \
	-newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN	chown -R www-data:www-data * && \
	chmod -R 755 /var/www/*

COPY	srcs/init.sh /

CMD bash /init.sh
