FROM nginx:stable-alpine

COPY nginx_configuration/nginx.conf /etc/nginx/nginx.conf

COPY nginx_configuration/default.conf /etc/nginx/conf.d/default.conf

COPY nginx_configuration/example.com.conf /etc/nginx/conf.d/example.com.conf

COPY nginx_configuration/dhparam.pem /etc/ssl/dhparam.pem

RUN mkdir -p /etc/ssl/example.com
COPY ssl_certs/example.com.crt /etc/ssl/example.com/example.com.crt
COPY ssl_certs/example.com.key /etc/ssl/example.com/example.com.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
