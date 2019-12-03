# server.R
# Backend functionality for NLP Predictor Shiny Web App

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$nextWord <- renderText(input$inputstring)
  

})
