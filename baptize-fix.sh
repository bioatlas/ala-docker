#!/bin/bash
if which gsed > /dev/null; then
    sed=gsed
else
    sed=sed
fi

FROM=http://auth.bioatlas.se
TO=https://auth.bioatlas.se

f=$(grep -r -e $FROM * | cut -d: -f1 | sort -d | uniq |grep -e "baptize-fix-2.sh" -v | xargs)

for i in $f; do
    echo "sed -i 's,$FROM,$TO,g' $i"
    $sed -i s,$FROM,$TO,g $i
done
