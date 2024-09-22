#!/bin/bash

# 安装 mosdns

# 创建配置文件目录
mkdir -p /etc/mosdns

# 创建临时文件夹
mkdir tmp

# 下载 mosdns
wget -O tmp/mosdns-linux-amd64.zip https://github.com/IrineSistiana/mosdns/releases/download/v5.3.3/mosdns-linux-amd64.zip

# 解压
unzip -o -d tmp tmp/mosdns-linux-amd64.zip

# 把mosdns软件移到绝对工作目录
mv tmp/mosdns /usr/bin/

# 将配置文件移动到 /etc/mosdns
cp ./*.yaml /etc/mosdns
cp -r ./others_set /etc/mosdns

# 获取执行权限
chmod +x /usr/bin/mosdns

# mosdns service install -d 工作目录绝对路径 -c 配置文件路径
mosdns service install -d /usr/bin -c /etc/mosdns/config.yaml

# 启动mosdns
mosdns service start

# 设置开机自启
systemctl enable mosdns.service

# 检查状态
systemctl status mosdns.service

# 卸载
# mosdns service stop
# mosdns service uninstall


# 安装 adguardhome 的代码

# 下载AdGuardHome到本机,三选一都是安装脚本,能用就行
wget --no-verbose -O - https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v

# 启动
systemctl start AdGuardHome

# 状态
systemctl status AdGuardHome

# 开机自启
systemctl enable AdGuardHome

# 重启
# systemctl restart AdGuardHome

# 停止
# systemctl stop AdGuardHome

rm -rf tmp
