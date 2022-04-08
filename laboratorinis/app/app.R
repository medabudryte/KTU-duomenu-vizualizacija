library(shiny)
library(readr)
library(tidyverse)
duom = read.csv("lab_sodra.csv")
duom = duom[duom$ecoActCode = 681000,]
ui = fluidPage(
  
  titlePanel("Imoniu vidutinio atlyginimo grafikai"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Company", "Iveskite imones koda", distinct(duom, duom$code))),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server = function(input, output, session) {
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
