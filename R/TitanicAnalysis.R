#Mike Dean - Titanic Predictions Using R
setwd("C:/Users/Mike/Google Drive/School/2014 - 2015/Fall/Prediction/Final Project/R")
train <- read.csv("C:/Users/Mike/Google Drive/School/2014 - 2015/Fall/Prediction/Final Project/R/data/train.csv")
test <- read.csv("C:/Users/Mike/Google Drive/School/2014 - 2015/Fall/Prediction/Final Project/R/data/test.csv")

str(train)

table(train$Survived)

prop.table(table(train$Survived))

test$Survived <- rep(0,418)
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "theyallperish.csv", row.names = FALSE)

