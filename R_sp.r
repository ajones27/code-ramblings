# import libraries
library("reshape")
library("dplyr")

# read csv and assign to variable
myVariable <- read_csv("~/Downloads/my_file.csv")

# function with one input
# return a number if it's positive, otherwise return 0
positiveNumber <- function(x){ return(x * (x >= 0)) }

# function with multiple inputs
# compute the speed from distance and time
computeSpeed <- function(distance = 1,
                         time = 1
                         ){
  return(distance / time)
}
