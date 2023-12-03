#!/bin/bash

# 修改默认IP
# sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 自动登录
# sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/msd_lite
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata

# 添加额外插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata
# svn export https://github.com/syb999/openwrt-19.07.1/trunk/package/network/services/msd_lite package/msd_lite

# 科学上网插件
git clone --depth=1 -b main https://github.com/fw876/helloworld package/luci-app-ssr-plus
svn export https://github.com/haiibo/packages/trunk/luci-app-vssr package/luci-app-vssr
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall
svn export https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/luci-app-passwall2
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

# Themes
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
svn export https://github.com/haiibo/packages/trunk/luci-theme-opentomcat package/luci-theme-opentomcat

# 更改 Argon 主题背景
cp -f $GITHUB_WORKSPACE/images/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# 晶晨宝盒


# SmartDNS
git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/openwrt-smartdns package/smartdns

# msd_lite
git clone --depth=1 https://github.com/ximiTech/luci-app-msd_lite package/luci-app-msd_lite
git clone --depth=1 https://github.com/ximiTech/msd_lite package/msd_lite

# MosDNS
svn export https://github.com/sbwml/luci-app-mosdns/trunk/luci-app-mosdns package/luci-app-mosdns
svn export https://github.com/sbwml/luci-app-mosdns/trunk/mosdns package/mosdns

# Alist
svn export https://github.com/sbwml/luci-app-alist/trunk/luci-app-alist package/luci-app-alist
svn export https://github.com/sbwml/luci-app-alist/trunk/alist package/alist

# iStore
svn export https://github.com/linkease/istore-ui/trunk/app-store-ui package/app-store-ui
svn export https://github.com/linkease/istore/trunk/luci package/luci-app-store

# 在线用户
svn export https://github.com/haiibo/packages/trunk/luci-app-onliner package/luci-app-onliner
sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh



# 调整 ZeroTier 到 服务 菜单
# sed -i 's/vpn/services/g; s/VPN/Services/g' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua
# sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/zerotier_status.htm

# 取消对 samba4 的菜单调整
# sed -i '/samba4/s/^/#/' package/lean/default-settings/files/zzz-default-settings

./scripts/feeds update -a
./scripts/feeds install -a
