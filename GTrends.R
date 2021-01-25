# Load the packages
library(gtrendsR)
library(ggplot2)
library(dplyr)

# Lets analyze some data

data_from_trends = gtrends(c('watsapp', 'signal'))


View(data_from_trends)

#  Create a data frame
iot = data_from_trends$interest_over_time


iot_date = iot %>% 
  filter(date > '2020-01-01')

#  visualize the data
ggplot(iot_date, aes(x = date,
                     y = hits, col = keyword)) +
  geom_line() + theme_light()+
  labs(title = 'watsapp vs Signal',
       subtitle = 'Google Trends Report',
       caption = 'package:gtrendsR')


