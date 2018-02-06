HW2_490ID_24.R

# HW 2 Due Monday Sept 25, 2017. Upload R file to Moodle with name: HW1_490ID_CLASSID.R
# You can upload plots to Moodle in separate files and refer to them in your R file, or use an 
# R notebook http://rmarkdown.rstudio.com/r_notebooks.html

# Do not remove any of the comments. These are marked by #

### Class ID:24

# In this assignment you will practice how to manipulate a dataframe, 
# such as taking subsets and creating new variables, with the goal of creating a plot.

# You will work with the mtcars data in R library and a dataset called SFHousing. 

# Before beginning with the housing data however, you will do some warm up 
# exercises with the small mtcars data set.

# PART 1. mtcars Data
# Q1.(2 pts.)
# Use R to generate descriptions of the mtcars data which is already included in R base. 
# The description could be a summary of each column and the dimensions of the dataset (hint: 
# you may find the summary() command useful). Write up your descriptive findings and observations
# of the R output.

### Your code below
summary(mtcars)
class(mtcars)
dim(mtcars)
head(mtcars)
### Your answer here
1.mtcars is a data.frame
2.mtcars has 11 vectors and each vector is numeric
3.mtcars has 32 rows, every row represents some data about a car brand.
# Q2.(2 pts)
# Create a vector mpg_cl based on mpg in the dataset. 
# For automatic cars, the vector should have value TRUE when mpg > 16 and value FALSE when mpg <= 16.
# For manual cars, the vector should have value TRUE when mpg > 20 and value FALSE when mpg <= 20.

### Your code below
a=mtcars$am
mtcars$mpg_cl =((mtcars$am=0)&(mtcars$mpg>16)|(mtcars$am=1)&(mtcars$mpg>20))
mtcars$mpg_cl
a
# Q3.(2 pts)
# Here is an alternative way to create the same vector in Q2.

# First, we create a numeric vector mpg_index that is 16 for each automatic cars
# and 20 for each manual cars. To do this, first create a vector of length 2 called 
# id_val whose first element is 16 and second element is 20.

### Your code below
id_val = c(16, 20)
id_val
# Create the mpg_index vector by subsetting id_val by position, where the 
# positions could be represented based on am column in mtcars.

### Your code below
mpg_index = id_val[a+1]
mpg_index
# Finally, us mpg_index and mpg column to create the desired vector, and
# call it mpg_cl2.

### Your code below
mpg_cl2 = mtcars$mpg>mpg_index
mpg_cl2

# Q4.(2 pts)
# Make a plot of the variable disp against the variable weight. Color cars with different 
# mpg_cl value differently, and also format your plots with appropriate labels. Describe any 
# notable observations you have of the plot.

### Your code below
library(ggplot2)
p = ggplot(mtcars, aes(wt, disp))
p + geom_point()
p + geom_point(aes(colour = factor(mpg_cl)))

### Your answer here
Almost all the automatic and manual cars whose mpg_vl values are true all lie in the area with wt ranging 
from 0 to 3 and disp ranging from 0 to 200 while in the area with wt ranging from 3 to 5.5 and disp ranging 
from 200 to 500 when their mpg_cl values are false

#PART 2.  San Francisco Housing Data
#
# Load the data into R.
load(url("https://www.stanford.edu/~vcs/StatData/SFHousing.rda"))

# Q5. (2 pts.)
# What objects are in SFHousing.rda? Give the name and class of each.

### Your code below
a = load(url("https://www.stanford.edu/~vcs/StatData/SFHousing.rda"))
head(a)
names(cities)
names(housing)
class(cities)
class(housing)


# Give a summary of each object, including a summary of each variable and the dimension of the object.

### Your code below
summary(cities)
summary(housing)
dim(cities)
dim(housing)

### Your answer here
# There are 2 data.frames in this SFHousing.rda, the cities and housing.

# After exploring the data (maybe using the summary() function), describe in words the connection
# between the two objects.

### Write your response here
The data.frame housing mainly provide data about individual houses like price,br, lsqft, bsqft in different exact adresses
(streets, counties and cities)

While the data.frame cities mainly describe the information of the number of houses, mediansizes of houses, medianprices
of houses and so on in different counties. 

The connection between these 2 data.frame is like overall-part relationship.
Genrally speaking, if you want to learn about the overall housing market in a certain area ,then you should look up 
"cities",but if you want to learn information about an exact house, then you should check "housing".


# Describe in words two problems that you see with the data.

### Write your response here
1.There are NAs(not available values) in both cities and housing. 
2.Some factor vectors in data.frame housing are not strictly categorial.


# Q6. (2 pts.)
# We will work the houses in Oakland, San Francisco, Campbell, and Sunnyvale only.
# Subset the housing data frame so that we have only houses in these cities
# and keep only the variables county, city, zip, price, br, bsqft, and year.
# Call this new data frame SelectArea. This data frame should have 28843 observations
# and 7 variables. (Note you may need to reformat any factor variables so that they
# do not contain incorrect levels)

### Your code below

SelectArea=housing[(housing$city=="Oakland")|(housing$city=="San Francisco")|
                     (housing$city=="Campbell")|(housing$city=="Sunnyvale"), 
                   c("county", "city", "zip", "price", "br", "bsqft", "year")]

SelectArea
nrow(SelectArea)
# Q7. (3 pts.)
# We are interested in making plots of price and size of house, but before we do this
# we will further subset the housing dataframe to remove the unusually large values.
# Use the quantile function to determine the 95th percentile of price and bsqft
# and eliminate all of those houses that are above either of these 95th percentiles
# Call this new data frame SelectArea (replacing the old one) as well. It should 
# have 26459 observations.

### Your code below
SelectArea = SelectArea[SelectArea$price<quantile(SelectArea$price,0.95,na.rm = TRUE)&SelectArea$bsqft<quantile(SelectArea$bsqft,0.95,na.rm = TRUE),]
nrow(SelectArea)
# Q8 (2 pts.)
# Create a new vector that is called price_per_sqft by dividing the sale price by the square footage
# Add this new variable to the data frame.

### Your code below
price_per_sqft = c(SelectArea$price/SelectArea$bsqft)
price_per_sqft

SelectArea$price_per_sqft=price_per_sqft
SelectArea


# Q9 (2 pts.)
# Create a vector called br_new that is the number of bedrooms in the house, except
# if this number is greater than 5, it is set to 5.  That is, if a house has 5 or more
# bedrooms then br5 will be 5. Otherwise it will be the number of bedrooms.

### Your code below

SelectArea[which(SelectArea$br>=5),"br"]=5
SelectArea$br
br_new

# Q10. (4 pts. 2 + 2 - see below)
# Use the rainbow function to create a vector of 5 colors, call this vector rCols.
# When you call this function, set the alpha argument to 0.25.
# Create a vector called brCols where each element's value corresponds to the color in rCols 
# indexed by the number of bedrooms in the br_new.
# For example, if the element in br_new is 3 then the color will be the third color in rCols.
# (2 pts.)

### Your code below
rCols=rainbow(5,alpha=0.25)
brCols=rCols[br_new]

######
# We are now ready to make a plot!
# Try out the following code (check R documentation to make sure you understand it),
plot(price_per_sqft ~ bsqft, data = SelectArea,
     main = "Housing prices in the Berkeley Area",
     xlab = "Size of house (square ft)",
     ylab = "Price per square foot",
     col = brCols, pch = 19, cex = 0.5)
 legend(legend = 1:5, fill = rCols, "topright")

### What interesting feature do you see that you didn't know before making this plot? 
# (2 pts.)
the smaller the size of house, the higher the price of the square foot of the house
