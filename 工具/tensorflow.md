## tensorborad可视化

```python
import tensorflow as tf

g = tf.Graph()
with g.as_default() as g:
    tf.train.import_meta_graph('./model.meta')

with tf.Session(graph=g) as sess:
    file_writer = tf.summary.FileWriter(logdir='./pic', graph=g)
   
```



```shell
 tensorboard --logdir pic/

点击网址后查看
```



## 加载已经训练好的模型进行训练

总共分为三步

加载graph  获取placeholder 获取运算变量

```python
    with tf.Session() as sess:
        # 1. 加载graph
        graph = tf.get_default_graph()
        saver = tf.train.import_meta_graph(meta_path, graph=graph)
        # sess = tf.Session(graph=graph)
        ckpt = tf.train.latest_checkpoint(save_model_path)  # 找到存储变量值的位置
        saver.restore(sess, ckpt)
        # 2. graph.get_operation_by_name获取需要feed的placeholder
        # 注意: 这些tensor的名字需要跟模型创建的时候对应
        input_x = graph.get_operation_by_name('input_x').outputs[0]
        seq_length = graph.get_operation_by_name('seq_length').outputs[0]
        learning_rate = graph.get_operation_by_name('learning_rate').outputs[0]
        is_train = graph.get_operation_by_name('is_train').outputs[0]
        # 3. 获取运算变量
        pred = graph.get_operation_by_name('CRF/cond_2/Merge').outputs[0]
        # print(pred)
        tag_result = []
        for test_batch_x, test_batch_l in zip(pad_word_ids_list, sequence_length):
            # test_batch_x, test_batch_l = np.array(test_batch_x).reshape((1, 150)), np.array(test_batch_l).reshape((1, ))
            # test_feed_dict = {
            #     input_x: test_batch_x,
            #     seq_length: test_batch_l,
            #     learning_rate: 0.0001,
            #     is_train: 0,
            # }
            prediction = sess.run(pred, feed_dict={
                input_x: np.array(test_batch_x).reshape((1, 150)),
                seq_length: np.array(test_batch_l).reshape((1, )),
                learning_rate: 0.0001,
                is_train: 0,
            })
```

