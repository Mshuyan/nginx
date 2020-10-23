#!/bin/bash

#! 到这个目录下安装
cd /user/local/src/

#! 安装gcc编译器
yum -y install gcc-c++

#! 安装openssl
wget http://www.openssl.org/source/openssl-fips-2.0.10.tar.gz  	#! 下载
tar zxvf openssl-fips-2.0.10.tar.gz 						#! 解压
rm -rf openssl-fips-2.0.10.tar.gz							#! 删除压缩包
cd openssl-fips-2.0.10									#! 进入解压后目录
./config && make && make install							#! 编译并安装
cd ..												#! 返回上级目录
rm -rf openssl-fips-2.0.10/								#! 删除解压的目录

#! 安装pcre
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz  	#! 下载
tar zxvf pcre-8.40.tar.gz					 						#! 解压
rm -rf pcre-8.40.tar.gz												#! 删除压缩包
cd pcre-8.40														#! 进入解压后目录
./configure && make && make install									#! 编译并安装
cd ..															#! 返回上级目录
rm -rf pcre-8.40/													#! 删除解压的目录

#! 安装pcre-devel
yum install pcre-devel

#! 安装zlib
wget http://zlib.net/zlib-1.2.11.tar.gz					  	#! 下载
tar zxvf zlib-1.2.11.tar.gz					 			#! 解压
rm -rf zlib-1.2.11.tar.gz								#! 删除压缩包
cd zlib-1.2.11											#! 进入解压后目录
./configure && make && make install						#! 编译并安装
cd ..												#! 返回上级目录
rm -rf zlib-1.2.11/										#! 删除解压的目录

#! 安装nginx
wget http://nginx.org/download/nginx-1.10.2.tar.gz			#! 下载
tar zxvf nginx-1.10.2.tar.gz					 			#! 解压
rm -rf nginx-1.10.2.tar.gz								#! 删除压缩包
cd nginx-1.10.2										#! 进入解压后目录
./configure && make && make install						#! 编译并安装
cd ..												#! 返回上级目录
rm -rf nginx-1.10.2/									#! 删除解压的目录

#! 启动nginx
/usr/local/nginx/sbin/nginx