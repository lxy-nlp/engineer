# Python

## 环境配置

具体可以自行上网查

## 变量类型

### 基本数据类型

```
Numbers（数字） int(整型) long(长整型)  float(浮点型)   float complex(复数) 
String（字符串） ''
List（列表）    [] 有序集合 创建后可以改变
Tuple（元组） () 元组一旦创建不可以改变 有序集合
Dictionary（字典）{} 键值对
```

运算符

```python
加减乘除和C语言一样
等于 不等于 大于小于 大于等于 小于等于和 C语言一样

下面是几个特殊的 
x**y   x的y次幂
逻辑运算
C语言中的与 是 &&         Python中是 and       	x and y
					或  是  ||									or            x or y
    				非        !                                    not          not x

```



### 对应的基础函数

```
# 检测数据类型
type(var)
# 查看数据地址
id(var)
# 数据类型转换
str(var)
float(var)
# eval 的作用 得到原本由字符串包裹的对象  如“2+3” “[1,2,3]”
eval("[12,34,56]")
# 变量创建
var1 = 1
global var2 # 声明全局变量
# 删除对变量的引用
del var1 # 也可以批量删除 del var1,var2,var3

# 连接、重复、切片操作 针对字符串 列表 元组这三种数据类型
[[1]*5] # 数组的复制 实质是对引用的复制，改变其中一个都会全部改变
[1,2,3]+[3,4,5]
list1 = [i for i in range(5)]
list1[1:4] # [1,4) [start,end)
# list 二维列表不能以列切片
```

## 语句

### 顺序语句

### 条件语句

```
if 判断条件1:
    执行语句1……
elif 判断条件2:
    执行语句2……
elif 判断条件3:
    执行语句3……
else:
    执行语句4……
```



### 循环语句

```python
# for 循环
for i in range(0,5): # range(left,right) 的含义是 [left,right)左闭右开
    循环体

for item in items: # item 可以是 元祖 列表 和 字符串数据类型
    循环体
 
# while 循环
count = 0
while (count < 9):
   print 'The count is:', count
   count = count + 1
 
print "Good bye!"

```



#### break 和 continue的区别

#### pass用法

## 函数

def func1(parameters):

​	函数体

调用时 func1(参数赋值)

关于函数可变参数的使用 

- `*args` 是可变参数，`args` 接收的是一个 `tuple`
- `**kw` 是关键字参数，`kw` 接收的是一个 `dict`



lambda 匿名函数

## 类

注: 类这部分现在可以只了解就行,不需要深入掌握

类中一般包含三个部分

构造函数(__init__)

成员变量 name age

成员函数 sit()

```
# 创建类
class Dog:
    def __init__(self,name,age):
        self.name = name
        self.age = age
    def sit(self):
        print(self.name.title() + "is now sitting")
    def roll_over(self):
        print(self.name.title()+"rolled over")
 
 这里的self可以看成自身,self.xx可以看成这个类所拥有的属性和函数
 # 实例化类
 my_dog = Dog('lucy',6)
my_dog.roll_over() # 调用实例对象中的方法
my_dog.sit()

# 获取属性值的方法
getattr(my_dog,'name')
# another 直接调用
my_dog.name
```

### 继承

```
class Car():
    def __init__(self,make,model,year):
        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0
    def get_description(self):
        long_name = str(self.year)+' '+self.make +' '+self.model
        return long_name.tile()
    def update_odometer(self,mileage):
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print('you can not roll back an odometer!')
        self.odometer_reading = mileage
    def read_odometer(self):
        print('This car has '+str(self.odometer_reading)+" miles on it.")
my_new_car = Car('audi','a8',2016)

# 继承的语法是 class son(father):

class ElectricCar(Car):
    def __init__(self,make,model,year,battery):
        super().__init__(make,model,year) # 继承父类中的属性
        self.battery=battery # 子类中自己的属性
        self.wheel = Wheel(70)
    def describe_battery(self):
        print('This ebike has a '+ str(self.battery)+'-kwh')


my_ebike = ElectricCar('xiao','s6',2018,80)
my_ebike.describe_battery()
my_ebike.wheel.describe_wheel()
```

