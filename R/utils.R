#Load useful libraries
library(data.table)
library(readr)
library(funModeling)
library(caret)
library(ranger)
library(xgboost)
library(rBayesianOptimization)
library(rCharts)
library(devtools)
library(slidify)
library(slidifyLibraries)
library(xtable)
library(knitr)
library(Matrix)
library(Ckmeans.1d.dp)

#Useful Functions
PvO11 <- function(observed,predicted,main){
  FnNtile <- ecdf(predicted)
  resultsPvO <- data.frame(Predicted = predicted,Observed = observed,Percentiles=ceiling(FnNtile(predicted)*100))
  PlotPvO <- aggregate(resultsPvO,by=list(resultsPvO$Percentiles),FUN=mean)
  #Predicted <- PlotPvO[,c("Percentiles","Predicted")]
  #names(Predicted) <- c("Percentiles","Values")
  #Observed <- PlotPvO[,c("Percentiles","Observed")]
  #names(Observed) <- c("Percentiles","Values")
  h1 <- Highcharts$new()
  #h1$series(name = 'Observed',data = Observed$Values, dashStyle = "shortdash",color='#6D7991',type = "spline")
  #h1$series(name = 'Predicted',data = Predicted$Values, dashStyle = "shortdot",color='#DD6600',type = "spline")
  h1$series(name = 'Observed',data = PlotPvO$Observed, dashStyle = "shortdash",color='#6D7991',type = "spline")
  h1$series(name = 'Predicted',data = PlotPvO$Predicted, dashStyle = "shortdot",color='#DD6600',type = "spline")
  h1$title(text=main)
  h1$yAxis(list(list(title = list(text = 'Predicted / Observed'))))
  h1$show("iframesrc", cdn = TRUE)
}