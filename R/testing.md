---
title       : Predicting Car Prices using Machine Learning
author      : Thakur Raj Anand
framework   : io2012 # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax,bootstrap,quiz,shiny,interactive]# {mathjax, quiz, bootstrap}
ext_widgets : {rCharts: [libraries/nvd3]}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## OUTLINE

1. Introduction
2. Exploratory Data Analysis
3. Use Cases
4. Target Variable Distribution
5. Model Validation
6. Model Training
7. Model Performance
8. Model Deployment
9. Summary and Next Steps

---

## Intoduction
In this case study we would be exploring the data related to cars given on the following website
https://archive.ics.uci.edu/ml/datasets/Automobile


Data contains 205 rows and 26 columns. Everything is done in R including this HTML deck. All the codes related to this case study can be found in the github following Github repository
https://github.com/ThakurRajAnand/carPrice


---

## Exploratory Data Analysis

|   |variable          | q_zeros| p_zeros| q_na| p_na| q_inf| p_inf|type      | unique|
|:--|:-----------------|-------:|-------:|----:|----:|-----:|-----:|:---------|------:|
|1  |symboling         |      67|   32.68|    0|    0|     0|     0|integer   |      6|
|2  |normalized_losses |       0|    0.00|   41|   20|     0|     0|numeric   |     51|
|3  |make              |       0|    0.00|    0|    0|     0|     0|character |     22|
|4  |fuel_type         |       0|    0.00|    0|    0|     0|     0|character |      2|
|5  |aspiration        |       0|    0.00|    0|    0|     0|     0|character |      2|
|6  |num_of_doors      |       0|    0.00|    0|    0|     0|     0|character |      3|
|7  |body_style        |       0|    0.00|    0|    0|     0|     0|character |      5|
|8  |drive_wheels      |       0|    0.00|    0|    0|     0|     0|character |      3|
|9  |engine_location   |       0|    0.00|    0|    0|     0|     0|character |      2|
|10 |wheel_base        |       0|    0.00|    0|    0|     0|     0|numeric   |     53|
|11 |length            |       0|    0.00|    0|    0|     0|     0|numeric   |     75|
|12 |width             |       0|    0.00|    0|    0|     0|     0|numeric   |     44|
|13 |height            |       0|    0.00|    0|    0|     0|     0|numeric   |     49|

---

## Exploratory Data Analysis

|   |variable          | q_zeros| p_zeros| q_na| p_na| q_inf| p_inf|type      | unique|
|:--|:-----------------|-------:|-------:|----:|----:|-----:|-----:|:---------|------:|
|14 |curb_weight       |       0|       0|    0| 0.00|     0|     0|integer   |    171|
|15 |engine_type       |       0|       0|    0| 0.00|     0|     0|character |      7|
|16 |num_of_cylinders  |       0|       0|    0| 0.00|     0|     0|character |      7|
|17 |engine_size       |       0|       0|    0| 0.00|     0|     0|integer   |     44|
|18 |fuel_system       |       0|       0|    0| 0.00|     0|     0|character |      8|
|19 |bore              |       0|       0|    4| 1.95|     0|     0|numeric   |     38|
|20 |stroke            |       0|       0|    4| 1.95|     0|     0|numeric   |     36|
|21 |compression_ratio |       0|       0|    0| 0.00|     0|     0|numeric   |     32|
|22 |horsepower        |       0|       0|    2| 0.98|     0|     0|numeric   |     59|
|23 |peak_rpm          |       0|       0|    2| 0.98|     0|     0|numeric   |     23|
|24 |city_mpg          |       0|       0|    0| 0.00|     0|     0|integer   |     29|
|25 |highway_mpg       |       0|       0|    0| 0.00|     0|     0|integer   |     30|
|26 |price             |       0|       0|    4| 1.95|     0|     0|numeric   |    186|

---

## Use Cases
There can be many business use cases possible using this data or other similar datasets. Following are some examples 

1 - **Clustering Cars in diferent categories :** We can use unsupervised ML algorithms like K-means, T-SNE for this.   

2 - **Predicting Car Prices :** We can use supervised ML algortihms like Gradient Boosting Machine, Random Forest, GLMs for this.  

We can also predict other variables in this dataset based on the relevance and impact of predicting them on the business. For this study, we will go ahead with predicting Car Prices as it is a very common business problem and can have real impact for a company like **AUTO1**.

---

## Target Variable Distribution
Distribution of Price is skewed and **GAMMA** distribution might be a good choice for the model.

