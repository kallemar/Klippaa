#!/bin/bash

usage_info()
{
	    echo "Usage: $0 <path to input video file> <path to klips.tsv file> <path to output folder>"

}   # end of usage_info


# MAIN
if [ "$1" == "" ]; then
    echo "No input video file defined"a
    usage_info
    exit 1 
fi

if [ "$2" == "" ]; then
    echo "No  tsv file defined"a
    usage_info
    exit 2
fi

if [ "$3" == "" ]; then
    echo "No output folde defined"a
    usage_info
    exit 1
fi

i=0
cmd=""
while IFS=$'\t\r\n' read -r -a Klippi
do 
    start=${Klippi[0]}
    if (($i > 2)) ; then	
	    cmd+="ffmpeg  -i \"$1\" -ss ${Klippi[0]} -to ${Klippi[1]} -c copy \"$3/$((i-2)) ${Klippi[2]}.mp4\";"
	    #echo $cmd
	    #ffmpeg -hide_banner -loglevel panic -i "$1" -ss ${Klippi[0]} -to ${Klippi[1]} -c copy "$3/$((i-2)) ${Klippi[2]}.mp4"
    fi
    i=$((i+1))    
done < "$2"
echo $cmd
eval $cmd
