## 集合框架

## Collection 

![img](/home/lxy/文档/学习笔记/img/java-coll-2020-11-16.png)

![img](/home/lxy/文档/学习笔记/img/2243690-9cd9c896e0d512ed.gif)

a) 根接口Collection
 	i. 常用子接口

​		List
​		实现类：ArrayList、Vector、LinkedList

​		Set
​		实现类：HashSet、TreeSet

b) 添加功能
 i. boolean add(object obj)添加一个元素
 ii. boolean addAll(Collection c)将集合c的全部元素添加到原集合元素后返回true
 iii. 添加功能永远返回true
c) 删除功能
 i. void clear();移除所有元素
 ii. boolean remove(Object o)移除一个元素
 iii. boolean removeAll（Collection c）移除一个集合的元素，只要有一个被移除就返回true，改变原集合，删除原集合中和c中相同的元素
 iv. 删除功能只有删除成功后才返回true
d) 判断功能
 i. boolean contain(object o)判断集合中是否包含指定的元素。
 ii. boolean containsAll(Collection c)判断原集合中是否包含指定集合c的所有元素，有则true，
 iii. boolean isEmpty()判断集合是否为空
e) 获取功能
 i. Iterator iterator()迭代器，集合的专用方式，实现遍历的功能
 ii. Object next()获取当前元素，并移动到下一个位置
 iii. boolean hasNext()判断此位置是否有元素
 iv. 迭代器遍历实例在下面
f) 长度功能
 i. int size()元素的个数
 ii. 数组和字符串中都是length()方法获取元素个数，集合中是size()方法
  因为object包括集合、字符串、数组，所以其不能直接用length方法。
g) 交集功能boolean retainAll(Collection c)
 两个集合交集的元素给原集合，并判断原集合是否改变，改变则true，不变则false
h) 把集合转换为数组
 i. Object [] toArray()



### List集合

Collection集合的子类
特点：
a) 有序（存储和取出的元素顺序一致），可重复
b) 特有功能
 i. 添加功能
  void add(int index,Object element)在指定位置添加元素（原索引处的元素后延）
 ii. 获取功能
  Object get(int index)获取指定位置的元素
 iii. 列表迭代器

  1. ListIterator listIterator() List集合特有的迭代器

  2. Iterator迭代器的子类，所以其可以用Iterator中的boolean hasNext()、Object next()方法

  3. 特有的方法：
   a) Object previous ()返回此处位置的前一个的元素，并移动到前一个位置。
   b) boolean hasPrevious()判断此处的前一个位置是否有元素
   c) 逆向遍历必须先正向遍历使指针指到后面位置才能使用（使用意义不大）

  4. 迭代器遍历元素时不能直接通过集合修改元素，怎么办？
   a) 迭代器修改元素
    i. List迭代器有修改方法，Collection中的迭代器没有
    ii. 通过迭代器中add(object obj)方法添加，跟在刚才迭代元素后面
   b) 通过集合遍历元素，并用集合修改元素（for循环遍历）
    i. 通过集合中add(object obj)方法添加，跟在集合最后面

  5. 迭代器遍历实例实例在下面给出
 iv. 删除功能
  Object remove(int index)根据索引删除指定的元素，并返回删除的元素
 v. 修改功能、
   Object set(int index,Object element)根据索引修改元素，返回被修改的元素
 vi. 数组转成集合

 public static List asList(T… a)，返回类型为List类型
 
 a为集合，此处的… 代表可变参数，也就是a的数组元素个数可变
 
 此方法是Arrays类中的静态方法
 
  6. 数组转变为集合，实质还是数组需要保证长度不变，所以不支持增删集合元素，可以修改元素

  

  c) List子类的特点：
  i. ArrayList:

  底层数据结构是数组，查询快、增删慢

  线程不安全，效率高
  ii. Vector：

  底层数据结构是数组，查询快，增删慢

  线程安全，效率低
  iii. LinkedList：

  底层数据结构是链表，查询慢，增删快

  线程不安全，效率高

  

###     Vector集合特有的特点

  a) 添加功能
   i. public void addElement(Object obj)
  b) 获取功能
   i. public Object elementAt(int index)
   ii. public Enumeration elements ()

    1. 也是用来遍历集合
          2. boolean hasMoreElements()
                3. Object nextElement()
                      4. 基本不用这个，都是直接用上面的迭代器实现遍历

  1.2、LinkedList集合的特有功能
  a) 添加功能
   i. public void addFirst(Object e)
   ii. public void addLast(Object e)
  b) 获取功能
   i. public Object getFirst()
   ii. public Object getLast()
  c) 删除功能
   i. public Object removeFirst()
   ii. public Object removeLast()

