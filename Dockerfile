FROM php:8.3.15-fpm-alpine3.20 as builder
LABEL org.opencontainers.image.authors="Thornton Phillis (Th0rn0@lanops.co.uk), Alexader Volz (Alexander@volzit.de)"

# ENV - Config

ENV UUID=1000
ENV GUID=1000
ENV SUPERVISOR_LOG_ROOT=/var/log/supervisor
ENV NGINX_DOCUMENT_ROOT=/web/html

# Install Dependencies

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN apk add --no-cache --virtual .build-deps \
	gcc \
	g++ \
	make

RUN apk add --no-cache \
	tzdata \
	curl \
	bash \
	libc-dev \
	icu-dev \
	openssl-dev \
	pcre-dev \
	zlib-dev \
	linux-headers \
	gnupg \
	libxslt-dev \
	gd-dev \
	imagemagick \
	imagemagick-dev \
	libgomp \
	geoip-dev \
	coreutils \
	autoconf

RUN apk add --no-cache supervisor \
	&& mkdir -p $SUPERVISOR_LOG_ROOT

# Install Nginx

RUN addgroup -S nginx \
	&& adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx \
	&& apk add --no-cache nginx \
	&& rm -rf /etc/nginx/html/ \
	&& mkdir /etc/nginx/conf.d/ \
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

# Install PHP exts
RUN docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg && \
	docker-php-ext-install mysqli pdo_mysql gd bcmath intl 
RUN install-php-extensions imagick/imagick@28f27044e435a2b203e32675e942eb8de620ee58
RUN docker-php-ext-enable imagick


RUN rm -f /var/cache/apk/* \
    && mkdir -p /opt/utils

# Clean Up

RUN apk del .build-deps
