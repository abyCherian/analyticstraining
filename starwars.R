
# Load the packages -------------------------------------------------------


library(tidyverse)
library(gganimate)
library(hrbrthemes)
library(dplyr)
library(plotly)


# open starwars package ---------------------------------------------------

data("starwars")


# remove NAs from each coloumn --------------------------------------------


starwars.data = starwars %>% 
  drop_na(height,hair_color,birth_year,mass,homeworld)


# Check if there are any NAs ----------------------------------------------

is.na(starwars.data)

d1 = starwars.data %>% 
  filter(skin_color %in% c('brown','red','green','blue'))

# Create a bar char using ggpot2 ------------------------------------------

head(d1)

d2 =ggplot(d1,aes(x = mass,
              y = birth_year,
              fill = species))+
  geom_bar(stat = 'identity')+
  theme_bw()


# Create a plotly chart ---------------------------------------------------


ggplotly(d2,tooltip = 'text')


# Setup an API Key --------------------------------------------------------
# Create an plotly account
#  Visit https://chart-studio.plotly.com and generate an API key


Sys.setenv('plotly_username' = 'aby123')
Sys.setenv('plotly_api_key' = 'BQDAxHeO59ChFYQV1ws3')


api_create(d2,'Starwars_bar1')

