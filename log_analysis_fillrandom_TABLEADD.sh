grep "index_block_add" $1 > tmp_file

awk 'BEGIN{num=0;total=0;index_block_add=0;filter_block_add=0;data_block_add=0;flush=0}{num += 1;index_block_add += $2;filter_block_add += $4;data_block_add += $6;flush += $8;total += $2 + $4 + $6 + $8}END{num /= 8192;print index_block_add/num " " filter_block_add/num " " data_block_add/num " " flush/num " " total/num "\n" index_block_add/total*100 " " filter_block_add/total*100 " " data_block_add/total*100 " " flush/total*100 " "total/total*100}' tmp_file

rm -rf tmp_file
