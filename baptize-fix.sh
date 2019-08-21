#!/bin/bash
if which gsed > /dev/null; then
    sed=gsed
else
    sed=sed
fi

FROM=https://beta.bioatlas.se
TO=http://beta.bioatlas.se

f=$(grep -r -e $FROM * | cut -d: -f1 | sort -d | uniq |grep -e "baptize-fix.sh" -v | xargs)

for i in $f; do
    echo "sed -i 's,$FROM,$TO,g' $i"
    $sed -i s,$FROM,$TO,g $i
done
