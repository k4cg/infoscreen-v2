#!/bin/sh
exec 1>/dev/null 2>&1
wget http://cosm.tiefpunkt.com/infoscreen/ajax.php -O stats.json
wget "https://api.cosm.com/v2/feeds/42055/datastreams/Strom_Leistung.png?width=680&height=430&colour=%23f15a24&duration=1hour&stroke_size=5&detailed_grid=true&scale=auto&timezone=Berlin&font_size=50" -O power.png
