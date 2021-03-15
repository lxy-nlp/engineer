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


## 针对SemTask8数据集的任务