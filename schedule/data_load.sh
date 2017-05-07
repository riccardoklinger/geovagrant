#! /bin/sh
# Locale
wget -q -O /vagrant/data/all_day.geojson https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson
sudo -u vagrant ogr2ogr -f "PostgreSQL" PG:"dbname=project_data user=vagrant" "/vagrant/data/all_day.geojson" -nln quakes -append