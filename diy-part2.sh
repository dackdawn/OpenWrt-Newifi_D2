#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# patch aria2 from 16 threads to 128 threads
mkdir -p feeds/packages/net/aria2/patches

cat << EOF > feeds/packages/net/aria2/patches/001-lifting-thread-restrictions.patch
--- a/src/OptionHandlerFactory.cc
+++ b/src/OptionHandlerFactory.cc
@@ -440,7 +440,7 @@ std::vector<OptionHandler*> OptionHandle
   {
     OptionHandler* op(new NumberOptionHandler(PREF_MAX_CONNECTION_PER_SERVER,
                                               TEXT_MAX_CONNECTION_PER_SERVER,
-                                              "1", 1, 16, 'x'));
+                                              "1", 1, 128, 'x'));
     op->addTag(TAG_BASIC);
     op->addTag(TAG_FTP);
     op->addTag(TAG_HTTP);
EOF

# add luci-app-adguardhome
# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

# fix path bug in adguardhome from kenzo
# This is no longer needed now.
# sed -i "s/^include ..\/..\/lang\/golang\/golang-package.mk$/include \$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g" feeds/kenzo/adguardhome/Makefile

