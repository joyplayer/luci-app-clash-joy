#!/bin/sh

. /usr/share/clash/setproxy.sh

clash_wget_dl=""

Key=$(uci get clash.config.license_key 2>/dev/null)
geoip_source=$(uci get clash.config.geoip_source 2>/dev/null)

if [ -f /var/run/geoip_down_complete ]; then
	rm -rf /var/run/geoip_down_complete 2> /dev/null
fi

echo '' >/tmp/geoip_update.txt 2>/dev/null

if [ $geoip_source == 1 ]; then
	clash_wget_dl="wget -c4 --no-check-certificate  -t 2 -T 20 ${clash_wget_proxy} --user-agent=\"Mozilla\" \"https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=\"$Key\"&suffix=tar.gz\" -O /tmp/ipdb.tar.gz"
	if [ "$?" -eq "0" ]; then
		tar zxvf /tmp/ipdb.tar.gz -C /tmp &&
			rm -rf /tmp/ipdb.tar.gz >/dev/null 2>&1 &&
			mv /tmp/GeoLite2-Country_*/GeoLite2-Country.mmdb /tmp/Country.new.mmdb &&
			rm -rf /tmp/GeoLite2-Country_* >/dev/null 2>&1
	fi
else
	clash_wget_dl="wget -c4 --no-check-certificate -t 2 -T 20 ${clash_wget_proxy} --user-agent=\"Mozilla\" https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb -O /tmp/Country.new.mmdb"
fi

`${clash_wget_dl}`

sleep 2
touch /var/run/geoip_down_complete >/dev/null 2>&1
sleep 2
rm -rf /var/run/geoip_update >/dev/null 2>&1
echo "" >/tmp/geoip_update.txt >/dev/null 2>&1

if pidof clash >/dev/null; then
    /etc/init.d/clash stop 2>/dev/null
    mv /tmp/Country.new.mmdb /etc/clash/Country.mmdb &&
	/etc/init.d/clash start 2>/dev/null
fi
