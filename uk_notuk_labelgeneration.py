import csv
import os

if __name__ == '__main__':
    print('Begin labelling...')
    hotel_country = {}
    with open('./input/dataset/train_hotel_countries.csv', 'r') as hc:
        hotel_countries = csv.reader(hc)
        for row in hotel_countries:
            hotel_country[row[0]] = row[1]

    with open('./input/dataset/train_set.csv', 'r') as train_set, \
        open('./input/dataset/train_uk.csv','a') as uk,\
        open('./input/dataset/train_not_uk.csv','a') as not_uk:

        train = csv.reader(train_set)
        for img in train:
            country = hotel_country[img[1]]
            line = ','.join([img[0], img[1], country])
            if country.lower().strip() == 'united kingdom':
                uk.write(line)
                uk.write('\n')
            else:
                not_uk.write(line)
                not_uk.write('\n')
    
    print('Label generation complete!')
    