#  Install the DataEditR package from R

install.packages('DataEditR')

#  Load the package

library(DataEditR)

# Load the interactive environment
DataEditR::data_edit()


mtcarsNew = data_edit(mtcars,save_as = 'mtcars.csv') 


