#Title : IS490ID HW9
#HW9_extraction_24.sh


curl -s http://www.imdb.com/chart/top > temp.html

grep -oE '\s[0-9]+\.' temp.html > ranking
grep -oE '(dir.).*</a>' temp.html |grep -oP '(?<=>).*(?=<)' > title
grep -o '<span class="secondaryInfo">.*</span>' temp.html |grep -oE '[0-9]+' > year
grep -oE '>.*</strong>' temp.html|grep -oE '[0-9]+.[0-9]+' > rating
paste -d ';' ranking title year rating > result.csv

cat result.csv



