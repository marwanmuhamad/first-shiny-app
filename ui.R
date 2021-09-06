library(tidyverse)
library(shiny)
library(shinythemes)



shinyUI(fluidPage(theme = shinytheme(theme = "yeti"),
  title = "Shiny App",
  
  sidebarLayout(
    
    sidebarPanel = sidebarPanel(width = 3,
      helpText("Select Country to Preview Average Life Expectancy"),
      selectInput("countryInput", "Show One", selected = country[1], choices = country),
      checkboxInput("showGraphInput", "Show All Countries"),
      conditionalPanel(
          condition = "input.showGraphInput == true",
          radioButtons("radioInput", label = "Select Preview", choices = c("All", "Top 10", "Bottom 10"),
                       selected = NULL)
                                  )
    ),  
    mainPanel = mainPanel(width = 9,
      h3("Main Window"),
      # h4("Average Life Expectancy"),
      tabsetPanel(type = "pills", id = "tabset",
     
        tabPanel(title = "Graph", icon = icon("bar-chart-o"), value = "graph",
                 br(),
                 textOutput(outputId = "meanCountry"),
                 hr(),
                 plotOutput(outputId = "lineGraph"),
                 hr(),
                 br(),
                 plotOutput(outputId = "meanLifeGraph"),
                 hr()
                 
                 
                 ),
        tabPanel(title = "Table", icon = icon("table"), value = "tablex",
                 br(),
                 dataTableOutput(outputId = "table")
                 )
      )
    
    )
  )
)
)

# shiny::runApp(appDir = "C:/Users/Marwah/Documents/R/shiny", launch.browser = TRUE)