###    Set集合

   a) 无序（存储和取出顺序不一致，有可能会一致），但是元素唯一，不能重复
   b) b) 实现类
    i. HashSet

     1. 底层数据是哈希表
           2. 通过两个方法hashCode()和equals()保证元素的唯一性，方法自动生成
                   3. 子类LinkedHashSet底层数据结构是链表和哈希表，由链表保证元素有序，

          由哈希表保证元素唯一。
        ii. TreeSet
         1. 底层数据是红黑二叉树
           2. 排序方式：自然排序、比较器排序
           3. 通过比较返回值是否为0来保证元素的唯一性。

  2.1、 HashSet类：
   a) 不保证set的迭代顺序，
   b) 当存储对象时需要重写equals（）和hashCode（）方法（可以用Eclipse自动生成此方法）

  2.1.1、 LinkedHashSet类
   a) HashSet的子类
   b) 可预知的迭代顺序，底层数据结构由哈希表和链表组成
    i. 哈希表：保证元素的唯一性
    ii. 链表：保证元素有序（存储和取出顺序一致）

  2.2、 TreeSet类
   a) 能够保证元素唯一性（根据返回值是否是0来决定的），并且按照某种规则排序
    i. 自然排序，无参构造方法（元素具备比较性）
     按照compareTo()方法排序，让需要比较的元素所属的类实现自然排序接口Comparable，
     并重写compareTo()方法
    ii. 1. 让集合的构造方法接收一个比较器接口的子类对象（compareator）
    （此处的Comparator为接口，需要写一个接口实现类，在实现类中重写compare()方法，
     并在这里创建接口实现类的对象，可以用匿名内部类来创建实现类对象）
   b) 底层是自平衡二叉树结构
    i. 二叉树有前序遍历、后序遍历、中序遍历
    ii. TreeSet类是按照从根节点开始，按照从左、中、右的原则依此取出元素
   c) 当使用无参构造方法，也就是自然排序，需要根据要求重写compareTo()方法，这个不能自动生成

  3、 针对Collection集合我们应该怎么使用
  a) 是否元素唯一
   i. 是：Set
    1. 是否排序

       a) 是：TreeSet
       b) 否：HashSet
      如果不知道用哪个Set就用HashSet
     ii. 否：List
       
      1. 是否对安全性有要求
         a) 是：Vector
         b) 否：
           查询多：ArrayList
           增删多：LinkedList

  如果不知道用哪个List用ArrayList
  如果知道是用集合但不知道用哪个用ArrayList


### Set和List的区别

- 1. Set 接口实例存储的是无序的，不重复的数据。List 接口实例存储的是有序的，可以重复的元素。
- 2. Set检索效率低下，删除和插入效率高，插入和删除不会引起元素位置改变 **<实现类有HashSet,TreeSet>**。
- 3. List和数组类似，可以动态增长，根据实际存储的数据的长度自动增长List的长度。查找元素效率高，插入删除效率低，因为会引起其他元素位置改变 **<实现类有ArrayList,LinkedList,Vector>** 。



### Map

<key,value>

Map的输出

```java
Map<String,String>  map = new HashMap<>();
Set<Map.entry<String,String>> allSet = map.entrySet();
Iterator<Map.Entry<String,String>> iter = allSet.iterator();
while(iter.hasNext())
{
    iter.next().getKey()/getValue()
}
```





### 集合的输出

Iterator

ListIterator

foreach 数组集合都可

```
Iterator<String> iter = all.iterator();
while(iter.hasNext())
{
	System.out.print(iter.next());
}
iter.remove()

```



### 其他类集

Stack

```java
empty() boolean
 
peek() E

pop() E

push() E

search() int
```





## String操作

![img](/home/lxy/文档/学习笔记/img/string-no-modify.png)

```java
String str = 'abc123';
// String 类创建的字符串一旦创建就无法改变  只是改变了对象的引用

```

