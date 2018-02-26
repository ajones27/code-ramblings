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

# By default, matrices are filled by column
# They can only contain one data type

# Arrays are like matrices but can have more than 2 dimensions
myarray <- array(vector, dimensions, dimnames)

dim1 <- c("A1", "A2")
dim2 <- c("B1", "B2", "B3")
