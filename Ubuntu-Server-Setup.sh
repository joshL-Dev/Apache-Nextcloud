#
#Welcome to my Ubuntu/Probably debian server nextcloud installation.
#
#READ THE ENTIRE SCRIPT PRIOR, ITS NOT 100% Automated.  I AM NOT A SECURITY PROFESSIONAL SO THESE MAY NOT BE THE BEST WAYS TO DO THIS SECURELY.
#YOU MAY NEED TO UPDATE THE DOWNLOAD LINK OF THE TARBALL ON LINE 23ISH.
#
#Update and Upgrade
apt update && apt upgrade y

#Install and Enable Apache2
apt install apache2 y
systemctl start apache2
systemctl enable apache2

#Install and Secure MariaDB
apt install mariadb-server y
mysql_secure_installation

#Install other dependencies
apt install php libapache2-mod-php php-mysql phpmyadmin php-gd php-json php-mysql php-curl php-mbstring php-intl php-imagick php-xml php-zip php-apcu php-bcmath php-gmp

#Download nextcloud
wget https://download.nextcloud.com/server/releases/nextcloud-23.0.3.tar.bz2 
tar -xvf nextcloud-23.0.3.tar.bz2

#Move nextcloud
cd nextcloud
mkdir /var/www/nextcloud
mv ./* /var/www/nextcloud
mv ./.htaccess /var/www/nextcloud
mv ./.user.ini /var/www/nextcloud
cd /var/www/nextcloud

#Set Permissions
chown -R www-data:www-data ./*
chown -R www-data:www-data ./.htaccess
chown -R www-data:www-data ./.user.ini

#Next Section is MariaDB
#Enter the Following Commands:
#CREATE DATABASE database_name_here;
#CREATE USER user_here IDENTIFIED BY 'password_here';
#GRANT USAGE ON *.* TO database_name_here@localhost IDENTIFIED BY 'password_here';
#GRANT ALL privileges ON database_name_here.* TO database_name_here@localhost;
#FLUSH PRIVILEGES;
#exit
#
#Make sure to remember the ; at the end of each line.
#Make sure to remember the things you set for database etc for post-install.
#
#Below is an example of the lines you can use.
#
#I do eventually hope to be able to incorporate this in a much nicer way than to just comment this.
#
#CREATE DATABASE nextcloud;
#CREATE USER nextcloud IDENTIFIED BY 'password1';
#GRANT USAGE ON *.* TO nextcloud@localhost IDENTIFIED BY 'password1';
#GRANT ALL privileges ON nextcloud.* TO nextcloud@localhost;
#FLUSH PRIVILEGES;
#exit

mariadb

#Restart Apache2
systemctl restart apache2

#Setting up SSL
#
#Comment out this section if you don't want SSL, or if you don't have a valid domain you own.
apt install python3-certbot-apache
certbot --apache

systemctl restart apache2

#Post-Install:
#
#Once complete head over to the IP Address and r