grep "writeblock" $1 > tmp_file

awk 'BEGIN{num=0;total=0;prepare=0;writeblock=0;fileflush=0;filterblockstart=0}{num += 1;prepare += $2;writeblock += $4;fileflush += $6;filterblockstart += $8;total += $2 + $4 + $6 + $8}END{num /= 1024;print prepare/num " " writeblock/num " " fileflush/num " " filterblockstart/num " " total/num "\n" prepare/total*100 " " writeblock/total*100 " " fileflush/total*100 " " filterblockstart/total*100 " " total/total*100}' $1


rm -rf tmp_file
