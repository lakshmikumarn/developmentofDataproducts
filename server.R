#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# initialize the variables 
x = NULL
y = NULL

## Creates the linear regression model and returns coefficients for the given x , y vectors
## y is considered the outcome and x is considered as the predictors
printCoeff <- function(x,y){
  mod <- lm(y ~ x)
  cf  <- coefficients(mod)
}

scaleNshift <- function(x,sc, sh){
  return ((x * sc) + sh) # Scale & Shift the predictors ***** Not full enclosed Parathesis needed else return takes only the first part.. crazy ?
}


# Define server logic
shinyServer(function(input, output) {
  
   # Just to avoid repeated resetting in case the shinyServer gets invoked for a given session
   if (is.null(x)) { 
     set.seed(12345)
     x = runif(100,1,100)/3
     y = runif(100,10,100)*15
     print("Initialized data")
   }  
  
  ## Sends coefficients to UI layer for displaying Original model information
  output$coeffOrig <- renderText({ 
                cf <- printCoeff(x,y)
                paste(" Intercept (b0) = ",round(cf[1],3), " , Slope (b1) = ", round(cf[2],3) )
              })
  
  ## Reactive function to accept scale and shift values and perform the scaling & return the coefficients
  modPred <- reactive({ 
    scale <- input$scale
    shift <- input$shift
    # print(scale)
    # print(shift)
    scaleNshift(x,scale, shift)
  })

  ## Renders the plot and refreshes for every change in the reactive world(silder values)
  output$lmPlot <- renderPlot({
  coeff <-  printCoeff(modPred(),y)
  qplot(modPred(),y, xlab ="x", color = I(x)) + geom_abline(intercept = round(coeff[1],3) , slope =  round(coeff[2],3) +10 ) 
   
  })
  
  ## Sends coefficients to UI layer for displaying modified model information
  ## note the use of renderText to create the reactive block that needs to get refreshed
  ## for every change in the slider value and hence the model
  ## R will throw error if the non-rective block invokes a reactive variable directly or indirectly through functions
  ## here modPred()
  
  output$coeffModif <- renderText({ 
                        cf <- printCoeff(modPred(),y) 
                        paste(" Intercept (b0) = ",round(cf[1],3), " , Slope (b1) = ", round(cf[2],3)  )                    
    })
  
  
})
