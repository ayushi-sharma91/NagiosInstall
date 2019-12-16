apt-get update -y
apt install apache2 -y
apt install libapache2-mod-php -y
apt install php -y
apt install wget unzip zip  autoconf gcc libc6 make apache2-utils libgd-dev -y
useradd nagios
usermod -a -G nagios www-data
cd /tmp
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.4.tar.gz
tar xzf nagios-4.3.4.tar.gz 
cd nagios-4.3.4/
ls
./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all
make install
make install-init
make install-commandmode
systemctl enable nagios.service
make install-config
make install-webconf

htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
 
a2enmod cgi
systemctl restart apache2
systemctl start nagios
systemctl enable nagios

apt install libmcrypt-dev make libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext libldap2-dev smbclient fping libmysqlclient-dev qmail-tools libpqxx3-dev libdbi-dev -y

cd /tmp
wget https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz 
tar xfz release-2.2.1.tar.gz
cd nagios-plugins-release-2.2.1/
./tools/setup 
./configure 
make
make install
ls /usr/local/nagios/libexec/
systemctl restart nagios.service