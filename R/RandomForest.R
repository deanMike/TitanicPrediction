#Mike Dean - Titanic Predictions Using R
#Sets working directory
setwd("C:/Users/Mike/Google Drive/School/2014 - 2015/Fall/Prediction/Final Project/R")
#Sets the train and test data to the csv files provided from Kaggle.com
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")
##Sample the test data
sample(1:10, replace = TRUE)
combination <- rbind(train, test)
summary(combination$Age)

Agefit <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize, data=combination[!is.na(combination$Age),], method="anova")

combination$Age[is.na(combination$Age)] <- predict(Agefit, combination[is.na(combination$Age),])

summary(combination)

summary(combination$Embarked)

which(combination$Embarked == '')

combination$Embarked[c(62, 830)] = "S"

combination$Embarked <- factor(combination$Embarked)

summary(combination$Fare)

which(is.na(combination$Fare))
combination$Fare[1024] <- median(combination$Fare, na.rm = TRUE)

combination$FamilyID2 <- combination$FamilyID
combination$FamilyID2 <- as.character(combination$FamilyID2)
combination$FamilyID2[combination$FamilySize <= 3] <- 'Small'
combination$FamilyID2 <- factor(combination$FamilyID2)

train <- combination[1:891,]
test <- combination[892:1309,]

install.packages('randomForest')
library(randomForest)
set.seed(415)

fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID2, data=train, importance=TRUE, ntree=2000)

Prediction <- predict(fit, test, type = "class")
##Store the correct columns only in the submit variable
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
##Output a submiittable csv file.
write.csv(submit, file = "output/RandomForest.csv", row.names = FALSE)
fancyRpartPlot(fit)

