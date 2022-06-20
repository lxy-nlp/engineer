# Linux系统

## 编辑环境变量

/root/.bashrc中包括环境变量

更改后如果需要立即生效 那么需要使用 source bashrc

```shell
在 https://www.ip138.com/ 找到网址对应的ip地址
写入到 hosts文件中,相同的办法也适用于 github的访问
vi /etc/hosts
#nvidia-docker
185.199.108.153 nvidia.github.io
185.199.109.153 nvidia.github.io
185.199.110.153 nvidia.github.io
185.199.111.153 nvidia.github.io
```

## 设置桌面图标

```shell
建立**.desktop并写入
[Desktop Entry]
Name=Typora
Exec=/opt/Typora-linux-x64/Typora
Type=Application
Icon=/opt/Typora-linux-x64/resources/app/asserts/icon/icon_512x512.png
cp  **.desktop  /usr/share/applications
```



## 设置conda镜像源

```shell
conda config --show 
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
conda config --remove channels " https://"
```

### pip 换源

```python
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
```

## 常见Linux命令

### 文件操作

```shell
ls [-alrtAFR][name...]
-a 显示所有文件及目录 (ls 内定将文件名或目录名称开头为"."的视为隐藏档，不会列出)
-l 除文件名称外，亦将文件型态、权限、拥有者、文件大小等资讯详细列出
-r 将文件以相反次序显示(原定依英文字母次序)
-t 将文件依建立时间之先后次序列出
-A 同 -a ，但不列出 "." (目前目录) 及 ".." (父目录)
-F 在列出的文件名称后加一符号；例如可执行档则加 "*", 目录则加 "/"
-R 若目录下有文件，则以下之文件亦皆依序列出

rm [options] <name>...
-i 删除前逐一询问确认
-f 即使原档案属性设为唯读，亦直接删除，无需逐一确认
-r 将目录及以下之档案亦逐一删除

mv [options] <source> <dest>
-i: 若指定目录已有同名文件，则先询问是否覆盖旧文件;
-f: 在 mv 操作要覆盖某已有的目标文件时不给任何指示;
mv 文件名 文件名 将源文件名改为目标文件名
mv 文件名 目录名 将文件移动到目标目录
mv 目录名 目录名 目标目录已存在，将源目录移动到目标目录；目标目录不存在则改名
mv 目录名 文件名 出错

cp [options] <source> <dest>
-a：此选项通常在复制目录时使用，它保留链接、文件属性，并复制目录下的所有内容。其作用等于 dpR 参数组合。
-d：复制时保留链接。这里所说的链接相当于 Windows 系统中的快捷方式。
-f：覆盖已经存在的目标文件而不给出提示。
-i：与-f 选项相反，在覆盖目标文件之前给出提示，要求用户确认是否覆盖，回答"y"时目标文件将被覆盖。
-p：除复制文件的内容外，还把修改时间和访问权限也复制到新文件中。
-r：若给出的源文件是一个目录文件，此时将复制该目录下所有的子目录和文件。
-l：不复制文件，只是生成链接文件。

cat [-AbeEnstTuv][--help] [--version] <fileName>
-n 或 --number：由 1 开始对所有输出的行数编号。
-b 或 --number-nonblank：和 -n 相似，只不过对于空白行不编号。
-s 或 --squeeze-blank：当遇到有连续两行以上的空白行，就代换为一行的空白行。

tar
-c 或--create 建立新的备份文件。
-t 或--list 列出备份文件的内容。
-x 或--extract 或--get 从备份文件中还原文件。
-z 或--gzip 或--ungzip 通过 gzip 指令处理备份文件。
-f<备份文件>或--file=<备份文件> 指定备份文件。
-v 或--verbose 显示指令执行过程。

tree directry # 以树状显示文件夹

gzip
-c 或--stdout 或--to-stdout 　把压缩后的文件输出到标准输出设备，不去更动原始文件。
-d 或--decompress 或----uncompress 　解开压缩文件。
-f 或--force 　强行压缩文件。不理会文件名称或硬连接是否存在以及该文件是否为符号连接。
-l 或--list 　列出压缩文件的相关信息。
-r 或--recursive 　递归处理，将指定目录下的所有文件及子目录一并处理。
-v 或--verbose 　显示指令执行过程。

zip
将 /home/html/ 这个目录下所有文件和文件夹打包为当前目录下的 html.zip：
zip -q -r html.zip /home/html

如果在我们在 /home/html 目录下，可以执行以下命令：
zip -q -r html.zip *

从压缩文件 cp.zip 中删除文件 a.c
zip -dv cp.zip a.c

unzip
查看压缩文件中包含的文件：
# unzip -l abc.zip

-v 参数用于查看压缩文件目录信息，但是不解压该文件。
# unzip -v abc.zip
```