## 爬数据

### 网页

```
import requests
url = 'https://www.dxy.cn/bbs/newweb/pc/post/44122060'  # 你需要爬的网址
session=requests.session()
cookie = '''route_bbs=4b7df70fe96acfe89c32b68456fd2ed3; dxy_da_cookie-id=74dd4cb8-f28b-403d-accf-c99d2c798134; JUTE_TOKEN=f8943f43-1993-4417-b543-d9c654646759; DXY_USER_GROUP=38; __auc=74777292176ac64b26c6e1ba2ef; Hm_lvt_8a6dad3652ee53a288a11ca184581908=1609210049;__utma=1.2078156807.1609210049.1609210049.1609210049.1; __utmc=1; __utmz=1.1609210049.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); Hm_lpvt_8a6dad3652ee53a288a11ca184581908=1609210058; JUTE_SESSION=0edabaa2ebc21e287f7f466d9023d8bc34de639844d70d62247ba4e8f47de7064b6cdc5240e29271;_ga=GA1.2.2078156807.1609210049; _gid=GA1.2.780768706.1609210087; ifVisitOldVerBBS=false; route=fe9340375d898dc58dc46edbbdbb48f8; cms_token=bf29f249-109a-4151-b1a7-a4f382846075;JUTE_SESSION_ID=a79b347c-1e8a-4f1a-b701-530322a8b53f; CLASS_CASTGC=8d8178de2e9c403e77e9ad962a8f8daa4b119f737ead1a4066c5bf461501cef9473393576036ab818650bcb2e5ddd9b0b5b6084eda0a6bfaee0da445e423a68ef6956c5e5d83a9d71791f5281629f878658b6264945a30f3e20b60846b4a43455713da78552722f2f3059c678b3bac5dad05f3b58b2792382a130d5e29997daa1a6bea97de6b388fc259295904096994bace23a07f2b6a1d409dc3600d9fa5fcedd73181413530c219183302e13dac14fed6d8da257c964c143d8c2a524fa7d824f5289f23c25b92a19a00df8032768000d16f2930a717c849272a8a51b489ad8e3092754211caa116576b6e91d52b8eacd16a9356afee5fef0d23054d2e3fd5; JUTE_BBS_DATA=abc38cac57622b949907e3a7779ed005013bb195fbf426c46c82b0b75a4b8ce33eb0e9dbec2ae054db38712b596ccde2437438c530c91193413f9f7db2cbf820cef55aaca07a7501b4bac348f966ae0b'''

# cookie是登录的缓存
headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36', # 设备
           'Cookie':cookie,
           'Connection':'keep-alive' # 保持常连
          }
session.post(url=url,headers=headers) # 一般来说不需要登录的用session.get,需要登录的用session.post
html=session.get(url=url,headers=headers).text # 得到的请求内容
```

### app

app可以参考网页的用法



## 文件读写

![image-20210218223833042](/home/lxy/.config/Typora/typora-user-images/image-20210218223833042.png)



### 路径问题

```python
./ 	表示当前路径
../ 表示上级路径
```



目前看到这就可以了,后续的利用pandas,numpy,matplotlib处理数据的知识我会继续写

----------------------------------------------------------------分割线---------------------------------------------------------------------

## 异常处理

