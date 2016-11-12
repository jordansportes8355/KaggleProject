library(caret)
set.seed(42)

train$log_cnt <- log1p(train$cnt)
train <- train[,c(-1, -14)]
model <- train(
  log_cnt ~ ., train,
  tuneGrid = expand.grid(alpha = seq(0.0001, 1, length = 20), lambda = seq(0.0001, 1, length = 20)),
  method = "glmnet",
  trControl = trainControl(method = "cv", number = 50, verboseIter = TRUE)
)

model
pred <- predict(model, test)
exp(pred) - 1

write.csv2(exp(pred) - 1,file= 'soumission_num_glmnet_dummies.csv')
