#! /bin/sh
# Locale
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# add and Update Repositories with keys:
add-apt-repository "deb http://qgis.org/debian xenial main"
add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"
apt-get update
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
sudo apt-key add -
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 073D307A618E5811

# # Install basic GUI:
apt-get install --no-install-recommends -y xubuntu-desktop

# #install apache,qgis, postgis:
apt-get install -y --allow-unauthenticated \
postgresql-9.4 \
postgresql-9.4-postgis-2.2 \
qgis python-qgis qgis-plugin-grass \
apache2 \
kate \
firefox

#create database and enable postgis extension:
sudo -u postgres psql -c "CREATE USER vagrant PASSWORD 'secret';"

# Setup databases:
sudo -u postgres createdb project_data --owner=vagrant

# Setup PostGIS on databases
sudo -u postgres psql -d project_data -c 'CREATE EXTENSION if not exists postgis;'

#add two daily cronjobs to start at 11:09 and 11:11 to download and update quakes database
crontab -u vagrant -r
{ crontab -l -u vagrant; echo '11 11 * * * sudo -u vagrant /vagrant/schedule/data_load.sh'; } | crontab -u vagrant -
sudo service cron restart
sudo reboot