| BaseException             |                   所有异常的基类                   |
| ------------------------- | :------------------------------------------------: |
| SystemExit                |                   解释器请求退出                   |
| KeyboardInterrupt         |             用户中断执行(通常是输入^C)             |
| Exception                 |                   常规错误的基类                   |
| StopIteration             |                 迭代器没有更多的值                 |
| GeneratorExit             |        生成器(generator)发生异常来通知退出         |
| StandardError             |              所有的内建标准异常的基类              |
| ArithmeticError           |               所有数值计算错误的基类               |
| FloatingPointError        |                    浮点计算错误                    |
| OverflowError             |                数值运算超出最大限制                |
| ZeroDivisionError         |            除(或取模)零 (所有数据类型)             |
| AssertionError            |                    断言语句失败                    |
| AttributeError            |                  对象没有这个属性                  |
| EOFError                  |             没有内建输入,到达EOF 标记              |
| EnvironmentError          |                 操作系统错误的基类                 |
| IOError                   |                 输入/输出操作失败                  |
| OSError                   |                    操作系统错误                    |
| WindowsError              |                    系统调用失败                    |
| ImportError               |                 导入模块/对象失败                  |
| LookupError               |                 无效数据查询的基类                 |
| IndexError                |              序列中没有此索引(index)               |
| KeyError                  |                  映射中没有这个键                  |
| MemoryError               |     内存溢出错误(对于Python 解释器不是致命的)      |
| NameError                 |            未声明/初始化对象 (没有属性)            |
| UnboundLocalError         |               访问未初始化的本地变量               |
| ReferenceError            | 弱引用(Weak reference)试图访问已经垃圾回收了的对象 |
| RuntimeError              |                  一般的运行时错误                  |
| NotImplementedError       |                   尚未实现的方法                   |
| SyntaxError               |                  Python 语法错误                   |
| IndentationError          |                      缩进错误                      |
| TabError                  |                   Tab 和空格混用                   |
| SystemError               |                一般的解释器系统错误                |
| TypeError                 |                  对类型无效的操作                  |
| ValueError                |                   传入无效的参数                   |
| UnicodeError              |                 Unicode 相关的错误                 |
| UnicodeDecodeError        |                Unicode 解码时的错误                |
| UnicodeEncodeError        |                 Unicode 编码时错误                 |
| UnicodeTranslateError     |                 Unicode 转换时错误                 |
| Warning                   |                     警告的基类                     |
| DeprecationWarning        |               关于被弃用的特征的警告               |
| FutureWarning             |           关于构造将来语义会有改变的警告           |
| OverflowWarning           |        旧的关于自动提升为长整型(long)的警告        |
| PendingDeprecationWarning |              关于特性将会被废弃的警告              |
| RuntimeWarning            |      可疑的运行时行为(runtime behavior)的警告      |
| SyntaxWarning             |                  可疑的语法的警告                  |
| UserWarning               |                 用户代码生成的警告                 |

#### 基础语法

```
try:
     被检测的代码块
except 异常类型：
     try中一旦检测到异常，就执行这个位置的逻辑
```

#### 多分支

```python
l1 = [('电脑',16998),('鼠标',59),('手机',8998)]
while 1:
    for key,value in enumerate(l1,1):
        print(key,value[0])
    try:
        num = input('>>>')
        price = l1[int(num)-1][1]
    except ValueError:
        print('请输入一个数字')
    except IndexError:
        print('请输入一个有效数字')
#这样通过异常处理可以使得代码更人性化，用户体验感更好。
```

#### try 	else

```Python
try:
    for i in range(10):
        int(i)
except IndexError as e:
    print(e)
else:
    print('***********')   #***********   执行了此处
    #当try语句中的代码没有异常，被完整地执行完，就执行else中的代码
```

#### try  finally

```pyt
def dealwith_file():
    try:
        f = open('file',encoding='utf-8')
        for line in f:
            int(line)
        return True
    except Exception as e:
        print(e)
        return False
    finally:
        '''不管try语句中的代码是否报错,都会执行finally分支中的代码'''
        '''去完成一些连接操作的收尾工作'''
        print('finally 被执行了')
        f.close()
ret = dealwith_file()
print(ret)
```

#### 自定义异常

```python
class EvaException(BaseException):
    def __init__(self,msg):
        self.msg=msg
    def __str__(self):
        return self.msg

try:
    raise EvaException('类型错误')
except EvaException as e:
    print(e)
```

#### 主动触发异常

```pytho
try:
    raise TypeError('类型错误')
except Exception as e:
    print(e)
```



