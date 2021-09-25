#!/bin/sh

. /usr/share/clash/setproxy.sh

new_luci_version=`curl -sL ${clash_curl_proxy} "https://github.com/joyplayer/luci-app-clash-joy/tags"| grep "a href=\"/joyplayer/luci-app-clash-joy/releases/"| head -n 1| awk -F "/tag/" '{print $2}'| sed 's/\">//'`
if [ "$?" -eq "0" ]; then
rm -rf /usr/share/clash/new_luci_version
if [ $new_luci_version ]; then
echo $new_luci_version > /usr/share/clash/new_luci_version 2>&1 & >/dev/null
elif [ $new_luci_version =="" ]; then
echo 0 > /usr/share/clash/new_luci_version 2>&1 & >/dev/null
fi
fi
 