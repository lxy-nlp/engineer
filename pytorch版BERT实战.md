# pytorch使用BERT实战

## tensorflow模型转换成pytorch版本

从google官网上下载tensorflow版本的bert模型,然后 利用https://github.com/huggingface/transformers中提供的转换代码进行转换

```shell
python convert_bert_original_tf_checkpoint_to_pytorch.py --tf_checkpoint_path /home/lxy/下载/NLP/BERT//uncased_L-12_H-768_A-12/bert_model.ckpt --bert_config_file /home/lxy/下载/NLP/BERT//uncased_L-12_H-768_A-12/bert_config.json --pytorch_dump_path /home/lxy/下载/NLP/BERT/uncased_L-12_H-768_A-12/pytorch_model.bin
```







