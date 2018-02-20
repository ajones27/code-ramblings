# age as vector
age <- c(1,3,5,2,11,9,3,9,12,3)

# weight as vector
weight <- c(4.4, 5.3, 7.2, 5.2, 8.5, 7.3, 6.0, 10.4, 10.2, 6.1)

# mean
mean(weight)

# standard deviation
sd(weight)

# correlation -> 0.91 so strong linear relationship
cor(age, weight)

# scatter plot
plot(age, weight)

# help
help.start()
?foo
help("foo")
example("foo")

# get working directory
getwd()

# set working directory
setwd("mydirectory")

# other command line stuff
ls()
rm(objectlist)
history(25) # exit with q

# save/load command history .Rhistory
savehistory("myfile")
loadhistory("myfile")

# save/load workspace .Rdata
save.image("myfile")
load("myfile")

# quit R
q()

# load an R file
source("myfilename.R")

# redirect output to file
sink("filename", append=TRUE)

# save image to file (replace with png/pdf
jpeg("filename.jpg")

# example: R code from file is submitted, results appear on screen, text output to file and graphic is saved
# turn off the sink and pdf
sink("myoutput", append=TRUE, split=TRUE)
pdf("mygraphs.pdf")
source("script.R")
sink()
dev.off()

# show what packages are saved in your library
library()

# install packages (once installed, they can be updated)
install.packages()
install.packages("gclus")
update.packages()

# list packages installed
installed.packages()

# load packages
library(gclus)

# combine function c() is used to form a vector (must all be one type)

a <- c(1, 2, 3, 4, 5, 6) # numeric vector
b <- c("one", "two", "three") # character vector
c <- c(TRUE, TRUE, FALSE, FALSE) # logical vector
f <- 3 # scalar vector

# referring to vector elements. NOTE: counting starts from 1...
a[3] # --> 3
a[c(1,3,5)] # --> 1,3,5
a[2:6] # --> 2,3,4,5,6

# creating a 5x4 matrix using the numbers 1 to 20
mymatrix <- matrix(1:20, nrow=5, ncol=4)

# create a matrix with specific numbers, row names, column names. "byrow=TRUE" means filling the rows first
cells <- c(1,26,24,18)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2")

mymatrix <- matrix(cells, nrow=2, ncol=2, byrow=TRUE, dimnames=list(rnames, cnames))

# select rows/columns
mymatrix[2,] # select second row
mymatrix[,2] # select second column
mymatrix[1,2] # select element in 1st row, 2nd column
mymatrix[1,c(1,2)] # select first row, 1st and 2nd element

