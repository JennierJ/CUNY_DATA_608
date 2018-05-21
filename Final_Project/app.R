
library(shiny)
library(DT)
library(ggplot2)
library("dplyr")

mydata <- read.csv(url("https://raw.githubusercontent.com/JennierJ/CUNY_DATA_608/master/Final_Project/Drinking_Water_Quality_Distribution_Monitoring_Data.csv"))

# Data Cleaning. Remove N/A and blank data.
mydata[mydata == ""] <- NA
mydata <- na.omit(mydata)
mydata <- subset(mydata, select = -c(Sample.Number))

colnames(mydata)[colnames(mydata) == "Sample.Date"] <- "Date"
colnames(mydata)[colnames(mydata) == "Sample.Time"] <- "Time"
colnames(mydata)[colnames(mydata) == "Sample.Site"] <- "Site"
colnames(mydata)[colnames(mydata) == "Sample.class"] <- "Class"
colnames(mydata)[colnames(mydata) == "Location" ] <- "Location"
colnames(mydata)[colnames(mydata) == "Residual.Free.Chlorine..mg.L." ] <- "Chlorine Level"
colnames(mydata)[colnames(mydata) == "Turbidity..NTU." ] <- "Turbidity"
colnames(mydata)[colnames(mydata) == "Fluoride..mg.L." ] <- "Fluoride Level"
colnames(mydata)[colnames(mydata) == "Coliform..Quanti.Tray...MPN..100mL." ] <- "Coliform"
colnames(mydata)[colnames(mydata) == "E.coli.Quanti.Tray...MPN.100mL." ] <- "E.coli Level"



ui <- fluidPage(
  titlePanel("Table"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("date",
                       "Sample Date:",
                       c("All",
                         unique(as.character(mydata$Date))))
    ),
    column(4,
           selectInput("location",
                       "Sample Location:",
                       c("All",
                         unique(as.character(mydata$Location))))
    ),
    column(4,
           selectInput("site",
                       "Site:",
                       c("All",
                         unique(as.character(mydata$Site))))
    )
  ),
  # Create a new row for the table.
  fluidRow(
    DT::dataTableOutput("table")
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- mydata
    if (input$date != "All") {
      data <- data[data$Date == input$date,]
    }
    if (input$location != "All") {
      data <- data[data$Location == input$location,]
    }
    if (input$site != "All") {
      data <- data[data$Site == input$site,]
    }
    data
  }))
  
}

# Run the application 
shinyApp(ui = ui, server = server)

