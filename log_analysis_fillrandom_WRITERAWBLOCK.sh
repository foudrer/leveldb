grep "fileappend" $1 > tmp_file

awk 'BEGIN{num=0;total=0;fileappend=0;crc=0}{num += 1;fileappend += $2;crc += $4;total += $2 + $4}END{num /= 1024;print fileappend/num " " crc/num " " total/num "\n" fileappend/total*100 " " crc/total*100 " " total/total*100}' $1

rm -rf tmp_file
