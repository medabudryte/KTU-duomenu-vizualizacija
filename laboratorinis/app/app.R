library(shiny)
library(dplyr)
library(tidyverse)
# data input
duom = read.csv("lab_sodra.csv", encoding = "UTF-8")
duom = duom[duom$ecoActCode == 681000,]

# front end
ui = fluidPage(
  
  titlePanel("681000"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("company", "Choose company", distinct(duom, duom$code))
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# back end
server = function(input, output, session){
  output$distPlot = renderPlot({
    duom[duom$code ==input$company,] %>%
      select(month, avgWage) %>%
      ggplot(aes(x = month, y = avgWage))+
      geom_point() +
      scale_x_continuous("Month",breaks=202101:202112,limits=c(202101,202112)) + 
      geom_line() +
      theme_light()
  })
}
shinyApp(ui, server)
