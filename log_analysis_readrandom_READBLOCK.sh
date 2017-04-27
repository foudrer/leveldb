grep "fileread" $1 > tmp_file

awk 'BEGIN{num=0;total=0;fileread=0;filecrc=0;uncompress=0}{num += 1;fileread += $2;filecrc += $4;uncompress += $6;total += $2 + $4 + $6}END{print fileread/num " " filecrc/num " " uncompress/num " " total/num "\n" fileread/total*100 " " filecrc/total*100 " " uncompress/total*100 " " total/total*100}' tmp_file

rm -rf tmp_file
