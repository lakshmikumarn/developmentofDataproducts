#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title 
  
  titlePanel("Impact of change in predictor Shift & Scale in linear regression"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("shift",
                   "Shift Predictor",
                   min = 0,
                   max = 100, 
                   value = 0)
      , sliderInput("scale",
                   "Scale Predictor",
                   min = 1,
                   max = 100,
                   value = 1)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("lmPlot")
       ,h3("Coefficients of Original Model")
       ,textOutput("coeffOrig")
       ,h3("Coefficients of Modified Model")
       ,textOutput("coeffModif")
    )
    
  )
  
))
