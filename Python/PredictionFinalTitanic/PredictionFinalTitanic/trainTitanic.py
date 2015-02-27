# Mike Dean Prediction Final Project - Titanic Survival ##


# Imports the necessary packages.

import csv as csv ## Allows for the use and manipulation of csv files.
import numpy as np ## Numpy allows for statistical analysis.

fareCeiling = 40
fareBracketSize = 10
numberOfPriceBrackets = fareCeiling / fareBracketSize

csv_file_object = csv.reader(open('../data/train.csv', 'rb')) ## Imports the csv file as a python variable.


header = csv_file_object.next() # Assigns the first line of the csv file as the header so it is not included in the data.

data = [] # Creates an empty list to store the data.

for row in csv_file_object: ## A loop that adds a "row" to the data list for every line in the csv file.
    data.append(row)

data = np.array(data) ## Converts the list to an array for use with the numpy library.

passengers = np.size(data[0::,1].astype(np.float)) ## Counts the number of rows in the data and stores as a floating point variable. This is equal to the number of passengers in the data set.
survived = np.sum(data[0::,1].astype(np.float)) ## Sums the values of the first column of data to determine the number of survivors

propSurvivors = survived / passengers ## Stores the proportion of passengers who survived.

women = data[0::,4] == "female" ## Stores the truth values of the fourth column, where "female" is True.
men = data[0::,4] != "female" ## Stores the truth values of the fourth column, where "male" is True.

womenAboard = data[women,1].astype(np.float) ## Converts the truth values to numbers 0 is male, 1 is female.
menAboard = data[men,1].astype(np.float) ## Converts the truth values to numbers 0 is female, 1 is male.

propWomenSurvivors = np.sum(womenAboard) / np.size(womenAboard) ## Finds the proportion of women who survived.
propMenSurvivors = np.sum(menAboard) / np.size(menAboard) ## Finds the proportion of men who survived.

print 'Proportion of women who survived is %s' % propWomenSurvivors
print 'Proportion of men who survived is %s' % propMenSurvivors ## Displays each of the gender survival proportions.

import csv as csv ## Allows for the use and manipulation of csv files.
import numpy as np ## Numpy allows for statistical analysis.



data[ data[0::,9].astype(np.float) >= fareCeiling, 9 ] = fareCeiling - 1.0



#numberOfClasses = 3

numberOfClasses = len(np.unique(data[0::,2]))

survivalTable = np.zeros((2, numberOfClasses, numberOfPriceBrackets))

for i in xrange(numberOfClasses):
    for j in xrange(numberOfPriceBrackets):

        womenOnlyStats = data[(data[0::,4] == "female")
                               &(data[0::,2].astype(np.float) == i + 1)
                                 &(data[0:,9].astype(np.float) >= (j+1)*fareBracketSize), 1]



        menOnlyStats = data[(data[0::,4] != "female")
                               &(data[0::,2].astype(np.float) == i + 1)
                                 &(data[0:,9].astype(np.float) >= (j+1)*fareBracketSize), 1]

        survivalTable[0,i,j] = np.mean(womenOnlyStats.astype(np.float))
        survivalTable[1,i,j] = np.mean(menOnlyStats.astype(np.float))

        survivalTable[survivalTable != survivalTable] = 0
        survivalTable[survivalTable < 0.5] = 0
        survivalTable[survivalTable >= 0.5] = 1

print survivalTable

