#Title : IS490ID HW9
#HW9_show_24.sh

echo "Enter your year(integer) to get the number of movies before that year: "
read year
awk -v awk_year=$year -F ";" '$3 < awk_year { print $2, $4 }' result.csv | wc -l

echo "Enter your year(integer) to get the title and the ratings of the movies before that year: "
read year2
awk -v awk_year=$year2 -F ";" '$3 < awk_year { print $2, $4 }' result.csv








