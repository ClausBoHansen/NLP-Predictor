# server.R
# Backend functionality for NLP Predictor Shiny Web App

# Load NextTerm function
source("NextTerms.R")



library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$nextWord <- renderText(NextTerms(input$inputstring))
  

})
