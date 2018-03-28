#!/bin/bash

#Set IFS to new line.
IFS=$'\n'

echo "Converts PNG to JPG & Compresses JPG"
echo "In a directory and all of its subdirectories."
echo ""
echo "Enter a path(--h for more info): "

#folder="/root/Pictures"
read folder

startSize=0

for file in $( find "$folder" -name '*.jpg' -or -name '*.png' ); do
	#Calculate starting Size of Files.
	val=$( du "$file" | awk '{print $1}' ) 
	#du|awk statement gets just size of files; stores in val
	startSize=`expr $startSize + $val`
done
echo "Starting size of File(s): $startSize k"

for file in $( find "$folder" -name '*.png' ); do
	#Convert PNG to JPG
	convert "$file" "${file%.png}.jpg"
	#remove PNG file
	rm "$file"
done

for file in $( find "$folder" -name '*.jpg' ); do
	#compress JPG files by stripping meta tags (including geotags). 
	jpegoptim "$file" --strip-all >/dev/null
done
endSize=0
for file in $( find "$folder" -name '*.jpg' ); do
	#get End Size
	val=$( du "$file" | awk '{print $1}' )
        endSize=`expr $endSize + $val`
done
echo "End size of File(s): $endSize k"
#Calculate saved space.
saved=`expr $startSize - $endSize`
prcnt=`expr $saved / $startSize`
prcnt=`expr $prcnt \* 100`
echo "Percent Saved: $prcnt \%  -  K Saved: $saved"

#Return IFS to spaces.
IFS=$' '
