FROM tensorflow/tensorflow:latest-gpu

LABEL maintainer="oge.blessing@gmail.com"

#install wget
RUN apt-get install wget

#Copy files
WORKDIR /
RUN mkdir /HOTELS-50K
WORKDIR /HOTELS-50K
COPY . .

#VOLUME ./input ./images

#install dependencies 
RUN pip install -r requirements.txt

#install other dependencies
RUN pip install --upgrade tf_slim
RUN pip install lz4tools 
RUN pip install faiss-gpu

#Extract files --optionally remove run on start of container
#RUN tar xvzf ./input/dataset.tar.gz -C ./input

#download test images to images folder to preserve structure.
RUN wget https://cs.slu.edu/~stylianou/images/hotels-50k/test.tar.lz4 -P ./images/ --no-check-certificate
#--optionally remove and run on start of container
#RUN lz4toolsCli -d ./images/test.tar.lz4
#RUN tar xf ./images/test.tar -C ./images

#Get pretrained model
WORKDIR /HOTELS-50K
#VOLUME ./pretrained_model
WORKDIR /HOTELS-50K/pretrained_model
RUN wget https://www2.seas.gwu.edu/~astylianou/hotels50k/hotels50k_snapshot.tar.gz
#--optionally remove and run on start of container
#RUN tar xvzf hotels50k_snapshot.tar.gz

#Replace this with tar gz pull and extraction
#!python /content/Hotels-50K/download_train.py

WORKDIR /HOTELS-50K
ENTRYPOINT [ "/bin/bash" ]