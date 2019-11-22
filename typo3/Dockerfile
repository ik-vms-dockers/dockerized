FROM php:7-apache

ARG TYPO3_VERSION="${TYPO3_VERSION:-9}"
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update
RUN apt-get install -yqq \
      build-essential \
      curl \
      libfreetype6-dev \
      libgs-dev \
      libjpeg-dev \
      libjpeg62-turbo-dev \
      libmcrypt-dev \
      libpcre3-dev \
      libpng-dev \
      libxml2 \
      libxml2-dev \
      libzip-dev \
      mariadb-client \
      zlib1g-dev
RUN apt-get clean

RUN a2enmod rewrite

RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr --with-freetype-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd mysqli zip intl
RUN echo "max_execution_time=240" >> ${PHP_INI_DIR}/conf.d/typo3.ini
RUN echo "max_input_vars=1500" >> ${PHP_INI_DIR}/conf.d/typo3.ini

RUN curl -fsSL --progress https://get.typo3.org/${TYPO3_VERSION} | tar zxf - -C /var/www/html/
RUN ln -s /var/www/html/typo3_src-${TYPO3_VERSION} /var/www/html/typo3_src
RUN ln -s /var/www/html/typo3_src/{index.php,typo3} /var/www/html/
RUN touch /var/www/html/FIRST_INSTALL
RUN chown -R www-data:www-data /var/www/html
