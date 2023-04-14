# Redis
## 安装和配置
安装方式有两种可选 docker 和 官方包，主要使用docker进行配置
```shell
docker run \
-p 6379:6379 --name myredis \
-v/Users/bochenghu/onlineinternship/redis/redis.conf:/etc/redis/redis.conf \
-v /Users/bochenghu/onlineinternship/redis/data:/data:rw \
--privileged=true -d redis redis-server /etc/redis/redis.conf \
--appendonly yes
```
docker exec -it myredis /bin/bash 进入容器后 先运行redis-server 再运行redis-cli
主从配置
修改 redis-slave 的配置文件
replicaof 172.17.0.2 6379 # 主地址
masterauth hubocheng # 主认证

## java连接redis并使用
```xml
        <dependency>
            <groupId>redis.clients</groupId>
            <artifactId>jedis</artifactId>
            <version>3.0.1</version>
        </dependency>
```

