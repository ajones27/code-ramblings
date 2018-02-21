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
