# 配置

```shell
# 配置用户信息
git config --global user.name "lxy-nlp"
git config --global user.email "18261195602@163.com
git config --list

# 初始化仓库
mkdir gitrep
git init 
git status # 查看状态
```

## 版控操作

### 基础操作

```shell
git add . # 全部添加
git add file
git add  *.html #添加指定后缀的文件
git commit -a -m "commit message" # 提交
git log --oneline --graph # 日志显示格式为一行显示

# 根据条件查询日志
git log --oneline --author ="lxy"
git log --oneline --author="lxy \| hxl"

git log --oneline --grep="LOL" # commit 信息中含有LOL
						--S  "python" # commit 文件这种含有python
					--since ="9am" --untill="12pm" --after="2019-01"

git rm welcome.html # 文件会在暂存区
git rm welcome.html --cached # 解除git控制

git ls-files # 查看git控制的文件

git  push master
```

### .gitignore

```shell
添加不受git控制的文件和文件夹
```

### 分支操作

```shell
git branch dev   # 创建分支
git checkout dev # 切换分支
git  branch --setupstream-to dev origin/dev #  将dev和远程的dev链接
git push origin --delete HEAD # 删除分支

1. 若远程是个新项目 则
git push -u http://github.com/lxy-nlp/nlp.git master    第一次push，需要加上-u参数，把本地的master分支和远程的master分支进行关联，以后push则不需再加-u参数
2. 若远程项目已经存在则使用
git remote add origin http://github.com/lxy-nlp/test.git

3. 推送一个已经存在的仓库到另一个仓库
待学习


```

### 撤销操作

```shell
# 主要是为了解决 .gitignore不生效的问题
git rm -r --cached .   # 删除暂存区已经托管的文件
<<<<<<< HEAD
git rm filepath        # 删除暂存区和工作区的文件
git rm filepath           # 删除暂存区和工作区的文件
git rm filepath           # 删除暂存区和工作区的文件
git rm -r --cached <fold> 不删除本地文件
git rm -r --f <fold> 删除本地文件
git rm --cached <file> 不删本地文件，仅仅不再跟踪文件

git rm filepath           # 删除暂存区和工作区的文件
git rm -r --cached <fold> 不删除本地文件

git rm -r --f <fold> 删除本地文件

git rm --cached <file> 不删除本地文件，仅仅不再跟踪文件

git rm --f <file> 删除本地文件，并且不再跟踪文件


# 对于一些大文件撤销push
git filter-branch -f --prune-empty --index-filter 'git rm -rf --cached --ignore-unmatch uncased_L-12_H-768_A-12/*' --tag-name-filter cat -- --all
git push origin --force # 同步到远程仓库 

# 撤销 commit 
git reset commit_id 
    根据–soft –mixed –hard，会对working tree和index和HEAD进行重置:
    git reset –mixed：此为默认方式，不带任何参数的git reset，即时这种方式，它回退到某个版本，只保留源码，回退commit和index信息
    git reset –soft：回退到某个版本，只回退了commit的信息，不会恢复到index file一级。如果还要提交，直接commit即可
    git reset –hard：彻底回退到某个版本，本地的源码也会变为上一个版本的内容
    
    HEAD 最近一个提交
    HEAD^ 上一次




1.第一种情况：还没有push，只是在本地commit

git reset --soft|--mixed|--hard <commit_id>
git push develop develop --force  (本地分支和远程分支都是 develop)
这里的<commit_id>就是每次commit的SHA-1，可以在log里查看到

--mixed    会保留源码,只是将git commit和index 信息回退到了某个版本.
--soft   保留源码,只回退到commit信息到某个版本.不涉及index的回退,如果还需要提交,直接commit即可.
--hard    源码也会回退到某个版本,commit和index 都会回退到某个版本.(注意,这种方式是改变本地代码仓库源码)

 

当然有人在push代码以后,也使用 reset --hard <commit...> 回退代码到某个版本之前,但是这样会有一个问题,你线上的代码没有变,线上commit,index都没有变,当你把本地代码修改完提交的时候你会发现全是冲突.....这时换下一种

 

2.commit push 代码已经更新到远程仓库

对于已经把代码push到线上仓库,你回退本地代码其实也想同时回退线上代码,回滚到某个指定的版本,线上,线下代码保持一致.你要用到下面的命令

git revert <commit_id>
revert 之后你的本地代码会回滚到指定的历史版本,这时你再 git push 既可以把线上的代码更新。

 

注意：git revert是用一次新的commit来回滚之前的commit，git reset是直接删除指定的commit，看似达到的效果是一样的,其实完全不同。

第一:上面我们说的如果你已经push到线上代码库, reset 删除指定commit以后,你git push可能导致一大堆冲突.但是revert 并不会.
第二:如果在日后现有分支和历史分支需要合并的时候,reset 恢复部分的代码依然会出现在历史分支里.但是revert 方向提交的commit 并不会出现在历史分支里.
第三:reset 是在正常的commit历史中,删除了指定的commit,这时 HEAD 是向后移动了,而 revert 是在正常的commit历史中再commit一次,只不过是反向提交,他的 HEAD 是一直向前的.

```


### 冲突合并
1、git add .

2、git commit -m "***********"

3、git pull --rebase

（出现冲突，红色框提示冲突的文件。同时提示用户需要先解决这个冲突，然后用git rebase --continue继续）

4、本地intellij解决冲突（冲突前的代码，会同时存在你和远端的代码），可以git status查看你当前处在REBASE的分支下。

可使用 git diff --check 或者 git diff --name-only --diff-filter=U查看冲突

5、git add .

6、git rebase --continue  $ git rebase --continue 就可以线性的连接本地分支与远程分支，无误之后就回退出，回到主分支上。


7、git pull

