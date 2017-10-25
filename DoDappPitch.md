Shifting and Scaling Predictors
========================================================
author: Laks
date: 10/24/2017
autosize: true
<small>
Github Source code URL: https://github.com/lakshmikumarn/developmentofDataproducts
</small>

Purpose
========================================================
<small>
The shiny app is created to give a simple & interactive view of shifting and scaling the predictors for a given dataset and visually see the impact to the linear regression model coefficients - intercept and slope based on the type of change - add or subtract a constant which is referred as shifting and multiply or divide by a constant referred here as scaling.

#### About App:
The app has two sliders one to scale and other to shift by a value. For each change all values of  predictors Xi will be updated and the new regression model will be created. Using this model the coeffecients are extracted and printed under the section *Coefficients of Modified Model*.We will use qplot to plot the points and draw a abline passing the intercept and slope everytime the new linear regression model is created.

**What is not the objective of this app:**
This app does not intend to validate the effectiveness of the linear model using residual analysis etc. The dataset is created randomly using *runif* function. With the given context let us delve into the application details.
</small>

Inputs and Outputs
========================================================
<small>
The ui.R file has the typical sidebarpanel and mainpanel to hold the sliders and the plot respectively. The server.R has the core logic embedded. In the shinyServer function *set.seed* is invoked so that the results are reprodicible as it was created. Using *runif*  random values are created and assigned to two variables x & y and the same is plotted. 

A linear regression model and line is created for this dataset using *lm* function with y as the outcome and x as the predictor. *PrintCoeff()* is an utility function that takes x and y vectors perform the lm modeling and returns the coefficients vector. The invoking function then prints the intercept and slope. This function is used by original and modified coefficients sections displayed in the UI.

We use **reactive** function to extract the input$scale and input$shift values from ui.R slider widgets. This inturn dispatches to an internal utility function to perform the actual change to the x/predictor values.

</small>

Case 1 - Predictor values unscaled and unshifted
========================================================


```
[1] "Initialized data"
```


```
[1] " Intercept (b0) =  923.462  , Slope (b1) =  0.008"
```

![plot of chunk unnamed-chunk-2](DoDappPitch-figure/unnamed-chunk-2-1.png)

Case 2 - Predictor values scaled (by 4) and shifted (by 50)
========================================================


```
[1] " Intercept (b0) =  923.365  , Slope (b1) =  0.002"
```

![plot of chunk unnamed-chunk-3](DoDappPitch-figure/unnamed-chunk-3-1.png)


