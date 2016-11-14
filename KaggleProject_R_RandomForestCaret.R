library(psy)
library(caret)
library(caretEnsemble)
library(mlbench)
library(ranger)
library(e1071)

expliquer <- "log_cnt"
explicatives <- c("dteday", "hr", "holiday", "weekday", "workingday", "weathersit", "temp", "atemp", "hum", "windspeed", "weekend")
fpca(data=train, y=expliquer, x=explicatives, partial="No")

set.seed(42)
model <- train(
  log_cnt ~ dteday + hum + temp + weathersit + windspeed + hr + weekday + weekend + holiday,
  tuneGrid = data.frame(mtry = c(2:8)),
  data=train, method = "ranger", num.trees = 5000,
  trControl = trainControl(method = "cv", number = 5, verboseIter = TRUE))

model
plot(model)
pred <- predict(model, test)
pred
exp(pred) - 1
write.csv2(exp(pred) - 1,file= 'soumission_less_variables_atemp.csv')
