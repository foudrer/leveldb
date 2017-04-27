grep "cachelookup" $1 > tmp_file

awk 'BEGIN{num=0;total=0;cachelookup=0;cachefail=0}{num += 1;cachelookup += $2;cachefail += $4;total += $2 + $4}END{print cachelookup/num " " cachefail/num " " total/num "\n" cachelookup/total*100 " " cachefail/total*100 " " total/total*100}' tmp_file

rm -rf tmp_file
