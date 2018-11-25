sort -t';' -nk1 extractData.csv
#find the data for a particular input year

echo "mean of the data: "
#find the mean of the column containing rates
awk 'BEGIN{s=0;}{s=s+$3;}END{print s/NR;}' extractData.csv
echo "standard deviation of the data: "
#find standard deviation of the finance data
awk '{delta = $3 - avg; avg += delta / NR; mean2 += delta * ($3 - avg); } END { print sqrt(mean2 / (NR-1)); }' extractData.csv
echo "maximum value in the year:"
#maximum of the data'
awk 'BEGIN { max=0 } $2 > max { max=$2; name=$1 } END { print name,max }' FS=";" extractData.csv
echo "minimum value in the year: "
#minimum of the data
awk 'BEGIN { min=0 } $2 < min { min=$2; name=$1 } END { print name,min }' FS=";"  extractData.csv
echo "enter an year to print out it's forex rate"
echo "print the forex rates of years after independence"
awk -F, '$1>1947' extractData.csv
echo "forex rates before independence"
awk -F, '$1<1947' extractData.csv
read year
awk -F ';' '$1 ~ /1913/{print $2}' extractData.csv
