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




