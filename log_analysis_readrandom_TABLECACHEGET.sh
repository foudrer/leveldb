grep "findtable" $1 > tmp_file

awk 'BEGIN{num=0;total=0;findtable=0;internalget=0}{num += 1;findtable += $2;internalget += $4;total += $2 + $4}END{print findtable/num " " internalget/num " " total/num "\n" findtable/total*100 " " internalget/total*100 " " total/total*100}' tmp_file

rm -rf tmp_file
