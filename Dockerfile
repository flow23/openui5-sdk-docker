#FROM nginx:1.15.8-alpine
FROM nginx:alpine

ENV UI5_VERSION 1.67.1
ENV UI5_FILENAME openui5-sdk-${UI5_VERSION}.zip
ENV UI5_URL https://github.com/SAP/openui5/releases/download/${UI5_VERSION}/${UI5_FILENAME} 

RUN apk add --no-cache --virtual .sdk wget unzip

RUN mkdir -p /var/www

RUN wget ${UI5_URL} --no-check-certificate -P /var/www

RUN unzip -o /var/www/${UI5_FILENAME} -d /var/www

RUN apk del .sdk

RUN rm /var/www/${UI5_FILENAME}

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./server.* /etc/nginx/

EXPOSE 80 443
