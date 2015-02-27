#Mike Dean - Titanic Predictions Using R
#Sets working directory
setwd("C:/Users/Mike/Google Drive/School/2014 - 2015/Fall/Prediction/Final Project/R")
#Sets the train and test data to the csv files provided from Kaggle.com
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")
##Setting up better visualization packages.
install.packages('rattle')
install.packages('rpart.plot')
install.packages('RColorBrewer')
library(rattle)
library(rpart.plot)
library(RColorBrewer)
##Taking a look at the first name on the list.
train$Name[1]
##Add a Survived column to the test data.
test$Survived <- NA
##Bind the two datasets together starting with the training set and then the test set.
combination <- rbind(train, test)
##Convert the factorized strings back to regular strings.
combination$Name <- as.character(combination$Name)
combination$Name[1]
##Split the string into 3 strings corresponding with last name, salutation, and first + middle names.
strsplit(combination$Name[1], split='[,.]')
strsplit(combination$Name[1], split='[,.]')[[1]]
##Isolate the salutation.
strsplit(combination$Name[1], split='[,.]')[[1]][2]
##Apply the salutation isolation to all values in the Name column of the datafram.
combination$Title <- sapply(combination$Name, FUN=function(x) {strsplit(x, split = '[,.]')[[1]][2]})
##Remove the space from the beginning of the title.
combination$Title <- sub(' ', '', combination$Title)
table(combination$Title)
##Combining rare titles
#Combining Mademoiselle and Madame
combination$Title[combination$Title %in% c('Mme', 'Mlle')] <- 'Mlle'
#Combining many male titles into Sir
combination$Title[combination$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
#Combining many female titles ino Lady
combination$Title[combination$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'
##Revert the strings back to a factor for analysis.
combination$Title <- factor(combination$Title)
##Combining Siblings and Spouses with Parents and Children and add 1 for family size
combination$FamilySize <- combination$SibSp + combination$Parch + 1
#Create a new variable called surname.
combination$Surname <- sapply(combination$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})
#Create a family ID based on Surname and family size (this assumes there are no two families that are the same size with the same last name.)
combination$FamilyID <- paste(as.character(combination$FamilySize), combination$Surname, sep = "")
##Any family with 1 or 2 people is considered "Small".
combination$FamilyID[combination$FamilySize <= 2] <- 'Small'
##Take a look at the family IDs as a table
table(combination$FamilyID)
##Store this table as a dataframe.
famIDs <- data.frame(table(combination$FamilyID))
##Show the families considered to be "Small"
famIDs <- famIDs[famIDs$Freq <= 2,]
##Disassemble the combination dataset back into the train and test sets.
train <- combination[1:891,]
test <- combination[892:1309,]
## Run a new decision tree including the newly engineered variables. ##
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID,
             data=train, method="class")
Prediction <- predict(fit, test, type = "class")
##Store the correct columns only in the submit variable
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
##Output a submiittable csv file.
write.csv(submit, file = "output/FeatureEngineering.csv", row.names = FALSE)
fancyRpartPlot(fit)

