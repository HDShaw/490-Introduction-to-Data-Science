
 not remove any of the comments. These are marked by #


# HW 8 - Due Monday Nov 27, 2017 in moodle and hardcopy in class.
 
# Upload .sh file to Moodle with filename: HW8_490IDS_24.sh
# Please make sure all the commands work in google cloud, we will
# test your script by choosing other arguments.  

# In your hard copy report, please include the UNIX / Linux script,
# input arguments, and results you get when running your script in UNIX.


# For this assignment we will use some basic commends of UNIX / Linux.  
# The text Homework_8.txt and dataset menu.csv are uploaded to Moodle.


# You can use the following commands to run the script on google cloud:
# chmod +x HW8_490IDS_YOURCLASSID.sh
# ./HW8_490IDS_YOURCLASSID.sh Argument_1 Argument_2 Argument_3 Argument_4 

# Here is a list of your input arguments:
# Argument_1: a positive number
# Argument_2: text file (Homework_8.txt)
# Argument_3: a word
# Argument_4: a positve interger which is less than 15 






# Q1. Calculate the square root of the input number(Argument_1)
#     and print your result. (5 points)
#     (Hint: bc)
# install bc package
sudo apt-get install bc
echo "************ Q1 ************"
echo "The square root of $1:"
# Your answer here:
echo "sqrt($1)"|bc








# Q2. Check whether your input integer(Argument_4) is even or odd
#     and print your result. (5 points)
echo "************ Q2 ************"
# Your answer here:
echo "Input number"
read Argument_4
if [ $(($Argument_4 % 2)) -eq 0 ]
then
  echo "$Argument_4 is even"
else
  echo "$Argument_4 is odd"
fi








# Q3. Input a lowercase letter(Argument_3) and convert it to uppercase
#     and print your result. (5 points)
#     (Hint: tr)
echo "************ Q3 ************"
# Your answer here:
echo "Input a lowercase letter"
read Argument_3
echo $Argument_3|tr '[:lower:]' '[:upper:]'








# Q4. Convert the following phrase "CS 498/LIS 490/STAT 430:INTRODUCTION
#     TO DATA SCIENCE" into separate words, and put each word on its own
#     line (ignoring space,'/' and ':'). (5 points)

# The output would look like:

# CS
# 498
# LIS
# 490
# STAT
# 430
# INTRODUCTION
# TO
# DATA
# SCIENCE

echo "************ Q4 ************"
# Your answer here:
IFS=' :/' read -ra ADDR <<< "CS 498/LIS 490/STAT 430:INTRODUCTION TO DATA SCIENCE"
for i in "${ADDR[@]}"; do
    echo "$i"
done







# Q5. Sort the answer in Q4 by descending order. (5 points)

# The output would look like:

# TO
# STAT
# SCIENCE
# LIS
# INTRODUCTION
# DATA
# CS
# 498
# 490
# 430

echo "************ Q5 ************"
# Your answer here:
for each in ${ADDR[@]};do
echo $each
done | sort -r






# Q6. The dataset menu.csv provides some nutrition facts for McDonald's
#     menu, calculate how many items are there in each category
#     and print your result. (5 points)
#     (Hint: awk)

echo "************ Q4 ************"
# Your answer here:
 
awk -F, '{a[$1]++;}END{for (i in a)print i, a[i];}'  menu.csv









# Q7. For your output in Q6, change the format of categories, replace "&"
#     with word "and", and connect the words by "_". 
#     For example: "Chicken & Fish" ---> "Chicken_and_Fish" (5 points)
#     (Hint: sed)

# The output would look like:

# Smoothies_and_Shakes 28
# Coffee_and_Tea 95
# Salads 6
# ......






echo "************ Q5 ************"
# Your answer here:
#Echo ${output6// & /_and_}
awk -F, '{a[$1]++;}END{for (i in a)print i, a[i];}' menu.csv >> Q6_answer.txt
sed 's/ & /_and_/g' Q6_answer.txt






# Q8. Count the lines of your text file(Argument_2). (5 points)
#     (Hint: wc)

echo "************ Q6 ************"
echo "The number of lines in $2:"
# Your answer here:
#wc -l Homework_8.txt
wc -l $2







# Q9. Count the frequency of a input word(Argument_3) in a text
#     file(Argument_2), and print "The frequency of word ____ is ____ ".
#     (5 points)
#     (Hint: grep)

echo "************ Q7 ************"
echo "The frequency of word $3:"
# Your answer here:

grep -wc $3 $2



# Q10. Print the number of unique words in the text file(Argument_2).
#     (5 points) 
#     (Hint: uniq, sort) 

echo "************ Q8 ************"
echo "The number of unique words in text file:"
# Your answer here:

grep -oE '[a-zA-Z0-9]+' $2 | sort | uniq -c | sort -r | awk '{print $2" "$1}' | wc -l








# Q11. Print the number of words that begin with the letter 'a' in the
#     text file(Argument_2) (5 points).

echo "************ Q9 ************"
echo "The number of words that begins with letter 'a':"
# Your answer here:

grep -oE '[a-zA-Z0-9]+' $2 | awk '{nums[$1]++}END{for(word in nums) print word, nums[word]}' | sort -rn -k2 >> Q11xs_answer.txt
grep '^a' Q11xs_answer.txt | awk '{sum +=$2 }END{print sum}'






# Q12. Print top-k(Argument_4) and find the most frequent word and their frequencies.
#      (5 points).
#      (Hint: head) 

echo "************ Q10 ************"
echo "Top-$4 words are:"
# Your answer here:

grep -oE '[a-zA-Z0-9]+' $2 | sort | uniq -c | sort -r | awk '{print $2" "$1}'| head -n$4





