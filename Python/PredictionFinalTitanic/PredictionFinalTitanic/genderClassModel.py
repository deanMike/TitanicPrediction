import csv as csv ## Allows for the use and manipulation of csv files.
import numpy as np ## Numpy allows for statistical analysis.
import trainTitanic as train

testFile = open('../data/test.csv','rb')
testFileObject = csv.reader(testFile)

header = testFileObject.next()

predictionsFile = open('../output/genderClassModel.csv','wb')
predictionsFileObject = csv.writer(predictionsFile)

predictionsFileObject.writerow(["PassengerId", "Survived"])

for row in testFileObject:
    for j in xrange(train.numberOfPriceBrackets):
        try:
            row[8] = float(row[8])
        except:
            binFare = 3 - float(row[1])
            break
        if row[8] > train.fareCeiling:
            binFare = train.numberOfPriceBrackets - 1
            break
        if row[8] >= j * train.fareBracketSize and row[8] < (j + 1) * train.fareBracketSize:
            binFare = j
            break
        if row[3] == 'female':
            predictionsFileObject.writerow([row[0], "%d" % int(train.survivalTable[0, float(row[1]) - 1, binFare])])
        else:
            predictionsFileObject.writerow([row[0], "%d" % int(train.survivalTable[1, float(row[1]) - 1, binFare])])
testFile.close()
predictionsFile.close()