<iframe srcdoc=' &lt;!doctype HTML&gt;
&lt;meta charset = &#039;utf-8&#039;&gt;
&lt;html&gt;
  &lt;head&gt;
    
    &lt;script src=&#039;http://code.jquery.com/jquery-1.9.1.min.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;http://code.highcharts.com/highcharts.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;http://code.highcharts.com/highcharts-more.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;http://code.highcharts.com/modules/exporting.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    
    &lt;style&gt;
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 800px;
      height: 400px;
    }  
    &lt;/style&gt;
    
  &lt;/head&gt;
  &lt;body &gt;
    
    &lt;div id = &#039;chart8334c20c39&#039; class = &#039;rChart highcharts&#039;&gt;&lt;/div&gt;    
    &lt;script type=&#039;text/javascript&#039;&gt;
    (function($){
        $(function () {
            var chart = new Highcharts.Chart({
 &quot;dom&quot;: &quot;chart8334c20c39&quot;,
&quot;width&quot;:            800,
&quot;height&quot;:            400,
&quot;credits&quot;: {
 &quot;href&quot;: null,
&quot;text&quot;: null 
},
&quot;exporting&quot;: {
 &quot;enabled&quot;: false 
},
&quot;title&quot;: {
 &quot;text&quot;: &quot;Price Distribution&quot; 
},
&quot;yAxis&quot;: [
 {
 &quot;title&quot;: {
 &quot;text&quot;: &quot;Frequency&quot; 
} 
} 
],
&quot;xAxis&quot;: [
 {
 &quot;categories&quot;: [ &quot;5000 - 10000&quot;, &quot;10000 - 15000&quot;, &quot;15000 - 20000&quot;, &quot;20000 - 25000&quot;, &quot;25000 - 30000&quot;, &quot;30000 - 35000&quot;, &quot;35000 - 40000&quot;, &quot;40000 - 45000&quot;, &quot;45000 - 50000&quot; ] 
} 
],
&quot;series&quot;: [
 {
 &quot;name&quot;: &quot;Price&quot;,
&quot;type&quot;: &quot;column&quot;,
&quot;data&quot;: [
 98,
41,
37,
8,
3,
6,
5,
2,
1 
],
&quot;color&quot;: &quot;#6D7991&quot;,
&quot;xAxis&quot;:              0,
&quot;yAxis&quot;:              0 
},
{
 &quot;name&quot;: &quot;Price&quot;,
&quot;type&quot;: &quot;spline&quot;,
&quot;data&quot;: [
 98,
41,
37,
8,
3,
6,
5,
2,
1 
],
&quot;color&quot;: &quot;#DD6600&quot;,
&quot;xAxis&quot;:              0,
&quot;yAxis&quot;:              0,
&quot;dashStyle&quot;: &quot;shortdot&quot; 
} 
],
&quot;id&quot;: &quot;chart8334c20c39&quot;,
&quot;chart&quot;: {
 &quot;renderTo&quot;: &quot;chart8334c20c39&quot; 
} 
});
        });
    })(jQuery);
&lt;/script&gt;
    
    &lt;script&gt;&lt;/script&gt;    
  &lt;/body&gt;
&lt;/html&gt; ' scrolling='no' frameBorder='0' seamless class='rChart  highcharts  ' id='iframe-chart8334c20c39'> </iframe>
 <style>iframe.rChart{ width: 100%; height: 400px;}</style>

---

## Model Validation
Two important things to decide before we start to build models are the following  

1 - **Performance Metric :** To measure the performance of our model we need a model performance metric. As we saw earlier that Price is gamma distributed and gamman deviance would be good choice for measuring the performance of our models. 

2 - **Validation Framework :** To make sure that we are not overfitting to the training data we need to use decide a validation framework like train-validation-holdout, k-fold cross-validation, time based validation. In this data we don't have any time element and hence we don't need to worry about time based validation. We will go ahead with 10-fold cross validation and will evaluate the performance of our model out of fold predictions (10 folds in this case)

---

## Model Training
There are many machine learning models which can be used. We will focus on using **XGBOOST** library to train Gradient Boosting Model. XGBOOST has lot of model parameters and details can be found on https://github.com/dmlc/xgboost/blob/master/doc/parameter.md  

To achieve good performance one need to perform parameter tuning. There are many startegies like random search, grid search and bayesian optimization. Lot of research paper have show that Bayesian optimization results in better minima and takes less time in comparison to other search. Optimal parameters are found using **rBayesianOptimization** library after 15 iterations.

---

## Model Training
**Optimal Parameters**

