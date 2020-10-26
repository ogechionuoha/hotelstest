#!/bin/bash

# Variable Declarations
INPUT_VOL="/HOTELS-50K/input"
IMAGE_VOL="/HOTELS-50K/images"
PRETRAINED_VOL="/HOTELS-50K/pretrained_model"
PRETRAINED_DIR="$PRETRAINED_VOL/hotels50k_snapshot"
DATASET_DIR="$INPUT_VOL/dataset" 
TESTIMAGE_DIR="$IMAGE_VOL/test"
TESTIMAGE_URL="https://cs.slu.edu/~stylianou/images/hotels-50k/test.tar.lz4"
PRETRAINED_URL="https://www2.seas.gwu.edu/~astylianou/hotels50k/hotels50k_snapshot.tar.gz"

#Extract dataset meta data to input directory.
echo "Extracting dataset metadats..."
# Check if datasets directory exists
if [ ! -d $DATASET_DIR ]; then
	# wget -O $INPUT_VOL/dataset.tar.gz "$DATASETURL"
	# if [ $? -eq 0 ]; then
		tar xvf $INPUT_VOL/dataset.tar.gz -C $INPUT_VOL
        echo "Dataset extracted to volume!"
	# fi
else
	# Dataset directory already exists
	echo "Dataset preloaded on volume"
fi

#download test images to images folder to preserve structure.
echo "Obtaining Test images..."
# Check if test images exist
if [ ! -d $TESTIMAGE_DIR ]; then
	if [ ! -f $IMAGE_VOL/test.tar.lz4 ]; then
		wget "$TESTIMAGE_URL" -P $IMAGE_VOL/ --no-check-certificate
        echo "Test images downloaded!"
	fi
    lz4 -d -v $IMAGE_VOL/test.tar.lz4 $IMAGE_VOL/test.tar
    tar xvf $IMAGE_VOL/test.tar -C $IMAGE_VOL/
    echo "Test images extracted to volume!"
else
	# Dataset directory already exists
	echo "Test images directory found on volume"
fi

#Get pretrained model
# Check if pretrained model exist
echo "Obtaining Pretrained model..."
if [ ! -d $PRETRAINED_DIR ]; then
	if [ ! -f $PRETRAINED_VOL/hotels50k_snapshot.tar.gz ]; then
		wget "$PRETRAINED_URL" -P $PRETRAINED_VOL --no-check-certificate
        echo "Pretrained model downloaded!"
	fi
    tar xvf $PRETRAINED_VOL/hotels50k_snapshot.tar.gz -C $PRETRAINED_VOL/
    echo "Pretrained model extracted to volume!"
else
	# Dataset directory already exists
	echo "Pretrained model directory found on volume"
fi

echo "SETUP COMPLETE!"
exit 0