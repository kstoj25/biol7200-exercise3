#!/bin/bash

query="$1"
subject="$2"
output="$3"
 
db_name="$(mktemp -u subject_db_XXXXXX)"
 
makeblastdb -in "$subject" -dbtype nucl -out "$db_name" > /dev/null
 
tblastn -query "$query" -db "$db_name" \
    -outfmt "6 qseqid sseqid pident length qlen evalue bitscore" \
    | awk '$3 > 30 && $4 > 0.9 * $5' > "$output"
 
rm -f "$db_name".n*
 
wc -l < "$output"