|   |parameter        |     values|
|:--|:----------------|----------:|
|1  |max.depth        | 15.0000000|
|2  |min_child_weight |  1.0000000|
|3  |subsample        |  0.5000000|
|4  |lambda           |  1.9706726|
|5  |alpha            |  0.0082083|
|6  |gamma            |  1.0000000|
|7  |colsample        |  0.9000000|

---

## Model Performance
**Feature Importance**

|   |Feature              |      Gain|     Cover| Frequency|
|:--|:--------------------|---------:|---------:|---------:|
|1  |curb_weight          | 0.6103687| 0.3571479| 0.3553299|
|2  |engine_size          | 0.2007896| 0.3306784| 0.3477157|
|3  |num_of_cylindersfour | 0.0517877| 0.0747613| 0.0634518|
|4  |drive_wheelsrwd      | 0.0401131| 0.0642031| 0.0558376|
|5  |width                | 0.0289809| 0.0465501| 0.0482234|
|6  |fuel_systemmpfi      | 0.0183665| 0.0447153| 0.0456853|
|7  |wheel_base           | 0.0178153| 0.0316715| 0.0329949|
|8  |fuel_system2bbl      | 0.0157192| 0.0268933| 0.0228426|
|9  |length               | 0.0117498| 0.0176442| 0.0203046|
|10 |drive_wheelsfwd      | 0.0026385| 0.0029966| 0.0025381|
|11 |symboling            | 0.0009080| 0.0017064| 0.0025381|
|12 |normalized_losses    | 0.0007626| 0.0010318| 0.0025381|

---

## Model Performance
**Predicted vs Observed**
We can observe that model is not doing good when Car prices were high. This generally tend to be the case when distribution is skewed. There are many ways to improve model in such situations like bias correction, modeling after taking log of the target variable etc. Overall this seems to be a pretty good model :)
<iframe srcdoc=' &lt;!doctype HTML&gt;
&lt;meta charset = &#039;utf-8&#039;&gt;
&lt;html&gt;
  &lt;head&gt;
    
    &lt;script src=&#039;http://code.jquery.com/jquery-1.9.1.min.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;http://code.highcharts.com/highcharts.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;http://code.highcharts.com/highcharts-more.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;http://code.highcharts.com/modules/exporting.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    
    &lt;style&gt;
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 800px;
      height: 400px;
    }  
    &lt;/style&gt;
    
  &lt;/head&gt;
  &lt;body &gt;
    
    &lt;div id = &#039;chart833225e1446&#039; class = &#039;rChart highcharts&#039;&gt;&lt;/div&gt;    
    &lt;script type=&#039;text/javascript&#039;&gt;
    (function($){
        $(function () {
            var chart = new Highcharts.Chart({
 &quot;dom&quot;: &quot;chart833225e1446&quot;,
&quot;width&quot;:            800,
&quot;height&quot;:            400,
&quot;credits&quot;: {
 &quot;href&quot;: null,
&quot;text&quot;: null 
},
&quot;exporting&quot;: {
 &quot;enabled&quot;: false 
},
&quot;title&quot;: {
 &quot;text&quot;: &quot;LIFT CHART&quot; 
},
&quot;yAxis&quot;: [
 {
 &quot;title&quot;: {
 &quot;text&quot;: &quot;Predicted / Observed&quot; 
} 
} 
],
&quot;series&quot;: [
 {
 &quot;name&quot;: &quot;Observed&quot;,
&quot;data&quot;: [
           6692,
          7412,
6914.333333333,
          6789,
          6669,
        6726.4,
          6695,
          6355,
          5572,
          6919,
          5652,
        7095.5,
          6768,
        7116.5,
          6488,
          6902,
        5986.5,
        8276.5,
        7395.5,
          6479,
6352.333333333,
          7354,
          7866,
        7364.5,
        8834.5,
          9685,
          7408,
          8068,
        8257.5,
          9170,
        7760.5,
          7123,
        7841.5,
          8872,
          8735,
          8724,
          8670,
          9614,
        9628.5,
          9749,
          8134,
        8480.5,
       11069.5,
          9762,
          8540,
          9720,
         12095,
          9645,
        9559.5,
         11383,
       11816.5,
       13911.5,
         13564,
       10571.5,
         11102,
       14172.5,
       15447.5,
         11992,
         11742,
         11850,
9127.666666667,
         13529,
         16692,
         12006,
       13519.5,
         11914,
       15957.5,
       16319.5,
       13529.5,
         17391,
       17809.5,
       19727.5,
         14670,
         17790,
         12550,
         16605,
       16976.5,
       17192.5,
         20835,
         16845,
16451.66666667,
         18150,
15141.66666667,
       16209.5,
       17984.5,
         17752,
       21137.5,
         18449,
         18399,
15812.66666667,
       19021.5,
         37028,
         31292,
         30352,
         30304,
         41140,
       36037.5,
         37572,
         34600 
],
&quot;dashStyle&quot;: &quot;shortdash&quot;,
&quot;color&quot;: &quot;#6D7991&quot;,
&quot;type&quot;: &quot;spline&quot; 
},
{
 &quot;name&quot;: &quot;Predicted&quot;,
&quot;data&quot;: [
 7528.985351562,
   7544.453125,
7560.382324219,
7581.204833984,
7592.893066406,
7601.593457031,
7619.216796875,
7624.137695312,
7645.879882812,
7659.870605469,
7683.172851562,
7694.538085938,
7716.386230469,
7760.850830078,
7782.069335938,
7787.729166667,
7845.305175781,
7862.336669922,
7903.947509766,
7933.294433594,
7933.710449219,
7965.569335938,
8071.540039062,
8151.054931641,
8231.994140625,
    8320.71875,
   8390.640625,
8501.795898438,
8558.697753906,
8577.034179688,
8585.384277344,
8633.030273438,
8656.478515625,
8760.034179688,
8831.020019531,
8981.596679688,
9134.463867188,
9324.387695312,
9426.528320312,
9552.276855469,
9808.072753906,
   9918.203125,
9979.918457031,
10030.70703125,
10082.88623047,
10191.87695312,
10250.04150391,
10314.38671875,
10489.55664062,
10716.92822266,
10776.12890625,
10880.36816406,
10990.35839844,
11173.99511719,
11375.67480469,
11648.66064453,
12207.12695312,
12570.84423828,
12922.64892578,
13101.46386719,
13200.69921875,
13430.79150391,
14034.56152344,
  14160.203125,
14215.41210938,
14319.88037109,
14506.10742188,
14618.86669922,
14714.35546875,
15401.27539062,
15686.46337891,
15818.07324219,
15995.06347656,
16120.91845703,
16188.46728516,
16223.12060547,
16411.33691406,
16514.05761719,
16624.31152344,
16719.45117188,
16727.00911458,
16963.49804688,
17005.71289062,
17128.31542969,
17269.97070312,
17423.46972656,
17564.93847656,
17901.24902344,
18306.17773438,
18380.16601562,
18737.14746094,
     23287.625,
23763.67513021,
  24753.796875,
25698.58300781,
  26023.859375,
26210.12792969,
26628.38671875,
27120.47786458 
],
&quot;dashStyle&quot;: &quot;shortdot&quot;,
&quot;color&quot;: &quot;#DD6600&quot;,
&quot;type&quot;: &quot;spline&quot; 
} 
],
&quot;id&quot;: &quot;chart833225e1446&quot;,
&quot;chart&quot;: {
 &quot;renderTo&quot;: &quot;chart833225e1446&quot; 
} 
});
        });
    })(jQuery);
