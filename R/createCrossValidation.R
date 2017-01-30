source('utils.R')
train <- fread('../Data/train.csv', stringsAsFactors = FALSE, data.table = FALSE)
#Remove the rows which have missing Price
train <- train[!is.na(train$price),]
fwrite(train,'../Data/train.csv')
fold <- createFolds(train$price,10)
#Save fold list to RDS format. We will use it during model training.
saveRDS(fold,'../Data/fold.RDS')
