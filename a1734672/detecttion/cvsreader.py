import csv
import numpy as np

datalist = []
with open('test.csv', newline='\n') as csvfile:
    print("open")

    spamreader = csv.reader(csvfile, delimiter='\t', quotechar='|')
    for row in spamreader:
        test_matrix = np.array(row).astype(float).reshape((8,8))
        datalist.append(test_matrix)

    for text_matrix in datalist:
        print(test_matrix)