#!/bash/bin
#installing telegraf
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.12.4-1_amd64.deb
sudo dpkg -i telegraf_1.12.4-1_amd64.deb -y
#installing influxdb
wget https://dl.influxdata.com/influxdb/releases/influxdb_1.7.8_amd64.deb
sudo dpkg -i influxdb_1.7.8_amd64.deb -y
#installing grafana
wget https://dl.grafana.com/oss/release/grafana_6.4.3_amd64.deb
sudo dpkg -i grafana_6.4.3_amd64.deb
