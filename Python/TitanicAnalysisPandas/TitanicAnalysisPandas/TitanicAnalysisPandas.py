## Mike Dean - Prediction Final Project - Titanic Data Analysis using python and pandas.

import pandas as pd
import numpy as np
import pylab as P

df = pd.read_csv('../data/train.csv', header = 0)

print df
print df.head(3)
print type(df)
print df.dtypes
print df.info
print df.describe()
print df['Age'][0:10]
print df.Age[0:10]
print df.Cabin[0:10]
print df.Age.mean()
print df.Age.median()
print df[['Sex', 'Pclass', 'Age']]
print df.Age > 60
print df[df.Age > 60]
print df[df.Age > 60] [['Sex', 'Pclass', 'Age', 'Survived']]
print df[df.Age.isnull()][['Sex', 'Pclass', 'Age']]
for i in range(1,4):
    print i, len(df[(df.Sex == 'male') & (df.Pclass == i)])
df.Age.hist()
P.show()
df.Age.dropna().hist(bins = 16, range = (0,80), alpha = .5)
P.show()

df['Gender'] = 4
df['Gender'] = df.Sex.map(lambda x: x[0].upper())
df['Gender'] = df.Sex.map( {'female': 0, 'male': 1}).astype(int)

df['Boarded'] = 7
df['Boarded'] = df.Embarked.map( {'S': 1, 'Q': 2, 'C': 3})

medianAges = np.zeros((2,3))
medianAges

for i in range(0, 2):
    for j in range(0, 3):
         medianAges[i,j] = df[(df['Gender'] == i)
                              & (df['Pclass'] == j + 1)]['Age'].dropna().median()
medianAges

df['AgeFill'] = df.Age

df[df['Age'].isnull()][['Gender','Pclass', 'Age', 'AgeFill']].head(10)

for i in range(0, 2):
    for j in range(0, 3):
        df.loc[ (df.Age.isnull()) & (df.Gender == i) & (df.Pclass == j+1),\
                'AgeFill'] = medianAges[i,j]
        print medianAges[i, j]

df [df['Age'].isnull()][['Gender', 'Pclass', 'Age', 'AgeFill']].head(10)

df['FamilySize'] = df['SibSp'] + df['Parch']

df['Age*Class'] = df.AgeFill * df.Pclass

df.dtypes[df.dtypes.map(lambda x: x=='object')]

df = df.drop(['Name', 'Sex', 'Ticket', 'Cabin', 'Embarked'], axis = 1)

df = df.drop(['Age'], axis = 1)

df = df.drop(['PassengerId'], axis = 1)

df = df.dropna()

trainData = df.values