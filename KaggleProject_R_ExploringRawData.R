# Understanding the structure of the data
class(train) #class of data object
dim(train) #dimensions of data
names(train) #columns names

# Go deeper
str(train) #preview of data with helpful details
library(dplyr) 
glimpse(train) #from dplyr package, similar to str function
summary(train) #summary of data

# Looking at the data
head(train) #view top of dataset; 'n' argument for the number of rows
tail(train) #viex bottom of dataset; 'n' argument for the number of rows

# Visualizing your data ! A REGARDER POUR TOUTES LES VARIABLES
hist(train$cnt) #view histogram of a single variable
plot(train$atemp, train$cnt) #view plot of two variables

# Introduction to tidyr ! NE PAS FAIRE
library(tidyr) #very useful to manipulate dataframe 
# gather() - gather columns into key-value pairs
# spread() - spread key-value pairs into columns
# seperate() - seperate one column into multiple
# Seperate function for the date ? Keep just days ?
train <- separate(train, dteday, c("year", "month", "day"))
test <- separate(test, dteday, c("year", "month", "day"))
# unite() - unite multiple columns into one
train <- train[, c(-1, -2)]
test <- test[, c(-1, -2)]
str(train)

# Convert type ! NE PAS FAIRE
train$season=as.factor(train$season)
train$weather=as.factor(train$weathersit)
train$holiday=as.factor(train$holiday)
train$workingday=as.factor(train$workingday)

test$season=as.factor(test$season)
test$weather=as.factor(test$weathersit)
test$holiday=as.factor(test$holiday)
test$workingday=as.factor(test$workingday)

# Importance of hr variable ! NE PAS FAIRE

boxplot(train$cnt~train$hr,xlab="hour", ylab="count")
boxplot(log(train$cnt)~train$hr,xlab="hour",ylab="log(count)")
train$hr=as.integer(train$hr) # convert hour to integer
test$hr=as.integer(test$hr) # modifying in both train and test data set

library(rpart)
library(rattle) #these libraries will be used to get a good visual plot for the decision tree model. 
library(rpart.plot)
library(RColorBrewer)
d=rpart(cnt~hr,data=train)
fancyRpartPlot(d)

train$dp_reg=0
train$dp_reg[train$hr<8]=1
train$dp_reg[train$hr>=22]=2
train$dp_reg[train$hr>9 & train$hr<18]=3
train$dp_reg[train$hr==8]=4
train$dp_reg[train$hr==9]=5
train$dp_reg[train$hr==20 | train$hr==21]=6
train$dp_reg[train$hr==19 | train$hr==18]=7

test$dp_reg=0
test$dp_reg[test$hr<8]=1
test$dp_reg[test$hr>=22]=2
test$dp_reg[test$hr>9 & test$hr<18]=3
test$dp_reg[test$hr==8]=4
test$dp_reg[test$hr==9]=5
test$dp_reg[test$hr==20 | test$hr==21]=6
test$dp_reg[test$hr==19 | test$hr==18]=7

# Extracting the day ! NE PAS FAIRE
date=substr(train$dteday,1,10)
days<-weekdays(as.Date(date))
train$day=days
boxplot(train$cnt~train$day,xlab="hour", ylab="count")

# Dealing with the date
library(lubridate)
train$dteday <- ymd(train$dteday)
test$dteday <- ymd(test$dteday)
train <- train[,c(-2, -3, -4)]
test <- test[,c(-3, -4)]

#log cnt 
train$log_cnt <- log1p(train$cnt)
test$cnt <- exp(test$log_cnt) - 1

# Variable weekend
train$weekend <- ifelse(train$holiday == 0 & train$workingday == 0, 1, 0)
test$weekend <- ifelse(test$holiday == 0 & test$workingday == 0, 1, 0)
