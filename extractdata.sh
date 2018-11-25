#!/bin/bash

#creating file,csv file
rm -f tmp_file extractData.csv

#write headers to CSV file
echo "Year ; Rate" > extractData.csv


#web scraping the forex-change data
#extracting only tables
curl -sS "https://www.bookmyforex.com/blog/1-usd-to-inr-in-1947-2018/" | grep -w "<td>*" > tmp_file 

#extracting the required table
cat tmp_file | head -n 152 | tail -n 148 > tmp1_file

#eliminating some unwanted characters
cut -b 5-8 tmp1_file | sed 's/</ /g' > tmp2_file
cat tmp2_file | sed 's#/# #g' > tmp3_file
cat tmp3_file | sed 's/t/ /g' > tmp4_file


#inserting year and rate into csv file line by line
n=0
while [ $n -lt 74 ]
do
	
	year=$(cat tmp4_file | head -n 1)
	sed -i '1d' tmp4_file
	
	
	rate=$(cat tmp4_file | head -n 1)
	sed -i '1d' tmp4_file
	
	echo "$year ; $rate" >> extractData.csv
	n=$[$n+1]
	
done

#data ready to analyse
echo "The file fetched and is to be analysed is:"
cat extractData.csv





