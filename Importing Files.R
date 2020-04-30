# using the scan command for making data

data2 <- scan()

# Type some numercial values, seperated by spaces

6,7,8,8,10

#  Press the Enter key and type some more numbers on the fresh line

6,10

#  Hit Enter key once again to create a new line

#  Hit Enter key once more to finish the data entry

#  Using file.choose command to pick vectors

data1 <- scan(file.choose())

#  using read.csv and file.choose

data2 <- read.csv(file.choose())
