#!/bin/bash
if which gsed > /dev/null; then
	sed=gsed
else
	sed=sed
fi

FROM='logger.bioatlas.se'
TO='logger.biodiversitydata.se'

f=$(grep -r -e $FROM * | cut -d: -f1 | sort -d | uniq |grep -e "baptize2.sh" -v | xargs)

for i in $f; do
	echo "sed -i 's,$FROM,$TO,' $i"
        #sed -i "s,$FROM,$TO,g" $i
done
