# HW 3 - Due Monday  Oct 2, 2017. Upload R file to Moodle with name: HW3_490IDS_24.R
# Do Not remove any of the comments. These are marked by #
# The .R file will contain your code and answers to questions.

#ClassID:24

# Main topic: Using the "apply" family of functions

#Q1 (5 pts)
# Given a function below,
myfunc <- function(z) return(c(z,z^2,(z^2+z)%/%2))
#(a) explain in words what myfunc is doing.
build a temporary function to calculate the value of z, z^2 and (z^2+z)%/%2

#(b) Examine the following code, and briefly explain what it is doing.
y = 1:8
myfunc(y)
matrix(myfunc(y),ncol=3)

### Your explanation here
> myfunc <- function(z) return(c(z,z^2,(z^2+z)%/%2))
> y = 1:8
> myfunc(y)
 [1]  1  2  3  4  5  6  7  8  1  4  9 16 25 36 49 64  1  3  6 10 15 21 28 36
> matrix(myfunc(y),ncol=3)
     [,1] [,2] [,3]
[1,]    1    1    1
[2,]    2    4    3
[3,]    3    9    6
[4,]    4   16   10
[5,]    5   25   15
[6,]    6   36   21
[7,]    7   49   28
[8,]    8   64   36

the code above is trying to build a matix using the value from myfunc(y) and set the number of columns equals 3.




#(c) Simplify the code in (b) using one of the "apply" functions and save the result as m.
###code & result
m=t(apply(matrix(1:8,nrow=1),2,myfunc))
m

   [,1] [,2] [,3]
[1,]    1    1    1
[2,]    2    4    3
[3,]    3    9    6
[4,]    4   16   10
[5,]    5   25   15
[6,]    6   36   21
[7,]    7   49   28
[8,]    8   64   36


#(d) Find the column product of m.
###code & result
ncol(m)
[1] 3

#(e) Find the row sum of m in two ways.
###code & result
nrow(m)
[1] 8

dim(m)[1]
[1] 8

#(f) Multiple all the values by 2 in two different ways:
### 1. code & result
m*2
     [,1] [,2] [,3]
[1,]    2    2    2
[2,]    4    8    6
[3,]    6   18   12
[4,]    8   32   20
[5,]   10   50   30
[6,]   12   72   42
[7,]   14   98   56
[8,]   16  128   72

### 2. code & result
t(apply(m,1,function(x)x*2))

    [,1] [,2] [,3]
[1,]    2    2    2
[2,]    4    8    6
[3,]    6   18   12
[4,]    8   32   20
[5,]   10   50   30
[6,]   12   72   42
[7,]   14   98   56
[8,]   16  128   72


#Q2 (10 pts)
#Create a list l with 2 elements as follows:
l <- list(a = 1:10, b = 21:30)

#(a) What is the sum of the values in each element?
###code & result
lapply(l["a"],sum)
$a
[1] 55

lapply(l["b"],sum)
$b
[1] 255



#(b) What is the (sample) variance of the values in each element?
###code & result
lapply(l,var)

$a
[1] 9.166667

$b
[1] 9.166667

#(c) Use the help() function to check what type of output object will you expect if you use sapply and lapply. 
# Show your R code that finds these answers and briefly explain if the results agree with your expectation.

###code
help(sapply)
help(lapply)

###written explanation
the lapply function will return a list if possible
while the sapply function will return a vector



#(d) Change one of them to make the two statement return the same results (type of object):
###code & result
list(sapply)

[[1]]
function (X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE) 
{
    FUN <- match.fun(FUN)
    answer <- lapply(X = X, FUN = FUN, ...)
    if (USE.NAMES && is.character(X) && is.null(names(answer))) 
        names(answer) <- X
    if (!identical(simplify, FALSE) && length(answer)) 
        simplify2array(answer, higher = (simplify == "array"))
    else answer
}
<bytecode: 0x102bf3438>
<environment: namespace:base>


# Now create the following list:
l.2 <- list(c = c(11:20), d = c(31:40))
#(e) What is the sum of the corresponding elements of l and l.2, using one function call? Your result should be a 
# single vector with length 10.
###code & result
lapply(c(l,l.2),sum)

$a
[1] 55

$b
[1] 255

$c
[1] 155

$d
[1] 355

#(f) Take the log of each element in the list l:
###code & result
lapply(l,log)

$a
 [1] 0.0000000 0.6931472 1.0986123 1.3862944 1.6094379 1.7917595 1.9459101 2.0794415 2.1972246 2.3025851

$b
 [1] 3.044522 3.091042 3.135494 3.178054 3.218876 3.258097 3.295837 3.332205 3.367296 3.401197


