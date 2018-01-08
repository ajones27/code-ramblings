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




