

#install.packages("shiny")
#install.packages("dplyr")
#install.packages("ggplot2")


library(shiny)
library("dplyr")
library("ggplot2")

# Load data
mortality <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv")
# Subset the 2010 data
mortality_2010 <- select((filter(mortality, Year == "2010")), ICD.Chapter, State, Crude.Rate)
#View(mortality_2010)

as.character(mortality_2010$ICD.Chapter)

# Question 1

ui <- fluidPage(
   
   # Application title
   titlePanel("Rank of States by Crude Mortality for 2010"),
   
   sidebarLayout(
      sidebarPanel(
         selectInput(inputId = "Cause",
                     label = "Cause of Death:", 
                     choices = unique(mortality_2010$ICD.Chapter),
                     selected = "Neoplasms")
      ),
      
      mainPanel(
         plotOutput("rankPlot")
      )
   )
)

server <- function(input, output) {
#  subset1 <- 
   output$rankPlot <- renderPlot({
     ggplot((filter(mortality_2010, mortality_2010$ICD.Chapter == input$Cause)), aes(x=reorder(State, Crude.Rate), y=Crude.Rate)) + 
       geom_bar(stat="identity", fill="#FF9999")
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

