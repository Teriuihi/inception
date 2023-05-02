FROM alpine:3.13

RUN	apk update && apk upgrade && apk add --no-cache \
        mariadb \
        mariadb-client
        
COPY configure.sh /tmp/configure_sql.sh

ENTRYPOINT ["sh", "/tmp/configure_sql.sh"]