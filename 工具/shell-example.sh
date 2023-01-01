#!/bin/bash

set -e # 当有错误出现时退出
set -x # 打印命令及其对应结果

cd `$(dirname $0)` # 进入当前目录
echo `uname -s` # 输出系统内核信息



if [ "$(uname -s)" == "Linux" ]; then
  USER_NAME=${SUDO_USER:=$USER}  # 授权
  USER_ID=$(id -u "${USER_NAME}") # 得到用户id
  GROUP_ID=$(id -g "${USER_NAME}") # 得到用户所在组的id
else # boot2docker uid and gid
  USER_NAME=$USER
  USER_ID=1000
  GROUP_ID=50
fi

