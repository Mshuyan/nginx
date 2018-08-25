# nginx

> 学习资料：

## 1. 介绍

### 1.1. 代理

> 代理服务器就相当于中间人，客户端要访问A服务器，客户端把要做的事告诉代理服务器，代理服务器帮忙代为访问A服务器，并将结果返回给客户端

#### 1.1.1.正向代理

> 1. 正向代理的特点就是，代理服务器听客户端的调遣，客户端将要访问的服务器告诉代理服务器，代理服务器会根据客户端的要求访问要访问的服务器；
>
> 2. 正向代理要求客户端进行特殊的设置，但是服务器不知道真实客户端的存在
>
> 3. 案例：
>
>    **翻墙**：客户端不能直接访问墙外的服务器，但是代理服务器可以访问，所以客户端将请求发给代理服务器，代理服务器去访问墙外的服务器，将响应返回给客户端，

#### 1.1.2. 反向代理

> 1. 反向代理特点是，代理服务器跟真正的站点服务器是一伙的，开发人员配置好代理服务器后，代理服务器会根据配置信息将接收到的请求分发给多个不同的站点服务器，然后将响应返给客户端
>
> 2. 反向代理不需要客户端做任何设置，客户端是感觉不到真实服务器的存在的
>
> 3. 案例：
>
>    **负载均衡**：用户访问量或数据量过大时，1个服务器难以承载这么大的压力，所以会启动多个相同的服务器用于处理相同的请求，当代理服务器接收到请求后，会根据每个服务器是否忙碌的状态来分发请求，来避免对单个服务器造成太大压力（类似于10086的客服热线）

### 1.2. 特点

+ 热部署

  > 修改配置文件后不需要重启

+ 高并发

  > 可接受的连接比apache多很多

+ 低内存消耗

+ 处理静态文件请求响应很快

+ 可靠性高

### 1.3. 对比Apache

+ 软件底层架构不同
+ nginx并发性更好
+ nginx更轻量级
+ nginx处理静态资源更快，apache处理动态资源更快
+ apache更安全

## 2. 安装

### 2.1. linux

> 本次测试使用的是centOs系统

1. 创建1个文件（任意格式），将下面的shell脚本粘贴进去

   ```shell
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
   ```

2. 将该文件权限改为可执行文件

   如：

   ```Shell
   chmod -x nginx_install
   ```

3. 运行该脚本

   ```shell
   ./nginx_install
   ```

   > 此时`nginx`已经安装在`/usr/local/nginx/`下

## 3. 使用

### 3.1. 常用命令

1. 启动

   `nginx`

2. 重启

   `nginx -s reload`

3. 停止

   `nginx -s stop`

   或

   `pkill nginx`

4. 检测配置文件

   `nginx -t`

   > 生效`nginx.conf`文件之前，先要执行该命令检测配置是否存在错误，以防止直接执行有错误的配置导致用户无法使用系统

### 3.2. 目录结构

> `/usr/local/nginx/`目录下的目录结构

+ conf

  > 配置文件目录，主配文件`nginx.conf`就在这里

+ html

  > 网站默认根目录

+ logs

  > 日志

+ sbin

  > nginx的可执行文件的目录

### 3.3. 配置文件

> 配置文件是`/usr/local/nginx/conf/nginx.conf`文件
>
> 下面只对常用参数进行说明，详细参数后续需要在学
>
> + 该文件中，用`#`或`//`或`/* */`标识注释

#### 3.3.1. 块说明

+ nginx配置文件共分为如下几块：
  + main

    配置影响nginx全局的指令。

  + event

    配置影响nginx服务器或与用户的网络连接

  + http

    可以嵌套多个server，配置代理，缓存，日志定义等绝大多数功能和第三方模块的配置

  + server

    配置虚拟主机的相关参数，可以嵌套多个location

  + location

    配置请求的路由，以及各种页面的处理情况

  + upstream

    用于配置负载均衡，使服务器跨越单机限制

+ 各块层级关系如下图：

  <img src="assets/image-20180814112117670.png" width="400px" /> 

+ 其中
  + 影响全局的配置包括：`main块全局配置`、`event块`、`http块全局配置`
  + 影响虚拟机的配置：`server块配置`
  + 影响与`location块`匹配的路由的配置：`location块`
  + 影响负载均衡配置：`upstream块`

#### 3.3.2. 配置属性

1. main块

   + `user`

     > + 作用：指定nginx worker进程运行用户以及用户组.
     > + 语法：user {user}  {group} 
     > + 默认值：nobody nobody 

   + `error_log`

     > + 作用：用于定义错误日志文件
     >
     >   日志级别（按输出由多到少排序）：`debug`、`info`、`notice`、`warn`、`error`、`crit`
     >
     > + 语法：error_log  {file}  {level}
     >
     >   如：`error_log  logs/error.log  notice`

   + `pid`

     > + 作用：用来指定进程id的存储文件位置

   + `worker_processes`

     > nginx进程数，一般设为和cpu内核数一样

