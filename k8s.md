# k8s
## 获取pv信息
kubectl get pv -n ns
kubectl describe pv pvid -n ns
kubectl get pod -n ns -o wide


## 打印容器日志
kubectl logs -f  aie-aie-1-st6bn  -n aie

# docker
## 镜像格式化
docker image ls --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}"
docker image ls --format "{{.ID}}: {{.Repository}}"
## 加载/保存镜像
docker load < origin.tar
docker save -o target.tar user/ubuntu:v3
## 打标签
docker tag origin:version  remoteurl:port/target:version
docker push remoteurl:port/user/target:version


# Shell

## 替换文件中的字符串
sed -i 's/origin/target/g' test.txt

## 查看硬盘资源
lsblk

## 查看端口是否开放
telnet ip port
netstat -lnt |grep portnum

## 开放端口
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
service iptables save           进行保存
-A：参数就看成是添加一条 INPUT 的规则
-p：指定是什么协议 我们常用的tcp 协议，当然也有udp，例如53端口的DNS
 --dport：就是目标端口，当数据从外部进入服务器为目标端口
--sport：数据从服务器出去，则为数据源端口
-j：就是指定是 ACCEPT接收或者DROP不接收

## 查看端口服务是否正常
lsof -i:port


## 设置密码
/etc/pam.d/system-auth文件，将maxrepeat=2 maxclassrepeat=2  修改为 maxrepeat=0 maxclassrepeat=0
## root登录设置
1. 设置服务器支持 root 用户 ssh 连接
① vim /etc/ssh/sshd_config
    修改 PermitRootLogin 参数值为 yes
② 在 AllowUsers 后面添加 root
③ 重启 sshd 服务：systemctl restart sshd.service

2. 设置用户登录超时时间
① vim /etc/profile
    删除文件中设置TMOUT变量的两行内容
        export TMOUT=300
        TMOUT=300
② source /etc/profile
③ vim /etc/bashrc
    将文件中的TMOUT变量值设置为0
        export TMOUT=0
        TMOUT=0
④ source /etc/bashrc




