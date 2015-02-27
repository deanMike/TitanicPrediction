#Mike Dean - Titanic Predictions Using R
#Sets working directory
setwd("C:/Users/Mike/Google Drive/School/2014 - 2015/Fall/Prediction/Final Project/R")
#Sets the train and test data to the csv files provided from Kaggle.com
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")
#Outputs the number of men and the number of women in the training set
summary(train$Sex)
#Creates an incorrect proportion table based on Sex
prop.table(table(train$Sex, train$Survived))
#Creates a proportion table based on Sex of passenger
prop.table(table(train$Sex, train$Survived), 1)
##Estimates that everyone died.
test$Survived <- 0
##Estimates that all females survived
test$Survived[test$Sex == "female"] <- 1
#Gives statistics of the ages of passengers
summary(train$Age)
#Creates a new category in the training set called "Child" and sets the value to '0' for all passengers.
train$Child <- 0
#Sets the Child variable to true for all passengers under 16
train$Child[train$Age < 16] <- 1
##Shows the number of survivors broken down by Sex and whether they were children
aggregate(Survived ~ Child + Sex, data = train, FUN=sum)
##Shows the number of passengers broken down by Sex and whether they were children.
aggregate(Survived ~ Child + Sex, data = train, FUN=length)
##Finds the proportion of survivors to number of passengers broken down by sex and whether they were children.
aggregate(Survived ~ Child + Sex, data = train, FUN = function(x) {sum(x) / length(x)})
#Creates a new variables called Fare2 and sets it to '30+'
train$Fare2 <- '30+'
#Take values from the original Fare column and sets to '20-30' if it falls in that range.
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
#Assigns anything between 10 and 20 in the fare column to '10-20'.
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
#Assigns remaining values to '<10'.
train$Fare2[train$Fare < 10] <- '<10'

##Shows the proportion of survivors based on Fare threshold, Class, and Sex.
aggregate(Survived ~ Fare2 + Pclass + Sex, data = train, FUN = function(x) {sum(x)/length(x)})

##Predicting Survival rate based on above aggregation
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare2 == '30+'] <- 0

submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "output/GenderClassModel.csv", row.names = FALSE)