#(g) First change l and l.2 into matrixes, make each element in the list as column,
###code & result
cbind( matrix(unlist(l),10,2),matrix(unlist(l.2),10,2))

   [,1] [,2] [,3] [,4]
 [1,]    1   21   11   31
 [2,]    2   22   12   32
 [3,]    3   23   13   33
 [4,]    4   24   14   34
 [5,]    5   25   15   35
 [6,]    6   26   16   36
 [7,]    7   27   17   37
 [8,]    8   28   18   38
 [9,]    9   29   19   39
[10,]   10   30   20   40



#Then, form a list named mylist using l,l.2 and m (from Q1) (in that order).
###code & result
mylist=list("l"=l,"l.2"=l.2,"m"=m)
mylist

$l
$l$a
 [1]  1  2  3  4  5  6  7  8  9 10

$l$b
 [1] 21 22 23 24 25 26 27 28 29 30


$l.2
$l.2$c
 [1] 11 12 13 14 15 16 17 18 19 20

$l.2$d
 [1] 31 32 33 34 35 36 37 38 39 40


$m
     [,1] [,2] [,3]
[1,]    1    1    1
[2,]    2    4    3
[3,]    3    9    6
[4,]    4   16   10
[5,]    5   25   15
[6,]    6   36   21
[7,]    7   49   28
[8,]    8   64   36



#Then, select the second column of each elements in mylist in one function call (hint '[' is the select operator).
###code & result
lapply(mylist,function(x)x[[2]])

$l
 [1] 21 22 23 24 25 26 27 28 29 30

$l.2
 [1] 31 32 33 34 35 36 37 38 39 40

$m
[1] 2

#Q3 (3 pts)
# Let's load the family data again.
load(url("http://courseweb.lis.illinois.edu/~jguo24/family.rda"))
#(a) Find the mean bmi by gender in one function call.
###code & result
aggregate(family["bmi"],by=list(gender=family$gender),FUN=mean)

  gender      bmi
1      m 25.73898
2      f 23.02564

#(b) Could you get a vector of what the type of variables the dataset is made of？
###code & result
sapply(family,class)

firstName    gender       age    height    weight       bmi    overWt 
 "factor"  "factor" "integer" "numeric" "integer" "numeric" "logical" 

#(c) Could you sort the firstName in bmi descending order?
###code & result
fb_aec=aggregate(family["firstName"],by=list(bmi=family$bmi),FUN=sort)
fb_aec
fb_dec=fb_aec[order(fb_dec[,"bmi"],decreasing=T),]
fb_dec

      bmi firstName
14 30.04911       Tom
13 28.94981       Liz
12 28.18797       Jon
11 26.66430       Tim
10 26.05364       Ann
9  25.16239       Tom
8  24.48414       Bob
7  24.45884       Joe
6  24.26126       Art
5  22.91060       Zoe
4  22.64384       Dan
3  21.50106       May
2  20.67783       Sal
1  18.06089       Sue

#Q4 (2 pts)
# There is a famous dataset in R called "iris." It should already be loaded
# in R for you. If you type in ?iris you can see some documentation. Familiarize 
# yourself with this dataset.
#(a) Find the mean petal width by species.
### code & result
iris
aggregate(iris["Petal.Width"],by=list(Species=iris$Species),FUN=mean)

Species Petal.Width
1     setosa       0.246
2 versicolor       1.326
3  virginica       2.026


#(b) Now obtain the mean of the first 4 variables, by species, but using only one function call.
### code & result
aggregate(iris[,1:4],by=list(Species=iris$Species),FUN=mean)

 Species Sepal.Length Sepal.Width Petal.Length Petal.Width
1     setosa        5.006       3.428        1.462       0.246
2 versicolor        5.936       2.770        4.260       1.326
3  virginica        6.588       2.974        5.552       2.026

#Q5. (5 pts) Now with the "iris" data, fit a simple linear regression model using lm() to predict 
# Petal length from Petal width. Place your code and output (the model) below. 
pl_pm.lm=lm(formula=Petal.Length ~ Petal.Width,data=iris)
pl_pm.lm

Call:
lm(formula = Petal.Length ~ Petal.Width, data = iris)

Coefficients:
(Intercept)  Petal.Width  
      1.084        2.230  

# How do you interpret this model?
The linear regression model of Petal.Length and Petal.Width follows the line : y=kx+b, k=2.230,b=1.084

# Create a scatterplot of Petal length vs Petal width. Add the linear regression line you found above.
# Provide an interpretation for your plot.
### code & result
plot(iris[,c("Petal.Width","Petal.Length")],xlab="Petal.Width",ylab="Petal.Length",las=1) 
abline(pl_pm.lm)
