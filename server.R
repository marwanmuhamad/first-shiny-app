library(shiny)
library(shinythemes)
library(tidyverse)
library(DT)



shinyServer(function(input, output) {
  
  output$meanCountry <- renderText({
    m <- data1 %>% filter(country == input$countryInput) %>% 
      select(mLifeExp) %>% pull()
    
    m <- round(m, 2)
    
    paste("Average life Expectancy in ", input$countryInput, " is ", m)
  })
  
  output$lineGraph <- renderPlot({
    data %>% filter(country == input$countryInput) %>% 
      select(country, year, lifeExp) %>% 
      ggplot(aes(x = year, y = lifeExp, color = "#fba812")) + 
      geom_line(show.legend = FALSE, lwd = 1) +
      theme_minimal() +
      labs(title = paste("Life Expectancy in ", input$countryInput),
           x = "Year",
           y = "Life Expectancy")
  })
  
  isolate(output$meanLifeGraph <- renderPlot({
    if (input$showGraphInput)
      if (input$radioInput == "All") {
        data1 %>% ggplot(aes(x = reorder(country, mLifeExp), y = mLifeExp)) +
          geom_bar(stat = "identity", aes(fill = country), show.legend = FALSE) +
          theme_minimal() +
          labs(x = "Countries",
               y = "Average",
               title = "Average Life Expectancy in Different Countries in the World, 1952 - 2007") +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
          scale_y_continuous(expand = c(0,0))
      } else if (input$radioInput == "Top 10") {
        data1 %>% arrange(desc(mLifeExp)) %>% 
          top_n(n = 10) %>%  ggplot(aes(x = reorder(country, mLifeExp), y = mLifeExp)) +
          geom_bar(stat = "identity", aes(fill = country), show.legend = FALSE) +
          theme_minimal() +
          labs(x = "Countries",
               y = "Average",
               title = "Average Life Expectancy in Different Countries in the World, 1952 - 2007") +
          theme(axis.text.x = element_text(hjust = 0.5, vjust = 0.5)) +
          scale_y_continuous(expand = c(0,0))
      } else {
        data1 %>% arrange(mLifeExp) %>% 
          head(n = 10) %>%  ggplot(aes(x = reorder(country, mLifeExp), y = mLifeExp)) +
          geom_bar(stat = "identity", aes(fill = country), show.legend = FALSE) +
          theme_minimal() +
          labs(x = "Countries",
               y = "Average",
               title = "Average Life Expectancy in Different Countries in the World, 1952 - 2007") +
          theme(axis.text.x = element_text(hjust = 0.5, vjust = 0.5)) +
          scale_y_continuous(expand = c(0,0))
      }
      
  }))
  
  output$table <- renderDataTable({
    data
  })

})
