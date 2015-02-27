#Mike Dean - Titanic Predictions Using R
#Sets working directory
setwd("C:/Users/Mike/Google Drive/School/2014 - 2015/Fall/Prediction/Final Project/R")
#Sets the train and test data to the csv files provided from Kaggle.com
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")
##Import Recursive Partitioning and Regression Trees package
library(rpart)
## Run a fitting algorithm on the training data set to generate a classification tree
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")
## Plot the decision tree
plot(fit)
text(fit)
##Setting up better visualization packages.
install.packages('rattle')
install.packages('rpart.plot')
install.packages('RColorBrewer')
library(rattle)
library(rpart.plot)
library(RColorBrewer)
##Better looking decision tree.
fancyRpartPlot(fit, cex = 1)
##Run the decision tree algorithm on the training data.
Prediction <- predict(fit, test, type = "class")
##Store the correct columns only in the submit variable
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
##Output a submiittable csv file.
write.csv(submit, file = "output/DecisionTree.csv", row.names = FALSE)
##Find the default limits of a standard decision tree in rpart
?rpart.control
##Playing with the parameters of the decision tree.
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class", control = rpart.control(minsplit = 5, cp = 0.001))
fancyRpartPlot(fit)
##Above performed much worse on the dataset, this is an example of overfitting.
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class", control = rpart.control(minSplit = 10, cp = 0))
fancyRpartPlot(fit)
##Pruning decision tree by hand
new.fit <- prp(fit,snip=TRUE)$obj
fancyRpartPlot(new.fit)

