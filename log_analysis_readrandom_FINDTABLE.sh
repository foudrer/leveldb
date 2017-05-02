grep "cachelookup" $1 > tmp_file

awk 'BEGIN{num=0;total=0;cachelookup=0;cachefailnewfile=0;cachefailopen=0;cachefailinsert=0}{num += 1;cachelookup += $2;cachefailnewfile += $4;cachefailopen += $6;cachefailinsert += $8;total += $2 + $4 + $6 + $8}END{print cachelookup/num " " cachefailnewfile/num " " cachefailopen/num " " cachefailinsert/num " " total/num "\n" cachelookup/total*100 " " cachefailnewfile/total*100 " " cachefailopen/total*100 " " cachefailinsert/total*100 " " total/total*100}' tmp_file

rm -rf tmp_file
