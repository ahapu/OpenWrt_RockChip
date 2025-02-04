#!/bin/bash
#=================================================
# File name: init-settings.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================
# Set default theme to luci-theme-argon
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

# 设置LAN口DNS
uci set network.lan.dns='223.5.5.5 180.76.76.76 123.125.81.6'
uci commit network
/etc/init.d/network restart

# 设置ssh端口和允许接口
uci set dropbear.@dropbear[0].Interface='lan'
dropbear.@dropbear[0].Port='29292'
uci commit

# Disable opkg signature check
# sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf
# 禁用ipv6前缀
sed -i 's/^[^#].*option ula/#&/' /etc/config/network
# Disable autostart by default for some packages
cd /etc/rc.d
rm -f S98udptools || true
rm -f S99nft-qos || true

# Try to execute init.sh (if exists)

if [ ! -f "/boot/init.sh" ]; then
bash /boot/init.sh
fi

exit 0
