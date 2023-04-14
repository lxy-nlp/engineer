# java的一些工作积累
## ThreadLocal
优点：每个线程会独享一份数据副本，不会有数据同步问题
缺点：1.脏数据
        在线程池中使用ThreadLocal时线程池会重用Thread对象，若是上一个对象没有进行remove操作 则会读取到上一个对象的数据
     2. 弱引用 导致垃圾回收失效
解决方法：
    线程使用后 使用remove

线程并发
1. fast safe 和 fast fail
当线程不安全的集合类使用iterator遍历时 进行删除或增加操作会报错，原因是集合的size与预期size不同
解决方法 加锁
2. 线程同步 的前提或者是原因是 多个线程对同一个共享数据进行操作，需要对线程操作的顺序进行规范

组合和聚合
组合就好似 恩爱的夫妻
聚合就好似 搭伙过日子的夫妻

## CompletableFuture
作用：执行带返回值的异步任务
常用函数
```java
CompletableFuture<String> task = CompletableFuture.supplyAsync(() ->
task.thenAccept(result -> after(result));
task.exceptionally(e -> {
    log.error(e.getMessage(), e);
});
```
supplyAsync() 异步执行的任务
thenAccept()是将异步执行的结果作为输入再在执行 这一步是同步的
exceptionally() 指的是异步任务执行过程中对异常的处理

## 泛型
作用：保障数据安全，提高代码阅读性
通配符
？T ？不限定类型 T实际上是确定的类型
extends 和 super  限定类型是 某个类的子类         父类
使用方法
泛型类
泛型接口
泛型方法

一般会在方法中使用<T>
赋予变量的时候用 ?
