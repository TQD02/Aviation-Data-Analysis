library(janitor)  
library(dplyr)
library(tree)
library(rpart)
library(rpart.plot)
library(randomForest)
library(caret)
library(class)

setwd("C:/Users/t0m/OneDrive/Desktop/FALL 2023/CIS 3920")

AviationData <- read.csv('AviationData-2020-2023.csv', header = TRUE, na.strings = c("", "NA"))
summary(AviationData)
AviationData <- data.frame(AviationData %>% select(AmateurBuilt,WeatherCondition,NumberOfEngines,AirCraftDamage))

cleaned_AviationData <- na.omit(AviationData)

summary(cleaned_AviationData)

barplot(table(cleaned_AviationData$AirCraftDamage), col = "skyblue", main = "Distribution of AirCraftDamage")

cleaned_AviationData$AmateurBuilt <- as.factor(cleaned_AviationData$AmateurBuilt)
cleaned_AviationData$WeatherCondition <- as.factor(cleaned_AviationData$WeatherCondition)
cleaned_AviationData$AirCraftDamage <- as.factor(cleaned_AviationData$AirCraftDamage)

attach(cleaned_AviationData)

logistic_model <- glm(AirCraftDamage ~ AmateurBuilt + WeatherCondition + NumberOfEngines, 
                      data = cleaned_AviationData, 
                      family = binomial)

summary(logistic_model)

train_indices <- sample(nrow(cleaned_AviationData), nrow(cleaned_AviationData) * 0.8)

data_train <-cleaned_AviationData[train_indices, ]
data_test <- cleaned_AviationData[-train_indices, ]

model <- tree(AirCraftDamage ~., data = cleaned_AviationData, subset = train_indices)

summary(model)

jpeg("flightTree.jpg")
plot(model)
text(model,pretty=0)
dev.off()


cv_tree <- cv.tree(model, K = 10, FUN=prune.misclass)
plot(cv_tree)

model_RF <- randomForest(AirCraftDamage ~ ., data = data_train)

plot(model_RF)

predictions_RF <- predict(model_RF, data_test)

table(predictions_RF,data_test$AirCraftDamage)

confusion_matrix_RF <- confusionMatrix(predictions_RF, data_test$AirCraftDamage)

confusion_matrix_RF

importance(model_RF)

varImpPlot(model_RF)