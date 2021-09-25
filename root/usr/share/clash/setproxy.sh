#!/bin/sh

clash_enable=$(uci get clash.config.enable 2>/dev/null)
clash_allowlan=$(uci get clash.config.allow_lan 2>/dev/null)
clash_LANIP=$(uci get network.lan.ipaddr 2>/dev/null |awk -F '/' '{print $1}' 2>/dev/null)
clash_httpport=$(uci get clash.config.http_port 2>/dev/null)
clash_curl_proxy=""
clash_wget_proxy=""

if [ $clash_enable -eq 1 ]; then
	if [ $clash_allowlan == true ]; then
		clash_curl_proxy=" --proxy ${clash_LANIP}:${clash_httpport} "
		clash_wget_proxy="-e https_proxy=${clash_LANIP}:${clash_httpport} "
	else
		clash_curl_proxy=" --proxy 127.0.0.1:${clash_httpport} "
		clash_wget_proxy="-e https_proxy=127.0.0.1:${clash_httpport} "
	fi
fi
