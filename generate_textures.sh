#!/bin/bash
base="elements"
mkdir $base
while read element; do
  elementCode=`echo $element | grep -oP "[a-zA-Z]{1,3}"`
  elementNumb=`echo $element | grep -oP "[0-9]{1,3}"`
  convert base.png +antialias -gravity Center -annotate -0-0 "$elementCode" -gravity NorthWest -pointsize 8 -annotate +3-0 "$elementNumb" "$base/$elementCode.png"
done < "elements.txt"
