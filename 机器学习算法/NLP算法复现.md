# NLP算法复现



## Pytorch Tips(随时记录,随时补充)

1. torch.unsqueeze() 和  torch.squeeze()

   ```python
   import torch
   torch.unsqueeze(tensor,dim)
   在张量的指定维度增加一维
   torch.squeeze(tensor,dim)
   在张量的指定维度减少一维 只针对 指定维度为1的情况
   ```


## 第一个点针对SemTask8数据集的任务

实验结果上来看位置编码是有效的,加上位置编码要比没加位置编码的方法的精准率高3%

流程图照着这个画



![image-20210322210615022](/home/lxy/.config/Typora/typora-user-images/image-20210322210615022.png)





20210325 实验记录

之前出现过拟合的现象,加入dropout后精准率提升了近6个点 证明 了dropout是有用的

![image-20210325105922643](/home/lxy/.config/Typora/typora-user-images/image-20210325105922643.png)





过拟合的现象仍然存在,下一步的打算是shuffle训练集

shuffle之后的结果 精准率提升了2个点

![image-20210325151604119](/home/lxy/.config/Typora/typora-user-images/image-20210325151604119.png)

batch_size 从50增加后到100

![image-20210325155449314](/home/lxy/.config/Typora/typora-user-images/image-20210325155449314.png)





检测shuffle是否正确

![image-20210325143558843](/home/lxy/.config/Typora/typora-user-images/image-20210325143558843.png)

![image-20210325143350726](/home/lxy/.config/Typora/typora-user-images/image-20210325143350726.png)

![image-20210325143411585](/home/lxy/.config/Typora/typora-user-images/image-20210325143411585.png)

![image-20210325143452659](/home/lxy/.config/Typora/typora-user-images/image-20210325143452659.png)	



Spacy的使用

需要spacy和其对应的模型版本一致 否则将会报错





CRCNN

![image-20210412030728937](/home/lxy/.config/Typora/typora-user-images/image-20210412030728937.png)

![image-20210412030744772](/home/lxy/.config/Typora/typora-user-images/image-20210412030744772.png)

![image-20210412030817841](/home/lxy/.config/Typora/typora-user-images/image-20210412030817841.png)

![image-20210413204510901](/home/lxy/.config/Typora/typora-user-images/image-20210413204510901.png)



![image-20210415162729507](/home/lxy/.config/Typora/typora-user-images/image-20210415162729507.png)

```shell
目前做的是单向的 是否后续要改双向的
```





```shell
运行pytorch时，训练很正常，但是如果切换到eval()模式之后再继续训练， 发现报错：

RuntimeError: cudnn RNN backward can only be called in training mode

原因分析：由于在训练时，设置的是net.train()   切换到预测模式时, 设置为net.eval(), 再回到训练环节，此时的网络依然是eval()模式，因此出现上述bug, 只要在继续训练模型之前加上net.train()即可完美解决问题

```

```shell
查看英伟达显卡使用情况
nvidia-smi
```

```python
gpu和cpu的互换使用
将模型放到gpu中训练
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

model = model.to(device)
将训练的X 和 标签Y做相同的操作

将gpu转为cpu 
tensor.cpu()
```



统计标签个数

![image-20210507135940807](/home/lxy/文档/学习笔记/img/image-20210507135940807.png)

```python
{'Instrument-Agency(e1,e2)': 97,
 'Component-Whole(e2,e1)': 471,
 'Entity-Origin(e1,e2)': 568,
 'Entity-Destination(e1,e2)': 844,
 'Member-Collection(e2,e1)': 612,
 'Entity-Destination(e2,e1)': 1,
 'Content-Container(e2,e1)': 166,
 'Cause-Effect(e1,e2)': 344,
 'Product-Producer(e2,e1)': 394,
 'Entity-Origin(e2,e1)': 148,
 'Instrument-Agency(e2,e1)': 407,
 'Other': 1410,
 'Message-Topic(e1,e2)': 490,
 'Message-Topic(e2,e1)': 144,
 'Component-Whole(e1,e2)': 470,
 'Cause-Effect(e2,e1)': 659,
 'Content-Container(e1,e2)': 374,
 'Product-Producer(e1,e2)': 323,
 'Member-Collection(e1,e2)': 78}
```

```python
关于parser.add_argument()记录一个特殊的情况：action

栗子1：self.parser.add_argument('--lr_use', action='store_true', default=False, help='if or not use lr_loss')

当在终端运行的时候，如果不加入--lr_use, 那么程序running的时候，lr_use的值为default: False

如果加上了--lr_use,不需要指定True/False,那么程序running的时候，lr_use的值为True

栗子2:  self.parser.add_argument('--no_flip', action='store_false', help='.....')

当在终端运行的时候，并没有加入--no_flip, 数据集中的图片并不会翻转，打印出来看到no_flip的值为True

Note：有default值的时候，running时不声明就为默认值，

没有的话，如果是store_false,则默认值是True，如果是store_true,则默认值是False

实在记不住搞混的话，可以每次在run之前print出来看一下值是true还是false，这样比较保险
```





位置编码 实体交互





加pos的

![image-20210507194627126](/home/lxy/文档/学习笔记/img/image-20210507194627126.png)

加入哈达玛乘积

![image-20210511084036408](/home/lxy/.config/Typora/typora-user-images/image-20210511084036408.png)

