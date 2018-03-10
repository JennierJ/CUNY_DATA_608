
library(shiny)
library("dplyr")
library("ggplot2")

# Load data
mortality <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv")

as.character(mortality$ICD.Chapter)

# Question 2

ui <- fluidPage(
  
  # Application title
  titlePanel("Mortality Rate"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "Cause",
                  label = "Cause of Death:", 
                  choices = unique(mortality$ICD.Chapter),
                  selected = "Neoplasms"),
      selectInput(inputId = "Year",
                  label = "Year:", 
                  choices = unique(mortality$Year),
                  selected = "2000")
    ),
    
    
    mainPanel(
      plotOutput("ratePlot")
    )
  )
)

server <- function(input, output) {
  output$ratePlot <- renderPlot({
    ggplot((filter(mortality, mortality$ICD.Chapter == input$Cause, mortality$Year == input$Year)), aes(x=reorder(State, Crude.Rate), y=Crude.Rate)) + 
      geom_bar(stat="identity", fill="#FF9999") + geom_hline(aes(yintercept = mean((filter(mortality, mortality$ICD.Chapter == input$Cause, mortality$Year == input$Year))$Crude.Rate)), colour="yellow", linetype="dashed", size = 2)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

