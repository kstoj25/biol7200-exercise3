#!/bin/bash

query="$1"
subject="$2"
output="$3"
 
makeblastdb -in "$subject" -dbtype nucl -out subject_db > /dev/null
 
tblastn -query "$query" -db subject_db \
    -outfmt "6 qseqid sseqid pident length qlen evalue bitscore" \
    | awk '$3 > 30 && $4 > 0.9 * $5' > "$output"
 
rm -f subject_db.n*
 
wc -l < "$output"
