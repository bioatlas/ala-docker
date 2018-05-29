#!/bin/bash

f=$(grep -r -e "http://bioatlas.se" * | cut -d: -f1 | sort -d | uniq |grep -e "baptize.sh" -v | xargs)

for i in $f; do
	echo "sed -i 's,http://bioatlas.se,https://bioatlas.se,g' $i"
	sed -i 's,http://bioatlas.se,https://bioatlas.se,g' $i
done