&lt;/script&gt;
    
    &lt;script&gt;&lt;/script&gt;    
  &lt;/body&gt;
&lt;/html&gt; ' scrolling='no' frameBorder='0' seamless class='rChart  highcharts  ' id='iframe-chart833225e1446'> </iframe>
 <style>iframe.rChart{ width: 100%; height: 400px;}</style>


---

## Model Deployment
Next logical step is to deploy this model into production. It depends a lot on the business use case. If model won't be used in real time then batch predictions can be done easily time to time. For real time use cases API based model deployment would be a good choice. Following tutorial provides a good explantation on how to deploy model from R using API
http://www.slideshare.net/JofaiChow/deploying-your-predictive-models-as-a-service-via-domino

---

## Summary and Next Steps
In this case study, we have defined the step by step approach to solve a business problem using machine learning. There are lot of things which can de done to improve models. Following is a list of things we can do  

1 - **Pre-processing :** We can try different ways to impute missing values and see what works best  
2 - **Other Models :** We can also try other models like Random Forest, SVM, Neural Networks, GLMs  
3 - **Ensemble :** We can also train multiple models and then try to combine them which in theory should give an Ensemble which would be better atleast than any individual model  
4 - **Prescriptive :** We have already developed a predictive model but lot of times business requires us to tweak things before using the predictions e.g. During a marketing campaign a credit card company might have multiple channels like Youtube, Google, Facebook etc. then questions becomes which customer should be targeted through which channel. This can be solve by finding the underlying factors which are causing model to predict high or low and they are generally known as the **Reason Codes** in Machine Learning world.

