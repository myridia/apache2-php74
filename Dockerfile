FROM debian:bullseye
LABEL version="0.1"
LABEL maintainer="veto<veto@myridia.com>"

RUN apt-get update && apt-get install -y \
  apache2 \
  apt-transport-https \
  lsb-release \
  ca-certificates \
  curl \
  wget \
  apt-utils \
  openssh-server \
  supervisor \
  default-mysql-client \
  libpcre3-dev \
  gcc \
  make \
  emacs-nox \
  vim \
  git \
  gnupg \
  sqlite3 \
  unzip \
  p7zip-full \
  postgresql-client \
  inetutils-ping \
  net-tools

RUN curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/sury-php.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ bullseye main" | tee /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
  php7.4 \
  php7.4-json \
  php7.4-xml \
  php7.4-cgi \
  php7.4-mysql \
  php7.4-mbstring \
  php7.4-gd \
  php7.4-curl \
  php7.4-zip \
  php7.4-dev \
  php7.4-sqlite3 \
  php7.4-ldap \
  php7.4-sybase \
  php7.4-pgsql \
  php7.4-soap \
  libapache2-mod-php7.4 \
   php-pear \
  freetds-bin \
  freetds-common


RUN echo "<?php phpinfo() ?>" > /var/www/html/index.php ; \
mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor ; \
a2enmod rewrite  ;\
sed -i -e '/memory_limit =/ s/= .*/= 2056M/' /etc/php/7.4/apache2/php.ini ; \
sed -i -e '/post_max_size =/ s/= .*/= 800M/' /etc/php/7.4/apache2/php.ini ; \
sed -i -e '/max_file_uploads =/ s/= .*/= 200/' /etc/php/7.4/apache2/php.ini ; \
sed -i -e '/upload_max_filesize =/ s/= .*/= 800M/' /etc/php/7.4/apache2/php.ini ; \
sed -i -e '/display_errors =/ s/= .*/= ON/' /etc/php/7.4/apache2/php.ini ; \
sed -i -e '/short_open_tag =/ s/= .*/= ON/' /etc/php/7.4/apache2/php.ini ; \
sed -i -e '/short_open_tag =/ s/= .*/= ON/' /etc/php/7.4/cli/php.ini ; \
sed -i -e '/AllowOverride / s/ .*/ All/' /etc/apache2/apache2.conf ; \
sed -i -e '/max_execution_time =/ s/= .*/= 1200/' /etc/php/7.4/apache2/php.ini ; \
echo 'open_basedir = "/"' >> /etc/php/7.4/apache2/php.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin && \
    ln -s /usr/bin/composer.phar /usr/bin/composer

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22 80
CMD ["/usr/bin/supervisord"]


