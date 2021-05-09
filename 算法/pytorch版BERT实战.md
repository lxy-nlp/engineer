# pytorch使用BERT实战bert

## tensorflow模型转换成pytorch版本b	

从google官网上下载tensorflow版本的bert模型,然后 利用https://github.com/huggingface/transformers中提供的转换代码进行转换

```shell
python convert_bert_original_tf_checkpoint_to_pytorch.py --tf_checkpoint_path /home/lxy/下载/NLP/BERT//uncased_L-12_H-768_A-12/bert_model.ckpt --bert_config_file /home/lxy/下载/NLP/BERT//uncased_L-12_H-768_A-12/bert_config.json --pytorch_dump_path /home/lxy/下载/NLP/BERT/uncased_L-12_H-768_A-12/pytorch_model.bin
```



注意: 虚拟环境中需要同时存在tensorflow 和 pytorch 

pytorch高版本转换出来的模型不能在低版本上使用 会报错

使用过程

1. 分词(BERT是基于字进行分词的)
2. 提取id





