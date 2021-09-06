library(tidyverse)
library(DT)
library(scales)
library(gapminder)
# data <- readr::read_csv(r"{C:\Users\Marwah\Documents\R\data\gapminder.csv}")
data <- gapminder::gapminder

cols = c("lifeExp", "gdpPercap")
for (col in cols) {
  data[[col]] <- round(data[[col]], 2)
}

cols2 = c("lifeExp", "pop", "gdpPercap")

# for (col in cols2) {
#   data[[col]] <- scales::comma(data[[col]], accuracy = 2)
# }
# data %>% glimpse()

data1 <- data %>% 
  select(country, lifeExp) %>% 
  group_by(country) %>% 
  summarise(mLifeExp = mean(lifeExp, na.rm = TRUE))

country <- data1 %>% pull(country)




