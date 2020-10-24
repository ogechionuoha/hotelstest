from __future__ import print_function
import csv, multiprocessing, cv2, os
import numpy as np
import urllib.request

class AppURLopener(urllib.request.FancyURLopener):
    version = "Mozilla/5.0"

opener = AppURLopener()
def url_to_image(url):
    resp = opener.open(url)
    image = np.asarray(bytearray(resp.read()), dtype="uint8")
    image = cv2.imdecode(image, cv2.IMREAD_UNCHANGED)
    return image

# chain,hotel,im_source,im_id,im_url
def download_and_resize(chain,hotel,im_source,im_id,im_url):
    # print('Beginning downloads...')
    try:
        save_dir = os.path.join('./images/train/',chain,hotel,im_source)
        if not os.path.exists(save_dir):
            os.makedirs(save_dir)

        save_path = os.path.join(save_dir,str(im_id)+'.'+im_url.split('.')[-1])

        if not os.path.isfile(save_path):
            img = url_to_image(im_url)
            if img.shape[1] > img.shape[0]:
                width = 640
                height = int(round((640 * img.shape[0]) / img.shape[1]))
                img = cv2.resize(img,(width, height))
            else:
                height = 640
                width = int(round((640 * img.shape[1]) / img.shape[0]))
                img = cv2.resize(img,(width, height))
            cv2.imwrite(save_path,img)
            with open("./log/good.txt", "a") as good:
                good.write(save_path)
                good.write("\n")
            # print("Good: {0}".format(save_path))
            # uncomment above line you want running output, Or just count lines in good.txt
        else:
            print('Already saved: ' + save_path)
    except:
        with open("./log/bad.txt", "a") as bad:
            bad.write(save_path)
            bad.write("\n")
        # print('Bad: ' + save_path)
        # uncomment above line you want running output of cases that had an exception, Or just count lines in bad.txt


def main():
    hotel_f = open('./input/dataset/hotel_info.csv','r')
    hotel_reader = csv.reader(hotel_f)
    # hotel_headers = next(hotel_reader,None)
    hotel_to_chain = {}
    for row in hotel_reader:
        hotel_to_chain[row[0]] = row[2]
 
    with open('./input/dataset/train_set.csv','r') as train_f:
        train_reader = csv.reader(train_f)
        # skip n lines
        # for i in range(100000): next(train_reader)
        pool = multiprocessing.Pool(processes=2*multiprocessing.cpu_count())
        results = [pool.apply_async( download_and_resize, [ hotel_to_chain[hotel] , hotel , image_src, image_id, image_url ] )
                                   for image_id, hotel, image_url, image_src, image_date in train_reader ]
        pool.close()
        pool.join()


if __name__ == '__main__':
    main()