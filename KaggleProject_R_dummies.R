# Package to create dummy variables
library(dummies)

# Preparation of datasets : deleting dates, cnt to log_cnt
train$log_cnt <- log1p(train$cnt)
train <- train[,c(-1,-14)]
test <- test[, -1]

# Creation of dummy variables for season, month, hour, weekday and weathersit
train_season <- dummy(x= "season", data = train)
train_mnth <- dummy(x= "mnth", data = train)
train_weekday <- dummy(x= "weekday", data = train)
train_hr <- dummy(x= "hr", data = train)
train_weathersit <- dummy(x= "weathersit", data = train)

test_season <- dummy(x= "season", data = test)
test_mnth <- dummy(x= "mnth", data = test)
test_weekday <- dummy(x= "weekday", data = test)
test_hr <- dummy(x= "hr", data = test)
test_weathersit <- dummy(x= "weathersit", data = test)

# Putting dummy variables in the dataframes
train <- train[, c(-1, -3, -4, -6, -8)]
train <- cbind(train[,0],train_season, train[,1:8])
train <- cbind(train[,0],train_mnth, train[,1:12])
train <- cbind(train[,0],train_weathersit, train[,1:24])
train <- cbind(train[,0],train_hr, train[,1:28])
train <- cbind(train[,0],train_weekday, train[,1:52])

test <- test[, c(-1, -3, -4, -6, -8)]
test <- cbind(test[,0],test_season, test[,1:7])
test <- cbind(test[,0],test_mnth, test[,1:11])
test <- cbind(test[,0],test_weathersit, test[,1:23])
test <- cbind(test[,0],test_hr, test[,1:27])
test <- cbind(test[,0],test_weekday, test[,1:51])
