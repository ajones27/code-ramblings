# create a vector
x <- c(1,3,2,5)

# display x
x

# we can also assign to variables with =
x = c(1,6,2)
y = c(1,4,3)

# get the length of x and y
length(x)
length(y)

# element-wise vector addition
x+y

# list all the variables
ls()

# clear x and y
rm(x,y)

# clear all variables
rm(list=ls())

# learn what the matrix function does (creates a matrix from a set of values)
?matrix

# create a 2x2 matrix
x = matrix(data=c(1,2,3,4), nrow=2, ncol=2)
x

# fill the matrix by row instead of by column
# note: we don't have to declare the input variables like data, nrow etc if they're in the correct orde
# but it's clearer
x = matrix(data=c(1,2,3,4), nrow=2, ncol=2, byrow=TRUE)

# take the square root of all the elements in x
sqrt(x)

# square them all
x^2

# generate a vector of random normal variables (where the first arg is the sample size)
x = rnorm(50) 
y = x + rnorm(50, mean=50, sd=1)

# test that x and y are correlated
cor(x,y)

# set seed to make sure we always get the same answer (the seed resets after we run it)
set.seed(1234) 
rnorm(50)

# calculate the mean and sd
set.seed(3)
y = rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)

# create a scatter plot
x = rnorm(100)
y = rnorm(100)
plot(x,y,xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of x vs. y")

# save it as a pdf
pdf("Figure.pdf")

# plot the points in green
plot(x,y,col="green")

# copy and paste the image into word or type
dev.off()

# make a sequence of numbers
seq(1,10)
x=1:10
x=seq(-pi,pi,length=50)
x

# indexing data
A = matrix(1:16,4,4)
A
dim(A)

# return the 2nd row and 3rd column (note: R indexes from 1)
A[2,3] 

# return the 1st and 3rd row, and the 2nd and 4th column
A[c(1,3), c(2,4)]

# return rows 1 to 3 and columns 2 to 4 (inclusive)
A[1:3, 2:4]

# return the first 2 rows and all columns
A[1:2,]

# return the first column (R treats it as a vector)
A[,1]

# return all rows except the 1st and 3rd
A[-c(1,3),]

# importing data
# Session -> Set working directory -> To source file location
Auto = read.table("Auto.data")

# view it like a spreadsheet (window must be closed before continuing )
# NOTE: you might need to install X11 
# https://stackoverflow.com/questions/29386458/fail-to-use-fix-edit-functions-in-rstudio-server-centos-7
fix(Auto)

# import the data again, using headers and taking the string "?" as NA
Auto = read.table("Auto.data", header = T, na.strings = "?")
fix(Auto)
dim(Auto)

# preview the first 4 rows
Auto[1:4,]

# remove rows containing NAs
Auto=na.omit(Auto)
dim(Auto)

# check variable names
names(Auto)

# plot the data
plot(Auto$cylinders, Auto$mpg)

# by 'attaching' the dataframe, we don't have to reference the variables with $
attach(Auto)
plot(cylinders, mpg)

# the variable cylinders is numeric, but since there are only a few possible values, 
# we can treat it as qualitative instead. for this, we convert the values to factors
cylinders=as.factor(cylinders)

# If the variable plotted on the x-axis is categorial, 
# then boxplots will automatically be produced by the plot() function
plot(cylinders, mpg, col="red", varwidth=T, xlab="cylinders", ylab="mpg")

# we can plot a histogram instead
hist(mpg, col="red", breaks=15)

# we can create a scatterplot with all pairs from the dataframe
pairs(Auto)

# or we can just use a subset (these are the variables to be included)
pairs(~ mpg + displacement + horsepower, Auto)

# we can use identify to annotate a graph with extra information
plot(horsepower, mpg)
# e.g. we provide the x and y labels from the plot and the variable we want to annotate
identify(horsepower,mpg,name)
# then we click on the points on the graph and click the finish button when done to see the names appear

# we can also print out a summary of each variable in the whole dataframe
summary(Auto)

# or a summary by variable
summary(mpg)
summary(name)

# when you're done with the R session, you can choose to save all your variables
# you can reload these next time with
load(".RData")

# similarly, you can save a history of commands and load it back in
savehistory()
loadhistory()
