#!/bin/bash

# sleep time
sleep_time_secs="1"

if [ $# -eq 0 ]
  then
  sleep_time_secs="0.05"
else
  sleep_time_secs=$1
fi

#sleep_time_secs=$1

utc_timestamp() {
  date '--rfc-3339=seconds'
}

unix_timestamp() {
  date  "+%Y-%m-%d %H:%M:%S"
}

# omniture file location is in ../data
filename="../data/filtered-omniture-raw.tsv"

x=0
y=`cat $filename | wc -l`

while IFS= read -r line; do
    shopflag=0
    errorflag=0

    val1=`echo $line | awk -F "|" '{print $1}'`
    val2=`echo $line | awk -F "|" '{print $3}'`
    val3=`echo $line | awk -F "|" '{print $4}'`
    val4=`shuf -i 1-10 -n 1`
    randNum=$((val2/val1*val4 + val3/val1*val4*val4))

    pageId=$(($((randNum % 31)) + 1))
    if [ $pageId -eq 1 ]; then
        url="/SH55126545/VD55149415"
    elif [ $pageId -eq 2 ]; then
        url="/SH55126545/VD55163347"
    elif [ $pageId -eq 3 ]; then
        url="/SH55126545/VD55165149"
    elif [ $pageId -eq 4 ]; then
        url="/SH55126545/VD55166807"
    elif [ $pageId -eq 5 ]; then
        url="/SH55126545/VD55170364"
    elif [ $pageId -eq 6 ]; then
        url="/SH5580165/VD55156528"
    elif [ $pageId -eq 7 ]; then
        url="/SH5580165/VD55173281"
    elif [ $pageId -eq 8 ]; then
        url="/SH5582037/VD5582082"
    elif [ $pageId -eq 9 ]; then
        url="/SH5584743/VD55178549"
    elif [ $pageId -eq 10 ]; then
        url="/SH5587637/VD55178312"
    elif [ $pageId -eq 11 -o $pageId -eq 21 ]; then
        url="/SH559026/VD5568891"
        shopflag=1
    elif [ $pageId -eq 12 -o $pageId -eq 22 ]; then
        url="/SH559040/VD55175948"
        shopflag=1
    elif [ $pageId -eq 13 -o $pageId -eq 23 ]; then
        url="/SH559044/VD5586386"
        shopflag=1
    elif [ $pageId -eq 14 -o $pageId -eq 24 ]; then
        url="/SH55126545/VD55173061"
        shopflag=1
        errorflag=1
    elif [ $pageId -eq 15 -o $pageId -eq 25 ]; then
        url="/SH55126545/VD55177927"
        shopflag=1
    elif [ $pageId -eq 16 -o $pageId -eq 26 ]; then
        url="/SH55126545/VD55179433"
        shopflag=1
    elif [ $pageId -eq 17 -o $pageId -eq 27 ]; then
        url="/SH55126554/VD55147564"
        shopflag=1
    elif [ $pageId -eq 18 -o $pageId -eq 28 ]; then
        url="/SH5568487/VD55169229"
        shopflag=1
    elif [ $pageId -eq 19 -o $pageId -eq 29 ]; then
        url="/SH5585921/VD55178554"
        shopflag=1
    elif [ $pageId -eq 20 -o $pageId -eq 30 ]; then
        url="/SH5585921/VD55179070"
        shopflag=1
    elif [ $pageId -eq 20 -o $pageId -eq 31 ]; then
        url="/SH5587637/VD55178699"
        shopflag=1
    else
        url="/"
    fi

    if [ $shopflag -eq 1 -a $((randNum % 4)) -eq 1 ]; then
        isPurchased=1
    else
        isPurchased=0
    fi

    if [ $errorflag -eq 1 -a $isPurchased -eq 0 -a $((randNum % 3)) -eq 1 ]; then
        isError=1
    else
        isError=0
    fi

#    print1=`echo $line | awk -F "|" '{print $1"|"$2"|"$5}'`
    print1=`echo $line | awk -F "|" '{print $1}'`
    print2=`echo $line | awk -F "|" '{print $5}'`
    print3=`echo $line | awk -F "|" '{print $7"|"$8"|"$9"|"$10}'`

#   For Streaming data to NiFi and SAM - for streaming analytics
    echo $print1"|"`unix_timestamp`"|"$print2"|"$url"|"$isPurchased"|"$isError"|"$print3

#   For Writing to a file - for historical analysis
#   echo $print1"|"$url"|"$isPurchased"|"$isError"|"$print2  >> $output_file

    x=$((x+1))

#   Uncomment for debugging
#    echo "processing line "$x" of "$y"..."

# Introduce some lag - about 10 seconds
    #sleep 0.10
    `sleep "$sleep_time_secs"`

done < "$filename"

