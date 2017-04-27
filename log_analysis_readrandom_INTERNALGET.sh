grep "seek" $1 > tmp_file

awk 'BEGIN{num=0;total=0;seek=0;blockread=0;blockseek=0}{num += 1;seek += $2;blockread += $4;blockseek += $6;total += $2 + $4 + $6}END{print seek/num " " blockread/num " " blockseek/num " " total/num "\n" seek/total*100 " " blockread/total*100 " " blockseek/total*100 " " total/total*100}' tmp_file

rm -rf tmp_file
