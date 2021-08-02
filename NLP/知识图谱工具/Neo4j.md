![image-20210721161225848](/home/lxy/文档/学习笔记/img/image-20210721161225848.png)

删除数据库的两种方法：

![image-20210722075759365](/home/lxy/文档/学习笔记/img/image-20210722075759365.png)



Neo4j相关操作

```neo4j
MATCH(n:Person) where n.name =~'.*To.*' return n; 模糊查询
match(n) return n limit 10; limit的使用方法
MATCH(n:Person{name:'Tom'}),(s:School{title:'NUAA'})  create(n)-[r:Gra]- >(s); 已有的两个实体创建关系

```