grep "prepare" $1 > tmp_file

awk 'BEGIN{num=0;total=0;prepare=0;compress=0;writerawblock=0}{num += 1;prepare += $2;compress += $4;writerawblock += $6;total += $2 + $4 + $6}END{num /= 1024;print prepare/num " " compress/num " " writerawblock/num " " total/num "\n" prepare/total*100 " " compress/total*100 " " writerawblock/total*100 " " total/total*100}' $1

rm -rf tmp_file
