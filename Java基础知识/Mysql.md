# 遇到的问题

## 忘记密码

https://blog.csdn.net/weidong_y/article/details/80493743

1. 管理员打开cmd 输入 mysqld --skip-grant-tables 回车

2. 重新打开一个 cmd 窗口。输入 mysql 回车。

3. 连接权限数据库：use mysql

4. 修改数据库连接密码：

   update user set password=password("123456") where user="root";

5. 刷新权限（必须步骤）flush privileges;退出 mysql 

6. 修改 root 密码后，需要执行下面的语句和新修改的密码。mysqladmin -u root -p shutdown

## 注册及启动服务

```shell
首先移动到mysql的bin目录
mysqld -install 注册服务
net start mysql 启动服务
net stop mysql  停止服务

```

