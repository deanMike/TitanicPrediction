import csv as csv
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier

import TitanicAnalysisPandas as tap
import TitanicAnalysisPandasTest as taptest

forest = RandomForestClassifier(n_estimators = 100)

forest = forest.fit(tap.trainData[0::, 1::], tap.trainData[0::, 0])

output = forest.predict(taptest.testData)

outputInt = output.astype(int)

#csvTestPandas = csv.writer(open('../output/RandomForest.csv', 'wb'))

np.savetxt('../output/RandomForestInt.csv', output, newline = ',')

