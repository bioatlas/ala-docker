#!/bin/bash

f=$(grep -r -e "gbifsweden.se" | cut -d: -f1 | sort -d | uniq | grep -e "baptize.sh" -v | xargs)

for i in $f; do
	#echo "sed -i 's/gbifsweden\.se/testgbif\.nrm\.se/g' $i"
	sed -i 's/gbifsweden\.se/testgbif\.nrm\.se/g' $i
done

