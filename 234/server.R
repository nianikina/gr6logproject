Comp <- read.csv("datatotal.csv")
List <- read.csv("questions.csv")
library(recommenderlab)
library(dplyr)

function(input, output) {
  ### Вектор создание
  results <<- rep("", nrow(List))
  ### Присваиваем имя
  names(results)  <<- List[,1]
  
  output$MainAction <- renderUI( {
    dynamicUi()
  })
  dynamicUi <- reactive({
    ### Реакция на нажатие кнопки
    if (input$Click.Counter==0) 
      return(
        list(
          h3("Welcome to loginator!"),
          h3("From logists with love")
        )
      )
    if (input$Click.Counter>0 & input$Click.Counter<=nrow(List))  
      return(
        list(
          h3(textOutput("question")),
          radioButtons("survey", "Please select:",
                       option.list()))
      )
    
    if (input$Click.Counter>nrow(List))
      return(
        list(
          h2("Thanks you for your answers! In hope, our service was helpful for you! ;)")
        )
      )    
  })
 ### Сохранение результатов 
  output$save.results <- renderText({
    
    if ((input$Click.Counter>0)&(input$Click.Counter<=nrow(List)))
      try(results[input$Click.Counter] <<- input$survey)
    
    if (input$Click.Counter==nrow(List)+1) {
      if (file.exists("survey.results.Rdata")) 
        load(file="survey.results.Rdata")
      if (!file.exists("survey.results.Rdata")) 
        presults<-NULL
      presults <- presults <<- rbind(presults, results)
      rownames(presults) <- rownames(presults) <<- 
        paste("User", 1:nrow(presults))
      save(presults, file="survey.results.Rdata")
    }
    
  })
  
  option.list <- reactive({
    qlist <- List[input$Click.Counter,3:ncol(List)]
    as.matrix(qlist[qlist!=""])
  })
  
  output$question <- renderText({
    paste0(
      List[input$Click.Counter,1]
    )
  })
  
  
  
}


