grep "searchfile*" $1 > tmp_file

awk 'BEGIN{num=0;total=0;searchfile=0;getvalue=0}{num += 1;searchfile += $2;getvalue += $4;total += $2 + $4}END{print searchfile/num " " getvalue/num " " total/num "\n" searchfile/total*100 " " getvalue/total*100 " " total/total*100}' tmp_file

rm -rf tmp_file
