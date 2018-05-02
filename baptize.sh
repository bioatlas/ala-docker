#!/bin/bash

f=$(grep -r -e "https://bioatlas.se" | cut -d: -f1 | sort -d | uniq |grep -e "baptize.sh" -v | xargs)

for i in $f; do
	echo "sed -i 's,https://bioatlas.se,http://bioatlas.se,g' $i"
	sed -i 's,https://bioatlas.se,http://bioatlas.se,g' $i
done