2. event块

   > 用来指定nginx的工作模式及连接数上限。

   + `worker_connections`

     > 每个进行可接受的连接数，也就是单个进程并发量
     >
     > 总并发量 = `worker_processes` * `worker_connections`

   + `use`

     > + 作用：用来指定工作模式
     >
     >   工作模式分为： `kqueue`、`rtsig`、`epoll`、`/dev/poll`、`select`、`poll`、`eventport`
     >
     >   Linux一般使用`epoll`

3. http块

   > http块中的配置项基本都可以用于server、location块

   + `include`

     > + 该指令用于将其他配置文件中的配置引入到本文件中
     >
     > + 该配置项支持相对路径和绝对路径
     >
     >   如：`include mime.type`就是引入当前目录下的`mime.type`文件

   + `default_type`

     > + 指定默认的`Content-Type`，如果没有在`mime.type`文件中找到对应的`Content-Type`，就会使用该配置项定义的默认的类型

   + `log_format`

     > 用于指定日志格式，一般使用默认的即可

   + `access_log`

     > 指定日志存储位置及使用的日志格式
     >
     > 如：`access_log  logs/wiki_access.log main;`

   + `server_tokens`

     > 功能：设置是否显示请求响应头中nginx的版本
     >
     > 语法：`server_tokens on`
     >
     > 默认`on`，为了安全，最好设为`off`

4. server块

   > 虚拟机配置，1个server对应1个工程项目
   >
   > server块中的配置基本都可以用于location块

   + `listen`

     > 指定监听端口

   + `server_name`

     > 域名解析
     >
     > - nginx通过匹配请求的`Host`请求头和每个server的该属性值，来决定使用哪个server对应的服务处理该请求
     >
     > - 每个server段中的该属性值必须是唯一的
     >
     > - 每个server段中的该属性可以使用正则表达式匹配多个域名
     >
     > - 如果是前端项目，该属性值需要与前端项目中使用的顶级域名保持一致
     >
     > - 如果你的服务器没有注册域名，可以自己随便起几个域名，在配置nginx时进行使用
     >
     >   在要访问该网站的测试机上通过修改`hosts`文件，将自己起的这几个域名解析到这台服务器上

   + `root`

     > - 网站根目录
     > - 前端项目一般配置为编译后生成的那个目录，如：`dist`
     > - 该配置项也可以放在`location段`中，但是一般放在这里

   + `index`

     > 指定默认访问页面，后面可以指定多个，越前面的优先级越高

     例：

     ```
     index  index.html index.htm;
     ```

   + `proxy_pass`

     > - 功能：请求转发
     >
     > - 例：
     >
     >   `proxy_pass http://127.0.0.1:8080`
     >
     >   所有请求转发到`http://127.0.0.1:8080`
     >
     >   如：请求路径为`index.html`，经过`nginx`被转发到`http://127.0.0.1:8080/index.html`

   + `proxy_set_header`

     > + 功能：
     >
     >   允许重新定义或添加发往后端服务器的请求头。`value`可以包含文本、变量或者它们的组合。
     >
     >   原来有的，未设置的请求头原封不动传过去
     >
     >   如：`proxy_set_header Host host:$host;`
     >
     >   	`host:`就是文本，`$host`就是变量
     >
     > + 继承规则
     >
     >   当前块中没有使用`proxy_set_header`时，继承上一级中的`proxy_set_header`设置
     >
     >   当前块中只要使用了`proxy_set_header`，就与上一级中的`proxy_set_header`设置无关了
     >
     > + 默认设置
     >
     >   ```
     >   proxy_set_header Host $proxy_host;
     >   proxy_set_header Connection close;
     >   ```
     >
     >   排除继承上一级设置的影响，当前块中即使使用了`proxy_set_header`，只要没有明确设置这两个默认设置的头，这两个默认设置就是生效的

     常用变量：

     + $host

       nginx接收到的请求的host请求头

     + $proxy_host

       代理域名

       `proxy_pass`的参数去掉`http://`部分得到的就是`$proxy_host`

     + $connection

       nginx接受到的请求的connection请求头

     + $remote_addr

       nginx接收到的请求的remote_addr

       接收到的请求的`remote_addr`一定是上一级的ip，所以如果想在后端获取客户端真实IP，就必须在第1级nginx中将`remote_addr`设置到1个请求头中，并且后续nginx不可以更改该头，后端才能通过该请求头获取真正的客户端IP

     + $proxy_add_x_forwarded_for

             nginx接收到的请求的`X-Forwarded-For`请求头+`,`+接收到的请求的remote_addr

       例：

       	客户端发来的请求的`X-Forwarded-For`请求头一般为null，所以到第1个nginx后，该变量值为客户端的ip；到第2个nginx后，该变量值为`客户端IP,第1个nginxIP`

     + $proxy_x_forwarded_for

       nginx接收到的请求的`X-Forwarded-For`请求头

       客户端发来的请求的`X-Forwarded-For`请求头一般为null，所以该变量值一般为null

   + `underscores_in_headers`

     > 功能：设置是否支持下划线
     >
     > 默认值：off

     ```
     underscores_in_headers on;
     ```

   + `expires`

     > 用来指定静态文件的过期时间
     >
     > 如：`expires 20d`代表20天过期；`expires 2m`代表2个月过期

   + `deny`

     > `deny all`忽略所有请求

   + `try_files`

     > - 如果本次请求前面没有匹配成功，执行到这一句，则会依次尝试后面的资源
     >
     > - 例：
     >
     >   ```shell
     >   try_files $uri $uri/ /index.html;
     >   ```
     >
     >   如本次请求路径为`www.baidu.com/img`，执行到这里时，依次尝试`www.baidu.com/img`、`www.baidu.com/img/`、`www.baidu.com/index.html`

