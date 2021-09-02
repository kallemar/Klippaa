#!/bin/bash

usage_info()
{
	    echo "Usage: $0 <path to input video file> <path to klips.tsv file> <path to output folder>"

}   # end of usage_info


# MAIN
if [ "$1" == "" ]; then
    echo "No input video file defined"
    usage_info
    exit 1 
fi

if [ "$2" == "" ]; then
    echo "No  tsv file defined"
    usage_info
    exit 2
fi

if [ "$3" == "" ]; then
    echo "No output folder defined"
    usage_info
    exit 1
fi

# Add new line end of tsv file
echo "" >> "$2"
i=1
cmd=""
while IFS=$'\t\r\n' read -r -a Klippi
do 
    if (( ${#Klippi[@]} == 3)) ; then

        filename="$(echo ${Klippi[2]} | sed -e 's/[^A-Za-z0-9._-]/_/g').mp4"
        cmd+="ffmpeg  -i \"$1\" -ss ${Klippi[0]} -to ${Klippi[1]} -c copy \"$3/$i $filename\";"
        i=$((i+1))
        echo $cmd
    fi
done < <(tail -n "+2" "$2") 
echo $cmd
eval $cmd
