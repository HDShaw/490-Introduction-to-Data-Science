# HW 4 Due Monday Oct 2, 2017. 
# Upload R file to Moodle with name: HW4_490ID_24.R

# Your classID:24

# Notice we are using the new system with your unique class ID. You should have received an email with
# your unique class ID. Please make sure that ID is the only information on your hw that identifies you. 

# Do not remove any of the comments. These are marked by #



################## Part 1: Linear Regression Concepts #######################

## These questions do not require coding but will explore some important concepts.

## "Regression" refers to the simple linear regression equation:
##    y = b0 + b1*x
## This homework will not discuss other models.

## 1. (1 pt)
## What is the interpretation of the coefficient B1? 
## (What meaning does it represent?)

## Your answer here
When X change a unit,the Y change B1 units on average.

## 2. (1 pt)
## Outliers are problems for many statistical methods, but are particularly problematic
## for linear regression. Why is that? It may help to define what outlier means in this case.
## (Hint: Think of how residuals are calculated)

## Your answer here
Too many outliers means the residual error(RSS) can increase,therefor it may cause
the final calculation of the value of B1 less than it is supposed to be.


## 3. (1 pt)
## How could you deal with outliers in order to improve the accuracy of your model?

## Your answer here
Check if the outlier are caused by human mistake or there are indeed some other factors causing this.
If we can correct the data, then we should first correct it, if not sometimes we can also ignore them,




################## Part 2: Sampling and Point Estimation #####################

## The following problems will use the cats dataset and explore
## the average body weight of female cats.

## Load the data by running the following code

install.packages("MASS")
library(MASS)
data(cats)

## 4. (2 pts)
## Subset the data frame to ONLY include female cats.

## Your answer here
head(cats)

Sex Bwt Hwt
1   F 2.0 7.0
2   F 2.0 7.4
3   F 2.0 9.5
4   F 2.1 7.2
5   F 2.1 7.3
6   F 2.1 7.6

summary(cats)

 Sex         Bwt             Hwt       
 F:47   Min.   :2.000   Min.   : 6.30  
 M:97   1st Qu.:2.300   1st Qu.: 8.95  
        Median :2.700   Median :10.10  
        Mean   :2.724   Mean   :10.63  
        3rd Qu.:3.025   3rd Qu.:12.12  
        Max.   :3.900   Max.   :20.50 

fcat_df=cats[cats$Sex=="F",]
fcat_df
   Sex Bwt  Hwt
1    F 2.0  7.0
2    F 2.0  7.4
3    F 2.0  9.5
4    F 2.1  7.2
5    F 2.1  7.3
6    F 2.1  7.6
7    F 2.1  8.1
8    F 2.1  8.2
9    F 2.1  8.3
10   F 2.1  8.5
11   F 2.1  8.7
12   F 2.1  9.8
13   F 2.2  7.1
14   F 2.2  8.7
15   F 2.2  9.1
16   F 2.2  9.7
17   F 2.2 10.9
18   F 2.2 11.0
19   F 2.3  7.3
20   F 2.3  7.9
21   F 2.3  8.4
22   F 2.3  9.0
23   F 2.3  9.0
24   F 2.3  9.5
25   F 2.3  9.6
26   F 2.3  9.7
27   F 2.3 10.1
28   F 2.3 10.1
29   F 2.3 10.6
30   F 2.3 11.2
31   F 2.4  6.3
32   F 2.4  8.7
33   F 2.4  8.8
34   F 2.4 10.2
35   F 2.5  9.0
36   F 2.5 10.9
37   F 2.6  8.7
38   F 2.6 10.1
39   F 2.6 10.1
40   F 2.7  8.5
41   F 2.7 10.2
42   F 2.7 10.8
43   F 2.9  9.9
44   F 2.9 10.1
45   F 2.9 10.1
46   F 3.0 10.6
47   F 3.0 13.0



## Use the sample function to generate a vector of 1s and 2s that is the same
## length as the subsetted data frame you just created. Use this vector to split
## the 'Bwt' variable into two vectors, Bwt1 and Bwt2.

## IMPORTANT: Make sure to run the following seed function before you run your sample
## function. Run them back to back each time you want to run the sample function to ensure 
## the same seed is used every time.

## Check: If you did this properly, you will have 24 elements in Bwt1 and 23 elements
## in Bwt2.

set.seed(676)
## Your answer here
s_vector=sample(1:2,nrow(fcat_df),replace=T)
s_vector

Bwt1=fcat_df[s_vector=="1","Bwt"]
Bwt1
[1] 2.0 2.0 2.1 2.1 2.1 2.2 2.2 2.2 2.3 2.3 2.3 2.4 2.4 2.4 2.4 2.5 2.5 2.6 2.6 2.7 2.7 2.7 2.9 3.0

Bwt2=fcat_df[s_vector=="2","Bwt"]
Bwt2
[1] 2.0 2.1 2.1 2.1 2.1 2.1 2.1 2.2 2.2 2.2 2.3 2.3 2.3 2.3 2.3 2.3 2.3 2.3 2.3 2.6 2.9 2.9 3.0


