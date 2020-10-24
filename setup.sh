#!/bin/bash

#extract dataset metadata
tar xvzf ./input/dataset.tar.gz -C ./input

#Extract test images
lz4toolsCli -d /HOTELS-50K/images/test.tar.lz4
tar xvf ./images/test.tar -C ./images

#Extract pretrianed model
cd pretrained_model
tar xzvf hotels50k_snapshot.tar.gz

cd ..

python faster_download_train.py


