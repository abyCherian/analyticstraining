# New R Project training

# R is driven by typing commands into the console window . Windows and Macintosh operating systems have additional menus . In Linux, R is driven via the Terminal and there are no menus .  

# Create a vector
x <- c(1:10)

# Finding Mean of the variable x

mean(x)

# Finding the length of the variable x

length(x)

# Brings up a help details for the specified command .

help(mean)
?mean

# Opens the help system in the R.studio default browser .

help.start()

# Installs a library (package) of functions, codes and guides from the CRAN website .

install.packages('tidyverse')

# Displays a list of the packages that are installed .

installed.packages()

# Loads a package of commands, making them available for use (the package must already be installed) .

library(package)

# Displays a list of packages (and other objects) that are loaded and available for use

search()

# Detaching a package 

detach(name = package:tidyverse,unload = TRUE)