5. location块

   > + URL匹配特定路由后的设置

6. upstream块

   > + 指定代理域名设置一系列的后端服务器，并负载均衡策略
   >
   >   + 代理域名：
   >
   >     就是给这个upstream起1个名字，在server块中可以通过`proxy_pass http://代理域名`将请求分发到这个`代理域名`代表的`upstream块`中的某一个后端服务器
   >
   >     但是这个`代理域名`决定了`$proxy_host`的值，所以一般这个`代理域名`要取名为真实的域名或根据需求起1个合理的`域名`
   >
   > + 不会继承指令也不会被继承。它有自己的特殊指令，不需要在其他地方的应用。

   例：

   ```
   upstream www.bymyself.club{
   	server localhost:9000;
   	server localhost:9001;
   }
   ```

   > + 代理域名：`www.bymyself.club`
   > + 站点：每个server就是1个站点

   + 负载均衡5种策略

     + 轮训

       >  上例这种什么都不指定的，就是轮训
       >
       > 这也是默认策略
       >
       > 站点之间基本是1：1分发请求

     + weight

       > 指定weight分发请求，weight代表权重，权重越高的分发的请求越多
       >
       > 一般使用这种策略需要根据服务器性能配置权重

       例：

       ```
       upstream www.bymyself.club{
       	server localhost:9000 weight=1;
       	server localhost:9001 weight=2;
       }
       ```

     + iphash

       > 每个请求按访问ip的hash结果分配，这样每个访客固定访问一个后端服务器，可以解决session不能跨服务器的问题。

       例：

       ```
       upstream www.bymyself.club{
       	ip_hash;
       	server localhost:9000;
       	server localhost:9001;
       }
       ```

     + fair（第三方插件）

       > 按后端服务器的响应时间来分配请求，响应时间短的优先分配。

       ```
       upstream www.bymyself.club{
       	fair;
       	server localhost:9000;
       	server localhost:9001;
       }
       ```

     + url_hash

       > 按访问url的hash结果来分配请求，使每个url定向到同一个后端服务器，后端服务器为缓存服务器时比较有效。 在upstream中加入hash语句，hash_method是使用的hash算法。

       ```
       upstream www.bymyself.club{
       	server localhost:9000;
       	server localhost:9001;
       	hash $request_uri;
       	hash_method crc32;
       }
       ```

   + 设备状态

     > 在upstream中站点的后面可以指定设备状态

     如：

     ```
     upstream www.bymyself.club{
     	server localhost:9000 down;
     	server localhost:9001;
     }
     ```

     + down

       当前server暂不参与负载

     + weight

       权重

     + max_fails

       允许请求失败的次数默认为1。当超过最大次数时，返回proxy_next_upstream 模块定义的错误

     + fail_timeout

       max_fails次失败后，暂停的时间。

     + backup 

       备用服务器, 其它所有的非backup机器down或者忙的时候，请求backup机器。所以这台机器压力会最轻。

#### 3.3.3. 配置案例

1. 前端项目配置

   > 实际应用中，我们只负责向`http`段中添加`server`段即可，如：

   ```shell
   server{
           listen 80;
           server_name analysis.hs.show-my-screen.com;
           root   /opt/analysis-service-frontent/dist/;
           index  index.html index.htm;
           location / {
                   index  index.html;
                   try_files $uri $uri/=index.html;
           }
   }
   ```

2. 后端项目配置

   ```
   server {
       listen       80;
       server_name  api.hs.show-my-screen.com;
   
       location / {
            proxy_pass http://localhost:8080/;
            proxy_set_header            Host $host;
   		 proxy_set_header            X-real-ip $remote_addr;
   		 proxy_set_header            X-Forwarded-For $proxy_add_x_forwarded_for;
       }
   }
   ```

3. 负载均衡配置

   ```
   upstream www.bymyself.club{
   	server localhost:9000;
   	server localhost:9001;
   }
   
   server {
       listen       80;
       server_name  www.bymyself.club;
   
       location / {
            proxy_pass http://www.bymyself.club;
            proxy_set_header            Host $host;
   		 proxy_set_header            X-real-ip $remote_addr;
   		 proxy_set_header            X-Forwarded-For $proxy_add_x_forwarded_for;
       }
   }
   ```