## 5. (3 pts)
## Calculate the mean and the standard deviation for each of the two
## vectors, Bwt1 and Bwt2. Use this information to create a 95% 
## confidence interval for your sample means (you can use the following formula 
## for a confidence interval: mean +/- 2 * standard deviation). 
## Compare the confidence intervals -- do they seem to agree or disagree?

## Your answer here
Bwt1_mean=mean(Bwt1)
Bwt1_sd=sd(Bwt1)

Bwt2_mean=mean(Bwt2)
Bwt2_sd=sd(Bwt2)

B1_cointerval=c(Bwt1_mean-2*Bwt1_sd,Bwt1_mean+2*Bwt1_sd)
B2_cointerval=c(Bwt2_mean-2*Bwt2_sd,Bwt2_mean+2*Bwt2_sd)

B1_cointerval
[1] 1.853072 2.946928

B2_cointerval
[1] 1.769164 2.865619

They seem to agree with each other

## 6. (4 pts)
## Draw 1000 observations from a standard normal distribution. Calculate the sample mean.
## Repeat this 500 times, storing each sample mean in a vector called mean_dist.
## Plot a histogram of mean_dist to display the distribution of your sample mean.
## How closely does your histogram resemble this normal distribution? Explain.

## Your answer here

mean_dist=c()
for(i in 1:500){
	m=mean(rnorm(1000,0,1))
	mean_dist[i]=m
}
mean_dist

hist(mean_dist)

This histogram resembles this normal distribution good,since Most observations concentrate on 0.00
#the graph is attached on the final page



## 7. (3 pts)
## Write a function that implements Q6.

HW.Bootstrap=function(distn,n,reps){
  set.seed(666)
  
  ### Your answer here
  means=replicate(reps,mean(distn(n)))
  hist(means)

}

HW.Bootstrap(rnorm,1000,500)
#the graph is attached on the final page




## Use the function you write to repeat the experiment in Q6 but instead of the
## normal distribution as we used above, use an exponential distribution with mean 1.
## Check your histogram and write out your findings.
## (Hint: HW.Bootstrap(rexp,n,reps))

## Your answer here
HW.Bootstrap=function(rexp,n,reps){
	set.seed(660)
  
  ### Your answer here
  means=replicate(reps,mean(rexp(n)))
  hist(means)

  
}

HW.Bootstrap(rexp,1000,500)
#the graph is attached on the final page


################### Part 3: More Linear Regression ######################

## This problem will use the Prestige dataset.
## Load the data by running code below
install.packages("car")
library(car)
data(Prestige)

## We will focus on this two variables:
## income: Average income of incumbents, dollars, in 1971. 
## education: Average education of occupational incumbents, years, in 1971

## Before starting this problem, we will declare a null hypthosesis that
## education has no effect on income .
## That is: H0: B1 = 0
##          HA: B1 != 0
## We will attempt to reject this hypothesis by using a linear regression


## 8. (2 pt)
## Fit a linear regression using of Prestige data using education to predict
## income, using lm(). Examine the model diagnostics using plot(). Would you 
## consider this a good model or not? Explain.

## Your answer here
Income_edu.lm=lm(formula=income ~ education,data=Prestige)
Income_edu.lm

Call:
lm(formula = income ~ education, data = Prestige)

Coefficients:
(Intercept)    education  
    -2853.6        898.8  

plot(Prestige[,c("education","income")],xlab="education",ylab="income",las=1) 
abline(Income_edu.lm)
#this plot is attached on the final page

I think this is a good model.Becasue most points lie around the regression line.


## 9. (2 pts)
## Using the information from summary() on your model (the output from the lm() command), create a 
## 95% confidence interval for the coefficient of education variable 

## Your answer here
summary(Income_edu.lm)

Call:
  lm(formula = income ~ education, data = Prestige)

Residuals:
  Min      1Q  Median      3Q     Max 
-5493.2 -2433.8   -41.9  1491.5 17713.1 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -2853.6     1407.0  -2.028   0.0452 *  
education      898.8      127.0   7.075 2.08e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3483 on 100 degrees of freedom
Multiple R-squared:  0.3336,	Adjusted R-squared:  0.3269 
F-statistic: 50.06 on 1 and 100 DF,  p-value: 2.079e-10

alpha = 0.05
b2 = coef(Income_edu.lm)[[2]]
df = df.residual(Income_edu.lm)
S_income_lm=summary(Income_edu.lm)
seb2=coef(S_income_lm)[2,2]
tc=qt(1-alpha/2, df)
lowb=b2-tc*seb2
upb=b2+tc*seb2

con_interval=c(lowb,upb)
con_interval

[1]  646.7782 1150.8475


## 10. (2 pts)
## Based on the result from question 9, would you reject the null hypothesis or not?
## (Assume a significance level of 0.05). Explain.

## Your answer here
I would reject the null hypothesis becasue from the summary(Income_edu.lm) results, we can
see that the coefficient of education is 898.8, which lies between the confidence interval
(646.7782 1150.8475).



## 11. (1 pt)
## Assuming that the null hypothesis is true. 
## Based on your decision in the previous question, would you be committing a decision error? 
## If so, which type of error?

## Your answer here
Yes, I would.type 1 error


## 12. (1 pt)
## Discuss what your regression results mean in the context of the data.
## (Hint: Think back to Question 1)

## Your answer here

For every 1 unit increase in the education, the income will increase by about $898.8.





