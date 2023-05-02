FROM debian:latest

RUN apt-get update && apt-get install -y wget tar mariadb-client 
RUN apt-get update && apt-get install -y php7.4 php7.4-fpm php7.4-bcmath php7.4-bz2 php7.4-calendar php7.4-ctype php7.4-curl php7.4-dom php7.4-exif php7.4-fileinfo php7.4-gd php7.4-gmp php7.4-iconv php7.4-imap php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-pgsql php7.4-phar php7.4-posix php7.4-readline php7.4-shmop php7.4-simplexml php7.4-soap php7.4-sockets php7.4-sqlite3 php7.4-sysvmsg php7.4-sysvsem php7.4-sysvshm php7.4-tokenizer php7.4-xml php7.4-xmlreader php7.4-xmlwriter php7.4-xsl php7.4-zip php7.4-zmq php7.4-common openssl

# php config
RUN adduser --system --no-create-home --disabled-login --group nginx
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY www.conf /etc/php7/php-fpm.d/www.conf

# static website
COPY index.html /tmp/index.html

# install wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

COPY configure.sh /tmp/configure_wp.sh
ENTRYPOINT [ "sh", "/tmp/configure_wp.sh" ]