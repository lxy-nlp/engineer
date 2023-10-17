# java知识
## 包装类型缓存机制
Integer Byte Short Integer Long这四种包装类型默认创建[-128,127]的缓存数据，
Integer b = new Integer(3); 会重新建立对象，不使用缓存
会出现Integer a = 3； 但 b == a 为false，包装类型的比较需要用equals比较

## String，new String(),  String.valueOf()
String a = "aaa";  会在常量区 生成字符串对象，a指向这个对象
String b = new String("bbb");  会在常量区生成 bbb 字符串对象， 并会在堆 生成 对象 b，b指向常量区的 bbb