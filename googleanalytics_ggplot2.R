library(googleAnalyticsR) #Analytics package
library(googleAuthR)  #Access Google Oauth
library(ggplot2) # Load the ggplot2 package
library(patchwork) # Load the ggplot2 package


# Load the Google Analytics and Google Auth libraries 
ga_auth()

#  Create an object to store the details
ga_account <- ga_account_list()

#  Select the View ID
ga_account$viewId

#  Choose the master level data based on your GA Filter
ViewId <- 220069060

ga_data <- google_analytics(
  viewId = ViewId,
  date_range = c('30DaysAgo', 'yesterday'),
  metrics = c('sessions', 'users', 'bounceRate'),
  dimensions = c('date', 'source', 'medium')
)

# It's time to do Data Cleaning

# Rounding off bounceRate variable to 2 Digits
ga_data$bounceRate <- round(ga_data$bounceRate,digits = 2)

# Changing 'source','medium' into 'factor'

ga_data$source <- factor(ga_data$source)

ga_data$medium <- factor(ga_data$medium)


# Let's view the data

head(ga_data)

#  Let's plot now using ggplot2

#  Scatter plot

ggplot(ga_data, aes(
  x = date,
  y = sessions,
  color = medium,
  shape = medium
)) +
  geom_point(size = 3) +
  labs(title = 'Google analytics sessions data till last 30 days',
       xlab = ' date',
       ylab = 'sessions') +
  facet_grid(medium ~ source)

#  Plot using geom_density
  
  ggplot(ga_data, aes(x = users,
                      fill = medium)) +
  geom_density(alpha = 0.5)

ggplot(ga_data, aes(x = users,
                    fill = medium)) +
  
  geom_histogram(alpha = 0.7)


#  Box plot


ggplot(ga_data, aes(x = users,
                    y = source)) +
  
  geom_boxplot()

#  Faceting

ggplot(ga_data,aes(x = users))+
  geom_histogram()+
  
  facet_wrap(~source, nrow = 4)

ggplot(ga_data, aes(x = users,
                    fill = medium)) +
  geom_density(alpha = 0.5) +
  facet_grid(source ~ .)

#  Bar chart

ggplot(ga_data,aes(x = medium,
                   y = date,
                   fill = medium,
                   group = medium))+
  geom_col()

#  Line plots

ggplot(ga_data, aes(x = date,
                    y = sessions)) +
  geom_line(aes(color = bounceRate))

#  Adding themes

ggplot(ga_data,aes(x = date,
                   y = sessions,
                   color = medium,
                   shape = medium))+
  geom_point(size = 3)+
  labs(title = 'Google analytics sessions data till last 30 days',
       xlab = ' date',
       ylab = 'sessions')+
  theme(
    plot.title = element_text(
      face = 'bold.italic',
      size = '14',
      colour = 'brown'
    ),
    axis.title = element_text(face = 'bold.italic',
                              size = 10,
                              color = 'brown'),
    axis.text = element_text(
      face = 'bold',
      size = 9,
      colour = 'darkblue'
    ),
    panel.background = element_rect(fill = 'white',
                                    colour = 'darkblue'),
    panel.grid.major.y  = element_line(colour = 'grey',
                                       linetype = 1),
    panel.grid.minor.y = element_line(colour = 'grey',
                                      linetype = 2),
    panel.grid.minor.x = element_blank(),
    legend.position = 'top'
  )

# Multiple graphs per page

p1 <- ggplot(ga_data,aes(x = medium,
                         y = date,
                         fill = medium,
                         group = medium))+
  geom_col()

p2 <- ggplot(ga_data, aes(x = users,
                          y = source)) +
  
  geom_boxplot()

p3 <- ggplot(ga_data, aes(x = users,
                          fill = medium)) +
  geom_density(alpha = 0.5)

p4 <- ggplot(ga_data, aes(x = date,
                          y = sessions)) +
  geom_line()



p1 + p2 + p3 + p4