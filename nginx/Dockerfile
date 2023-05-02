FROM debian:latest

RUN apt-get update && apt-get install -y nginx openssl

# nginx SSL
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/raccoman.pem \
        -keyout /etc/nginx/ssl/raccoman.key \
        -subj "/C=IT/ST=Rome/L=Rome/O=42 School/OU=raccoman/CN=raccoman/"

# nginx config
RUN mkdir -p /run/nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Start nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]