| SN(序号) | 方法描述                                                     | 是否熟练 |
| :------- | :----------------------------------------------------------- | -------- |
| 1        | [char charAt(int index)](https://www.runoob.com/java/java-string-charat.html) 返回指定索引处的 char 值。 |          |
| 2        | [int compareTo(Object o)](https://www.runoob.com/java/java-string-compareto.html) 把这个字符串和另一个对象比较。 |          |
| 3        | [int compareTo(String anotherString)](https://www.runoob.com/java/java-string-compareto.html) 按字典顺序比较两个字符串。 |          |
| 4        | [int compareToIgnoreCase(String str)](https://www.runoob.com/java/java-string-comparetoignorecase.html) 按字典顺序比较两个字符串，不考虑大小写。 |          |
| 5        | [String concat(String str)](https://www.runoob.com/java/java-string-concat.html) 将指定字符串连接到此字符串的结尾。 |          |
| 6        | [boolean contentEquals(StringBuffer sb)](https://www.runoob.com/java/java-string-contentequals.html) 当且仅当字符串与指定的StringBuffer有相同顺序的字符时候返回真。 |          |
| 7        | [static String copyValueOf(char[\] data)](https://www.runoob.com/java/java-string-copyvalueof.html) 返回指定数组中表示该字符序列的 String。 |          |
| 8        | [static String copyValueOf(char[\] data, int offset, int count)](https://www.runoob.com/java/java-string-copyvalueof.html) 返回指定数组中表示该字符序列的 String。 |          |
| 9        | [boolean endsWith(String suffix)](https://www.runoob.com/java/java-string-endswith.html) 测试此字符串是否以指定的后缀结束。 |          |
| 10       | [boolean equals(Object anObject)](https://www.runoob.com/java/java-string-equals.html) 将此字符串与指定的对象比较。 |          |
| 11       | [boolean equalsIgnoreCase(String anotherString)](https://www.runoob.com/java/java-string-equalsignorecase.html) 将此 String 与另一个 String 比较，不考虑大小写。 |          |
| 12       | [byte[\] getBytes()](https://www.runoob.com/java/java-string-getbytes.html)  使用平台的默认字符集将此 String 编码为 byte 序列，并将结果存储到一个新的 byte 数组中。 |          |
| 13       | [byte[\] getBytes(String charsetName)](https://www.runoob.com/java/java-string-getbytes.html) 使用指定的字符集将此 String 编码为 byte 序列，并将结果存储到一个新的 byte 数组中。 |          |
| 14       | [void getChars(int srcBegin, int srcEnd, char[\] dst, int dstBegin)](https://www.runoob.com/java/java-string-getchars.html) 将字符从此字符串复制到目标字符数组。 |          |
| 15       | [int hashCode()](https://www.runoob.com/java/java-string-hashcode.html) 返回此字符串的哈希码。 |          |
| 16       | [int indexOf(int ch)](https://www.runoob.com/java/java-string-indexof.html) 返回指定字符在此字符串中第一次出现处的索引。 |          |
| 17       | [int indexOf(int ch, int fromIndex)](https://www.runoob.com/java/java-string-indexof.html) 返回在此字符串中第一次出现指定字符处的索引，从指定的索引开始搜索。 |          |
| 18       | [int indexOf(String str)](https://www.runoob.com/java/java-string-indexof.html)  返回指定子字符串在此字符串中第一次出现处的索引。 |          |
| 19       | [int indexOf(String str, int fromIndex)](https://www.runoob.com/java/java-string-indexof.html) 返回指定子字符串在此字符串中第一次出现处的索引，从指定的索引开始。 |          |
| 20       | [String intern()](https://www.runoob.com/java/java-string-intern.html)  返回字符串对象的规范化表示形式。 |          |
| 21       | [int lastIndexOf(int ch)](https://www.runoob.com/java/java-string-lastindexof.html)  返回指定字符在此字符串中最后一次出现处的索引。 |          |
| 22       | [int lastIndexOf(int ch, int fromIndex)](https://www.runoob.com/java/java-string-lastindexof.html) 返回指定字符在此字符串中最后一次出现处的索引，从指定的索引处开始进行反向搜索。 |          |
| 23       | [int lastIndexOf(String str)](https://www.runoob.com/java/java-string-lastindexof.html) 返回指定子字符串在此字符串中最右边出现处的索引。 |          |
| 24       | [int lastIndexOf(String str, int fromIndex)](https://www.runoob.com/java/java-string-lastindexof.html)  返回指定子字符串在此字符串中最后一次出现处的索引，从指定的索引开始反向搜索。 |          |
| 25       | [int length()](https://www.runoob.com/java/java-string-length.html) 返回此字符串的长度。 |          |
| 26       | [boolean matches(String regex)](https://www.runoob.com/java/java-string-matches.html) 告知此字符串是否匹配给定的正则表达式。 |          |
| 27       | [boolean regionMatches(boolean ignoreCase, int toffset, String other, int ooffset, int len)](https://www.runoob.com/java/java-string-regionmatches.html) 测试两个字符串区域是否相等。 |          |
| 28       | [boolean regionMatches(int toffset, String other, int ooffset, int len)](https://www.runoob.com/java/java-string-regionmatches.html) 测试两个字符串区域是否相等。 |          |
| 29       | [String replace(char oldChar, char newChar)](https://www.runoob.com/java/java-string-replace.html) 返回一个新的字符串，它是通过用 newChar 替换此字符串中出现的所有 oldChar 得到的。 |          |
| 30       | [String replaceAll(String regex, String replacement)](https://www.runoob.com/java/java-string-replaceall.html) 使用给定的 replacement 替换此字符串所有匹配给定的正则表达式的子字符串。 |          |
| 31       | [String replaceFirst(String regex, String replacement)](https://www.runoob.com/java/java-string-replacefirst.html)  使用给定的 replacement 替换此字符串匹配给定的正则表达式的第一个子字符串。 |          |
| 32       | [String[\] split(String regex)](https://www.runoob.com/java/java-string-split.html) 根据给定正则表达式的匹配拆分此字符串。 |          |
| 33       | [String[\] split(String regex, int limit)](https://www.runoob.com/java/java-string-split.html) 根据匹配给定的正则表达式来拆分此字符串。 |          |
| 34       | [boolean startsWith(String prefix)](https://www.runoob.com/java/java-string-startswith.html) 测试此字符串是否以指定的前缀开始。 |          |
| 35       | [boolean startsWith(String prefix, int toffset)](https://www.runoob.com/java/java-string-startswith.html) 测试此字符串从指定索引开始的子字符串是否以指定前缀开始。 |          |
| 36       | [CharSequence subSequence(int beginIndex, int endIndex)](https://www.runoob.com/java/java-string-subsequence.html)  返回一个新的字符序列，它是此序列的一个子序列。 |          |
| 37       | [String substring(int beginIndex)](https://www.runoob.com/java/java-string-substring.html) 返回一个新的字符串，它是此字符串的一个子字符串。 |          |
| 38       | [String substring(int beginIndex, int endIndex)](https://www.runoob.com/java/java-string-substring.html) 返回一个新字符串，它是此字符串的一个子字符串。 |          |
| 39       | [char[\] toCharArray()](https://www.runoob.com/java/java-string-tochararray.html) 将此字符串转换为一个新的字符数组。 |          |
| 40       | [String toLowerCase()](https://www.runoob.com/java/java-string-tolowercase.html) 使用默认语言环境的规则将此 String 中的所有字符都转换为小写。 |          |
| 41       | [String toLowerCase(Locale locale)](https://www.runoob.com/java/java-string-tolowercase.html)  使用给定 Locale 的规则将此 String 中的所有字符都转换为小写。 |          |
| 42       | [String toString()](https://www.runoob.com/java/java-string-tostring.html)  返回此对象本身（它已经是一个字符串！）。 |          |
| 43       | [String toUpperCase()](https://www.runoob.com/java/java-string-touppercase.html) 使用默认语言环境的规则将此 String 中的所有字符都转换为大写。 |          |
| 44       | [String toUpperCase(Locale locale)](https://www.runoob.com/java/java-string-touppercase.html) 使用给定 Locale 的规则将此 String 中的所有字符都转换为大写。 |          |
| 45       | [String trim()](https://www.runoob.com/java/java-string-trim.html) 返回字符串的副本，忽略前导空白和尾部空白。 |          |
| 46       | [static String valueOf(primitive data type x)](https://www.runoob.com/java/java-string-valueof.html) 返回给定data type类型x参数的字符串表示形式。 |          |
| 47       | [contains(CharSequence chars)](https://www.runoob.com/java/java-string-contains.html) 判断是否包含指定的字符系列。 |          |
| 48       | [isEmpty()](https://www.runoob.com/java/java-string-isempty.html) 判断字符串是否为空。 |          |