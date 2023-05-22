# 설치 할 PHP 버전
#FROM php:8.0.5-fpm-alpine
# RUN docker-php-ext-install 다음에 설치하고자 하는 모듈 입력
#RUN docker-php-ext-install mysqli

FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install apache2 software-properties-common

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y libapache2-mod-php7.0 php7.0 php7.0-cli php7.0-mysql

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN a2enmod rewrite

EXPOSE 80

CMD apachectl -D FOREGROUND