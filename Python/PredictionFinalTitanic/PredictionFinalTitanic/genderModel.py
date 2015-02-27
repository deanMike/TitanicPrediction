import csv as csv ## Allows for the use and manipulation of csv files.
import numpy as np ## Numpy allows for statistical analysis.

csvFile = open('../data/test.csv', 'rb')
csvFileObject = csv.reader(csvFile)

headerTest = csvFileObject.next()

predictionFile = open('../output/genderbasedmodel.csv', 'wb')
predictionFileObject = csv.writer(predictionFile)



predictionFileObject.writerow(["PassengerId", "Survived"])
for row in csvFileObject:       # For each row in test.csv
    if row[3] == "female":         # is it a female, if yes then                                       
        predictionFileObject.writerow([row[0],'1'])    # predict 1
    else:                              # or else if male,       
        predictionFileObject.writerow([row[0],'0'])    # predict 0
predictionFile.close()
csvFile.close()
