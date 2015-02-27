#Mike Dean - Titanic Predictions Using R
setwd("C:/Users/Mike/Google Drive/School/2014 - 2015/Fall/Prediction/Final Project/R")
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")

sum(train$Survived)

summary(train$Embarked)

sum(grepl("Master", train$Name))

sum(grepl("Dr.", train$Name))
