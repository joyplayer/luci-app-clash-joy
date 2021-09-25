#!/bin/sh

. /usr/share/clash/setproxy.sh

new_clashdtun_core_version=`curl -sL ${clash_curl_proxy} "https://github.com/Dreamacro/clash/releases/tag/premium" | grep 'href="/Dreamacro/clash/releases/tag/premium' | head -n 1 | awk -F ' ' '{print $3}'| sed 's/<\/a>//'`
sleep 2
if [ "$?" -eq "0" ]; then
rm -rf /usr/share/clash/new_clashdtun_core_version
if [ $new_clashdtun_core_version ]; then
echo $new_clashdtun_core_version > /usr/share/clash/new_clashdtun_core_version 2>&1 & >/dev/null
elif [ $new_clashdtun_core_version =="" ]; then
echo 0 > /usr/share/clash/new_clashdtun_core_version 2>&1 & >/dev/null
fi
fi
