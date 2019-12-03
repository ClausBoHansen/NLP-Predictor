# ui.R
# User interface definition for NLP Predictor Shiny Web App

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Prediction of next word"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       textInput("inputstring", "Enter beginning of string")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("nextWord")
    )
  )
))
