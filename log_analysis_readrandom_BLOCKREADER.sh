grep "cachelookup" $1 > tmp_file

awk 'BEGIN{num=0;total=0;cachelookup=0;cachevalue=0;cachereadblock=0;cachereadblock=0;cacheinsert=0;nocachereadblock=0}{num += 1;cachelookup += $2;cachevalue += $4;cachereadblock += $6;cacheinsert += $8;nocachereadblock += $10;total += $2 + $4 + $6 + $8 + $10}END{print cachelookup/num " " cachevalue/num " " cachereadblock/num " " cacheinsert/num " " nocachereadblock/num " " total/num "\n" cachelookup/total*100 " " cachevalue/total*100 " " cachereadblock/total*100 " " cacheinsert/total*100 " " nocachereadblock/total*100 " " total/total*100}' tmp_file

rm -rf tmp_file
