# HW 1 Due Monday Sept 18, 2017. Upload R file or notebook to Moodle with 
# filename: HW1_490ID_YOURUNI.R
# Do Not remove any of the comments. These are marked by #

###Your Unique Class ID:24

# 1.
# Load the data for this assignment into your R session 
# with the following command:

library(ggplot2)
data(diamonds)

#(1). Check to see that the data were loaded by running:
objects(diamonds)
# This should show ten variables: 
# carat, clarity, color, cut, depth,
# price, table, x, y, z

#(2). Use the nrow() function to find out how many observations there are.
nrow(diamonds)

# For the following questions, use one of: head(), summary(),
# class(), min(), max(), hist(), quantile(), table() 
# to answer the questions.

#(3). Show the summary or the structure of this dataset.
summary(diamonds)
#(4). List the categorical variables in this dataset.
diamonds$cut
diamonds$color
diamonds$clarity
#(5). What was the highest price of the diamonds ?
max(diamonds$price) 
#(6). What was the average price of the diamonds ?
mean(diamonds$price)
#(7). What is the number of the Ideal cut ?
sum(diamonds$cut=="Ideal")
#(8). What is the number of the diamonds which are Premium and have a clarity level
#     of IF?
nrow(subset(diamonds,diamonds$cut=="Premium"&diamonds$clarity!="IF"&diamonds$clarity!="I1"))
#(9). What is the averge price difference between the clarity level SI2 and IF?
#     Hint(Use aggregate())
#aggregate(x[,3:4],by=list(sex=x$sex),FUN=mean)
new1_diamonds=diamonds[diamonds$clarity=="SI2",c("clarity","price")]
new2_diamonds=diamonds[diamonds$clarity=="IF",c("clarity","price")]
new1_average=aggregate(new1_diamonds[,"price"],by=list(clarity=new1_diamonds$clarity),FUN=mean)
new2_average=aggregate(new2_diamonds[,"price"],by=list(clarity=new2_diamonds$clarity),FUN=mean)
new1_average
new2_average
new1_average[[2]]
new2_average[[2]]
ST2_IF_AVERAGE_PRICE_DIFFERENCE=new1_average[[2]]-new2_average[[2]]
ST2_IF_AVERAGE_PRICE_DIFFERENCE


#(10). Total depth percentage is represented as the depth divided by
#      the mean of the length and width of the diamond, 
length_d=nrow(diamonds)
width_d=ncol(diamonds)
Total_depth_percentage=width_d/length_d
Total_depth_percentage
# (11).
# Try running each expression in R.
# Record the error message in a comment
# Explain what it means. 
# Be sure to directly relate the wording of the error message with the problem you find in the expression.

z/mean(x, y)
### Error message here
    Error: object 'z' not found
### Explanation here
    variable z hasn't been defined seperately before.We can't just use the vector 'c' in diamonds like this. 


diamonds$z/(mean(diamonds$x, diamonds$y))
### Error message here
    Error in mean.default(diamonds$x, diamonds$y) :
      'trim' must be numeric of length one
### Explanation here
    function means can only be applied to  numeric object while diamonds$x and diamonds$y are 2 vector structures.

diamonds$z/(rowMeans(diamonds$x, diamonds$y))
### Error message here
    Error in rowMeans(diamonds$x, diamonds$y)
      'x' must be an array of at least two dimensions
### Explanation here
    function rowMeans can only have one argument which has more than one identical numeric dimension to get the mean.


#(12).Study the following code about how to do the compution 
# calculation that we want for the previous question.
Depth <- (diamonds$z)/rowMeans(cbind(diamonds$x, diamonds$y))
Depth
#(13). Can you get the same result without using function?
#	      Given an expression to it.  Name the values Depth1
Depth1=diamonds$z/((diamonds$x+diamonds$y)/2)
Depth1
#(14) What did you get from :I get "True"
all.equal(Depth, Depth1)
# 2. Run the following code to make a plot.
# (don't worry right now about what this code is doing)

plot(diamonds[1:1000,]$carat, diamonds[1:1000,]$price, xlab = "Carat", ylab = "Price", main = "Carat vs Price")

# (1) Use the Zoom button in the Plots window to enlarge the plot.
# Resize the plot so that it is long and short, so it is easier to read.
# Include this plot in the homework your turn in.
help(plot)
plot
plot(diamonds[1:1000,]$carat, diamonds[1:1000,]$price, xlab = "Carat", ylab = "Price", main = "Carat vs Price")
#trying to make this plot more precise so make some little change as following to the scale of 
#x and y axis of this plot
#plot(diamonds[1:1000,]$carat, diamonds[1:1000,]$price, xlab = "Carat", ylab = "Price", main = "Carat vs Price",
#     xaxt="n",yaxt="n")
#axis(side=1,at=seq(0,2,by=0.05))
#axis(side=2,at=seq(0,3000,by=500))


 # (2) Make an interesting observation about the relation between
#     Carat and Price based on this plot 
# (something that you couldn't see with the calculations so far.)

### Your answer goes here
A large part of diamonds points concentrate on the area where prices are ranging about from 2700 to 2900 while 
carat are ranging about from 0.70 to 0.85, which is to say when the carat of a diamond is among 0.70 to 0.85, 
its price is very likely to be among 2700 to 2900.



# (3) What interesting question about the diamonds
# would you like to answer with these data, but don't yet know 
# how to do it? 


### Your answer goes here
I would like to explore more relationships not just between 2 vectors but among 3 or even more vectors like "carat"
,"clarity","price".

I will compare the relationships between 2 of 3 respectively, then I can have 3 two-sided relationships,"carat-
clarity", "carat-price","clarity-price",then I will add one of three to another to obtain the final relationship
of 3 of them. After all of this , maybe I can find out if the higher the carat is, the higher the clrity is and 
the higher the price is.


# For the remainder of this assignment we will work with 
# one of the random number generators in R.

# 4.
# Use the following information about you to generate some random values:
#a. Use you UIN number to set the seed in set.seed() function.
#b. Use your birthday month for the mean of the normal. 12
#c.	Use your birthday day for the standard deviation (sd) of the normal curve. 20
#d.	Generate 10 random values using the parameters from b and c.
#e.	Assign the values to a variable named with your first name. Huidan_490_w1
#f.	Provide/Show the values generated.
set.seed(659586023)
rnorm(10,12,20)
Huidan_490_w1=c(rnorm(10,12,20))
Huidan_490_w1


# 5.
#(1). Generate a vector called "normsamps" containing
# 100 random samples from a normal distribution with
# mean 5 and SD 2.
normsamps=c(rnorm(100,5,2))
normsamps
#(2). Calculate the mean and sd of the 100 values.

### The return values from your computation go here
mean(normsamps)
sd(normsamps)

# (3). Use implicit coercion of logical to numeric to calculate
# the fraction of the values in normsamps that are more than 8.
subset(normsamps,normsamps>=8)-8
normsamps[normsamps>=8]-8
# (4). Look up the help for rnorm.
# You will see a few other functions listed.  
# Use one of them to figure out about what answer you 
# should expect for the previous problem.  
# That is, find the area under the normal(5, 2) curve
# to the right of 8.  This should be the chance of getting
# a random value more than 8. 
help(norm)
# What value do you expect? 
20%

# What value did you get? 
0.0668072
1-pnorm(8,5,2)
# Why might they be different?
Because the number of sample 100 is just too small.

