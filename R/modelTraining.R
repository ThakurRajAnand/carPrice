source('utils.R')

#Read the data for modeling
train <- fread('../Data/train.csv',stringsAsFactors = FALSE, data.table = FALSE)
label <- train$price
train$price <- NULL
train[is.na(train)] <- -9999
trainSparse <- sparse.model.matrix(~., data=train)
dtrain <- xgb.DMatrix(trainSparse, label = label)

#Read the 10 folds created by createCrossValidation.R script
cv_folds <- readRDS('../Data/fold.RDS')

#Function for performing k-fold cross-validation for XGBOOST model
xgb_cv_bayes <- function(max.depth, min_child_weight, subsample,colsample,lambda,gamma,alpha) {
  cv <- xgb.cv(params = list(booster = "gbtree", 
                             eta = 0.01,
                             max_depth = max.depth,
                             min_child_weight = min_child_weight,
                             subsample = subsample, 
                             colsample_bytree = colsample,
                             objective = 'reg:gamma',
                             base_score=mean(label)),
               data = dtrain, 
               nround = 1000,
               early_stopping_rounds = 10, 
               maximize = FALSE,
               lambda = lambda,
               gamma = gamma,
               alpha = alpha,
               nthread = 8,
               verbose=0,
               folds = cv_folds,
               eval = 'gamma-deviance'
  )
  #rBayesianOptimization library maximizes the evaluation metric. Gamma Deviance is error metric so we take negative to minimize it.
  optMetricVal <- - cv$evaluation_log[cv$best_iteration]$test_gamma_nloglik_mean
  
  list(Score = optMetricVal)
}


OPT_Res <- BayesianOptimization(xgb_cv_bayes,
                                bounds = list(max.depth = c(3L, 15L),
                                              min_child_weight = c(1L, 10L),
                                              subsample = c(0.5, 0.9),
                                              lambda=c(0.001,2.0),
                                              alpha=c(0.001,2.0),
                                              gamma=c(1L,5L),
                                              colsample=c(0.1,0.9)),
                                init_points = 5, n_iter = 10,
                                acq = "ucb", kappa = 2.576, eps = 0.0,
                                verbose = TRUE)

#Train the model with optimal parameters and save cross-validated predictions
max.depth <-  OPT_Res$Best_Par[1]
min_child_weight <- OPT_Res$Best_Par[2]
subsample <- OPT_Res$Best_Par[3]
lambda <- OPT_Res$Best_Par[4]
alpha <- OPT_Res$Best_Par[5]
gamma <- OPT_Res$Best_Par[6]
colsample <- OPT_Res$Best_Par[7]

optimalParameters <- data.frame(parameter=names(OPT_Res$Best_Par),
                                values=as.numeric(OPT_Res$Best_Par))
fwrite(optimalParameters,'../Data/optimalParameters.csv')

cv <- xgb.cv(params = list(booster = "gbtree", 
                           eta = 0.01,
                           max_depth = max.depth,
                           min_child_weight = min_child_weight,
                           subsample = subsample, 
                           colsample_bytree = colsample,
                           objective = 'reg:gamma',
                           base_score=mean(label)),
             data = dtrain, 
             nround = 1000,
             early_stopping_rounds = 10, 
             maximize = FALSE,
             lambda = lambda,
             gamma = gamma,
             alpha = alpha,
             nthread = 8,
             verbose=0,
             folds = cv_folds,
             eval = 'gamma-deviance',
             prediction = TRUE
)

pvoData <- data.frame(Observed=label,Predicted=cv$pred)
fwrite(pvoData,'../Data/pvoData.csv')

bestIteration <- cv$best_iteration
  
fullModel <- xgb.train(params = list(booster = "gbtree", 
                                  eta = 0.01,
                                  max_depth = max.depth,
                                  min_child_weight = min_child_weight,
                                  subsample = subsample, 
                                  colsample_bytree = colsample,
                                  objective = 'reg:gamma',
                                  base_score=mean(label)),
                    data = dtrain, 
                    nround = bestIteration,
                    maximize = FALSE,
                    lambda = lambda,
                    gamma = gamma,
                    alpha = alpha,
                    nthread = 8,
                    verbose=0
)

featureImportance <- xgb.importance(feature_names = colnames(trainSparse),model=fullModel)
fwrite(featureImportance,'../Data/featureImportance.csv')



