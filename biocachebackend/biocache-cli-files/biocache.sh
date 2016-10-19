#!/bin/sh
exec java -Dlog4j.configuration=file:/usr/lib/biocache/log4j.xml -Dfile.encoding=UTF8 -Dactors.corePoolSize=8 -Dactors.maxPoolSize=16 -Dactors.minPoolSize=8 -Djava.util.Arrays.useLegacyMergeSort=true -Xmx1g -Xms1g -jar $0 "$@"


