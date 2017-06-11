library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("LOGINATOR"),
  
  sidebarPanel(
    h6(textOutput("save.results")),
    h3("Created by: group 6")
  ),
  
  
  
  mainPanel(
    uiOutput("MainAction"),
    actionButton("Click.Counter", "Next"), 
    h3("Your ideal company is"),
    imageOutput("image2"))
))
