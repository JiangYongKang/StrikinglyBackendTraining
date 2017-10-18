### 通过 `brew` 进行下载安装
```zsh
$ brew install nginx
==> Downloading https://homebrew.bintray.com/bottles/nginx-1.12.1.sierra.bottle.tar.gz
######################################################################## 100.0%
==> Pouring nginx-1.12.1.sierra.bottle.tar.gz
==> Caveats
Docroot is: /usr/local/var/www

The default port has been set in /usr/local/etc/nginx/nginx.conf to 8080 so that
nginx can run without sudo.

nginx will load all files in /usr/local/etc/nginx/servers/.

To have launchd start nginx now and restart at login:
  brew services start nginx
Or, if you don't want/need a background service you can just run:
  nginx
==> Summary
🍺  /usr/local/Cellar/nginx/1.12.1: 23 files, 1MB
```

### 默认配置项
根据以上的输出，我们可以得到以下有用的信息
```shell
# 服务器默认位置
/usr/local/var/www

# 默认的配置文件的位置
/usr/local/etc/nginx/nginx.conf

# 默认文件加载路径
/usr/local/etc/nginx/servers/

# 安装位置
/usr/local/Cellar/nginx/1.12.1
```

### 常用的命令
```zsh
$ nginx -s quit   # 退出
$ nginx -s reload #重新加载
$ nginx -t        #测试 nginx.conf 配置
```

### 配置 `nginx`
在安装位置创建 `conf` 目录，并建立一个软连接
```zsh
$ cd /usr/local/Cellar/nginx/1.12.1
$ mkdir config
$ cd config
$ ln -s /usr/local/etc/nginx/nginx.conf nginx.conf
$ ls -al
total 8
drwxr-xr-x   3 vincent  wheel  102 10 14 09:58 .
drwxr-xr-x  13 vincent  wheel  442 10 14 09:55 ..
lrwxr-xr-x   1 vincent  wheel   31 10 14 09:57 nginx.config -> /usr/local/etc/nginx/nginx.conf
```