### 网络操作

```shell
wget <URL> 从网站下载文件
-q 无提示下载
-b 后台下载
-O 指定不同的文件名
–m 下载整个网站
--no-check-certificate 绕过SSL/TLS证书的验证
--user=<user_id> --password=<user_password> 从密码保护的网站下载文件

scp [可选参数] <file_source> <file_target>
-r： 递归复制整个目录。
-P <port>：注意是大写的 P, port 是指定数据传输用到的端口号

1、从本地复制到远程
scp local_file remote_username@remote_ip:remote_folder
或者
scp local_file remote_username@remote_ip:remote_file
或者
scp local_file remote_ip:remote_folder
或者
scp local_file remote_ip:remote_file

rcp [-pr][源文件或目录][目标文件或目录]
rcp [-pr][源文件或目录...][目标文件]
-p 　保留源文件或目录的属性，包括拥有者，所属群组，权限与时间。
-r　递归处理，将指定目录下的文件与子目录一并处理。

```

### 磁盘操作

```java
mount /dev/hda2 /mnt/hda2 挂载一个叫做hda2的盘 - 确定目录 '/ mnt/hda2' 已经存在 
umount /dev/hda2 卸载一个叫做hda2的盘 - 先从挂载点 '/ mnt/hda2' 退出 
fuser -km /mnt/hda2 当设备繁忙时强制卸载 
umount -n /mnt/hda2 运行卸载操作而不写入 /etc/mtab 文件- 当文件为只读或当磁盘写满时非常有用 
mount /dev/fd0 /mnt/floppy 挂载一个软盘 
mount /dev/cdrom /mnt/cdrom 挂载一个cdrom或dvdrom 
mount /dev/hdc /mnt/cdrecorder 挂载一个cdrw或dvdrom 
mount /dev/hdb /mnt/cdrecorder 挂载一个cdrw或dvdrom 
mount -o loop file.iso /mnt/cdrom 挂载一个文件或ISO镜像文件 
mount -t vfat /dev/hda5 /mnt/hda5 挂载一个Windows FAT32文件系统 
mount /dev/sda1 /mnt/usbdisk 挂载一个usb 捷盘或闪存设备 
mount -t smbfs -o username=user,password=pass //WinClient/share /mnt/share 挂载一个windows网络共享 
df -h 显示已经挂载的分区列表 
ls -lSr |more 以尺寸大小排列文件和目录 
du -sh dir1 估算目录 'dir1' 已经使用的磁盘空间' 
du -sk * | sort -rn 以容量大小为依据依次显示文件和目录的大小 
rpm -q -a --qf '%10{SIZE}t%{NAME}n' | sort -k1,1n 以大小为依据依次显示已安装的rpm包所使用的空间 (fedora, redhat类系统) 
dpkg-query -W -f='${Installed-Size;10}t${Package}n' | sort -k1,1n 以大小为依据显示已安装的deb包所使用的空间 (ubuntu, debian类系统) 
```



### 查找操作

```shell
find 目录  文件名
1. 查找所有".h"文件

find /PATH -name "*.h"

2. 查找所有".h"文件中的含有"helloworld"字符串的文件

find /PATH -name "*.h" -exec grep -in "helloworld" {} \;

find /PATH -name "*.h" | xargs grep -in "helloworld"

3. 查找所有".h"和".c"文件中的含有"helloworld"字符串的文件

find /PATH /( -name "*.h" -or -name "*.c" /) -exec grep -in "helloworld" {} \;

4. 查找非备份文件中的含有"helloworld"字符串的文件

find /PATH /( -not -name "*~" /) -exec grep -in "helloworld" {} \;

注：/PATH为查找路径，默认为当前路径。带-exec参数时必须以\;结尾，否则会提示“find: 遗漏“-exec”的参数”。

https://blog.csdn.net/qq_35246620/article/details/79104520
```

### grep使用

```shell
grep []
-i	搜索时，忽略大小写
-c	只输出匹配行的数量
-l	只列出符合匹配的文件名，不列出具体的匹配行
-n	列出所有的匹配行，显示行号
-h	查询多文件时不显示文件名
-s	不显示不存在、没有匹配文本的错误信息
-v	显示不包含匹配文本的所有行
-w	匹配整词
-x	匹配整行
-r	递归搜索
-q	禁止输出任何结果，已退出状态表示搜索是否成功
-b	打印匹配行距文件头部的偏移量，以字节为单位
-o	与-b结合使用，打印匹配的词据文件头部的偏移量，以字节为单位
```

