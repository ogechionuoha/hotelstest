FROM tensorflow/tensorflow:latest-gpu

LABEL maintainer="oge.blessing@gmail.com"

#install relevant libs
RUN apt-get install wget
RUN apt install -y libgl1-mesa-glx 
RUN apt install -y liblz4-tool
RUN apt-get -y update
RUN apt-get -y install vim

#Copy files
WORKDIR /
RUN mkdir /HOTELS-50K
WORKDIR /HOTELS-50K
RUN mkdir pretrained_model
COPY . .

#install dependencies 
RUN pip install -r requirements.txt

#install other dependencies
RUN pip install --upgrade tf_slim
RUN pip install faiss-gpu

#start command
ENTRYPOINT [ "/bin/bash" ]