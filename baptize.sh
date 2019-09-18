#!/bin/bash

f=$(grep -r -e "https://beta.bioatlas.se" * | cut -d: -f1 | sort -d | uniq |grep -e "baptize.sh" -v | xargs)

for i in $f; do
	echo "sed -i 's,https://beta.bioatlas.se,http://molecular.infrabas.se,g' $i"
	sed -i 's,https://beta.bioatlas.se,http://molecular.infrabas.se,g' $i
done
