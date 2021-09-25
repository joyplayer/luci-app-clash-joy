#!/bin/sh

. /usr/share/clash/setproxy.sh

new_version=`curl -sL ${clash_curl_proxy} "https://gitee.com/joyplayer/lede_third_package/tags"| grep "href=\"/joyplayer/lede_third_package/tree/"| head -n 1| awk -F "/tree/" '{print $2}'| sed 's/\">.*//'`
if [ "$?" -eq "0" ]; then
rm -rf /usr/share/clash/new_luci_version
if [ $new_version ]; then
echo $new_version > /usr/share/clash/new_luci_version 2>&1 & >/dev/null
elif [ $new_version =="" ]; then
echo 0 > /usr/share/clash/new_luci_version 2>&1 & >/dev/null
fi
fi
 