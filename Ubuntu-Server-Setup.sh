
##Update and Upgrade
apt update && apt upgrade y

##Install and Enable Apache2
apt install apache2 y
systemctl start apache2
systemctl enable apache2

##Install and Secure MariaDB
apt install mariadb-server y
mysql_secure_installation

##Install other dependencies
apt install php libapache2-mod-php php-mysql phpmyadmin php-gd php-json php-mysql php-curl php-mbstring php-intl php-imagick php-xml php-zip
apt install php-apcu php-bcmath php-gmp

##Download nextcloud
wget https://download.nextcloud.com/server/releases/nextcloud-23.0.3.tar.bz2 
tar -xvf nextcloud-23.0.3.tar.bz2

##Move nextcloud
cd nextcloud
mkdir /var/www/nextcloud
mv ./* /var/www/nextcloud
mv ./.htaccess /var/www/nextcloud
mv ./.user.ini /var/www/nextcloud
cd /var/www/nextcloud

##Set Permissions
chown -R www-data:www-data ./*
chown -R www-data:www-data ./.htaccess
chown -R www-data:www-data ./.user.ini

