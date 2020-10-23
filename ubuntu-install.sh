#!/bin/bash

VS=1.19.3

sudo apt-get -y install build-essential
sudo apt-get -y install libtool
sudo apt-get update
sudo apt-get install libpcre3 libpcre3-dev
sudo apt-get install zlib1g-dev
sudo apt-get install openssl

#! 安装nginx
wget http://nginx.org/download/nginx-$VS.tar.gz			#! 下载
tar zxvf nginx-$VS.tar.gz					 			#! 解压
rm -rf nginx-$VS.tar.gz								#! 删除压缩包
cd nginx-$VS										#! 进入解压后目录
sudo ./configure && make && make install						#! 编译并安装
cd ..												#! 返回上级目录
rm -rf nginx-$VS/									#! 删除解压的目录

#! 启动nginx
/usr/local/nginx/sbin/nginx