进程

```python
ps -u | grep key 查找当前用户下 包含key关键字的进程
kill 进程号 杀死进程
sudo lsof -i:5000
    
-a	显示所有终端机下执行的程序，除了阶段作业领导者之外
a	显示现行终端机下的所有程序，包括其他用户的程序
-A	显示所有程序
-c	显示CLS和PRI栏位
c	列出程序时，显示每个程序真正的指令名称，而不包含路径，选项或常驻服务的标示
-C <指令名称>	指定执行指令的名称，并列出该指令的程序的状况
-d	显示所有程序，但不包括阶段作业领导者的程序
-e	此选项的效果和指定”A”选项相同
e	列出程序时，显示每个程序所使用的环境变量
-f	显示UID,PPIP,C与STIME栏位
f	用ASCII字符显示树状结构，表达程序间的相互关系
-g <群组名称>	此选项的效果和指定”-G”选项相同，当亦能使用阶段作业领导者的名称来指定
g	显示现行终端机下的所有程序，包括群组领导者的程序
-G <群组识别码>	列出属于该群组的程序的状况，也可使用群组名称来指定
h	不显示标题列
-H	显示树状结构，表示程序间的相互关系
-j或j	采用工作控制的格式显示程序状况
-l或l	采用详细的格式来显示程序状况
L	列出栏位的相关信息
-m或m	显示所有的执行绪
n	以数字来表示USER和WCHAN栏位
-N	显示所有的程序，除了执行ps指令终端机下的程序之外
-p <程序识别码>	指定程序识别码，并列出该程序的状况
p <程序识别码>	此选项的效果和指定”-p”选项相同，只在列表格式方面稍有差异
r	只列出现行终端机正在执行中的程序
-s <阶段作业>	指定阶段作业的程序识别码，并列出隶属该阶段作业的程序的状况
s	采用程序信号的格式显示程序状况
S	列出程序时，包括已中断的子程序资料
-t <终端机编号>	指定终端机编号，并列出属于该终端机的程序的状况
t <终端机编号>	此选项的效果和指定”-t”选项相同，只在列表格式方面稍有差异
-T	显示现行终端机下的所有程序
-u <用户识别码>	此选项的效果和指定”-U”选项相同
u	以用户为主的格式来显示程序状况
-U <用户识别码>	列出属于该用户的程序的状况，也可使用用户名称来指定
U <用户名称>	列出属于该用户的程序的状况
v	采用虚拟内存的格式显示程序状况
-V或V	显示版本信息
-w或w	采用宽阔的格式来显示程序状况
x	显示所有程序，不以终端机来区分
X	采用旧式的Linux i386登陆格式显示程序状况
-y	配合选项”-l”使用时，不显示F(flag)栏位，并以RSS栏位取代ADDR栏位
-- <程序识别码>	此选项的效果和指定”p”选项相同
--cols <每列字符数>	设置每列的最大字符数
--columns <每列字符数>	此选项的效果和指定”--cols”选项相同
--cumulative	此选项的效果和指定”S”选项相同
--deselect	此选项的效果和指定”-N”选项相同
--forest	此选项的效果和指定”f”选项相同
--headers	重复显示标题列
--help	在线帮助
--info	显示排错信息
--lines <显示列数>	设置显示画面的列数
--no-headers	此选项的效果和指定”h”选项相同，只在列表格式方面稍有差异
--group <群组名称>	此选项的效果和指定”-G”选项相同
--Group <群组识别码>	此选项的效果和指定”-G”选项相同
--pid <程序识别码>	此选项的效果和指定”-p”选项相同
--rows <显示列数>	此选项的效果和指定”--lines”选项相同
--sid <阶段作业>	此选项的效果和指定”-s”选项相同
-tty <终端机编号>	此选项的效果和指定”-t”选项相同
--user <用户名称>	此选项的效果和指定”-U”选项相同
--User <用户识别码>	此选项的效果和指定”-U”选项相同
--version	此选项的效果和指定”-V”选项相同
--widty <每列字符数>	此选项的效果和指定”-cols”选项相同
```





## Git

1. 全局配置

   ```shell
   git config 
   ```

   

2. 版控操作

3. .gitignore使用

   