加了pos和哈达玛乘积的

![image-20210507205126911](/home/lxy/文档/学习笔记/img/image-20210507205126911.png)

![image-20210507211007573](/home/lxy/文档/学习笔记/img/image-20210507211007573.png)

baseline

![image-20210508180148036](/home/lxy/文档/学习笔记/img/image-20210508180148036.png)



加入pos_emb后的结果







## NER第二个点子 命名实体识别

### Simplify the Usage of Lexicon in Chinese NER 

针对这篇论文中对

![image-20210707101325844](/home/lxy/文档/学习笔记/img/image-20210707101325844.png)

基于BERT的词典注意力中文命名实体识别

改进的点 ： 词典整合计算-----> 注意力加权替换原来的词频加权

```python
    parser = argparse.ArgumentParser()
    parser.add_argument('--embedding',  help='Embedding for words', default='None')
    parser.add_argument('--status', choices=['train', 'test'], help='update algorithm', default='train')
    parser.add_argument('--modelpath', default="save_model/")
    parser.add_argument('--modelname', default="model")
    parser.add_argument('--savedset', help='Dir of saved data setting', default="data/save.dset")
    parser.add_argument('--train', default="ResumeNER/train.char.bmes")
    parser.add_argument('--dev', default="ResumeNER/dev.char.bmes" )
    parser.add_argument('--test', default="ResumeNER/test.char.bmes")
    parser.add_argument('--seg', default="True")
    parser.add_argument('--extendalphabet', default="True")
    parser.add_argument('--raw')
    parser.add_argument('--output')
    parser.add_argument('--seed',default=1023,type=int)
    parser.add_argument('--labelcomment', default="")
    parser.add_argument('--resultfile',default="result/result.txt")
    parser.add_argument('--num_iter',default=100,type=int)
    parser.add_argument('--num_layer', default=4, type=int)
    parser.add_argument('--lr', type=float, default=0.0015)
    parser.add_argument('--batch_size', type=int, default=1)
    parser.add_argument('--hidden_dim', type=int, default=300)
    parser.add_argument('--model_type', default='lstm')
    parser.add_argument('--drop', type=float, default=0.5)

    parser.add_argument('--use_biword', action='store_true', dest='use_biword', default=False)
    # parser.set_defaults(use_biword=False)
    parser.add_argument('--use_char', action='store_true', dest='use_char', default=False)
    # parser.set_defaults(use_biword=False)
    parser.add_argument('--use_count', action='store_true', default=True)
    parser.add_argument('--use_bert', action='store_true', default=False)

```



#### WeiboNER

参数设置

```python
--train data/ResumeNER/train.char.bmes --dev data/ResumeNER/dev.char.bmes --test data/ResumeNER/test.char.bmes --modelname Resume --savedset data/Resume.dset --hidden_dim 200
```



原有的

![image-20210711084640812](/home/lxy/.config/Typora/typora-user-images/image-20210711084640812.png)



现有的

![image-20210714180227208](/home/lxy/文档/学习笔记/img/image-20210714180227208.png)

![image-20210726074959861](/home/lxy/文档/学习笔记/img/image-20210726074959861.png)

```
--train data/WeiboNER/train.all.bmes --dev data/WeiboNER/dev.all.bmes --test data/WeiboNER/test.all.bmes --modelname Weibo --savedset data/Weibo.dset --lr=0.005 --hidden_dim 200   --use_bert
```

![image-20210726124905462](/home/lxy/.config/Typora/typora-user-images/image-20210726124905462.png)

#### MSRA

```python
--train data/ResumeNER/train.char.bmes --dev data/ResumeNER/dev.char.bmes --test data/ResumeNER/test.char.bmes --modelname Resume --savedset data/Resume.dset --hidden_dim 200 
```



![image-20210715085026405](/home/lxy/文档/学习笔记/img/image-20210715085026405.png)

![image-20210715133536380](/home/lxy/文档/学习笔记/img/image-20210715133536380.png)

```python
--train data/ResumeNER/train.char.bmes --dev data/ResumeNER/dev.char.bmes --test data/ResumeNER/test.char.bmes --modelname Resume --savedset data/Resume.dset --hidden_dim 200 --use_biword  --use_char
```

 acc: 0.9697, p: 0.9502, r: 0.9472, f: 0.9487

![image-20210715201856230](/home/lxy/文档/学习笔记/img/image-20210715201856230.png)



```
--train data/WeiboNER/train.all.bmes --dev data/WeiboNER/dev.all.bmes --test data/WeiboNER/test.all.bmes --modelname Weibo --savedset data/Weibo.dset --lr=0.005 --hidden_dim 200 --use_char --use_biword --model_type cnn
```

![image-20210724091140321](/home/lxy/.config/Typora/typora-user-images/image-20210724091140321.png)

![image-20210724130431802](/home/lxy/.config/Typora/typora-user-images/image-20210724130431802.png)



cnn 注意力 + bert

![image-20210726175032666](/home/lxy/.config/Typora/typora-user-images/image-20210726175032666.png)



cnn+词频+bert

![image-20210727083709100](/home/lxy/文档/学习笔记/img/image-20210727083709100.png)





ResumeNER

![image-20210727195049008](/home/lxy/文档/学习笔记/img/image-20210727195049008.png)



![image-20210728080958900](/home/lxy/.config/Typora/typora-user-images/image-20210728080958900.png)