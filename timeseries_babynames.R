
# install babynames and hrbrthemes ----------------------------------------


install.packages('babynames')
install.packages('hrbrthemes')


# Load the libraries  -----------------------------------------------------


library(dplyr)
library(ggplot2)
library(plotly)
library(babynames)
library(viridis)
head(babynames)


# filter the data ---------------------------------------------------------



data = babynames %>% 
  filter(name %in% c('Ashely','Amanda','Jessica','Particia','Linda',
                     'Deborah','Dorothy','Betty','Betty','Helen')) %>% 
     filter(sex =="F" )


b = data %>% 
  ggplot(aes(x = year,
             y = n,
             fill = name,
             text = name
  ))+
  geom_area() +
  scale_fill_viridis(discrete = T)

b + plot_ly(tooltip = 'text')


# plotly ------------------------------------------------------------------



b = ggplotly(b,tooltip = 'text')


