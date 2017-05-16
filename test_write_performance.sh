datadir=/mnt/testdata1
logdata=/mnt/logdata

# test log
rm -rf $datadir/*
echo 3 > /proc/sys/vm/drop_caches

out-static/db_bench --benchmarks=fillrandom --value_size=512 --num=20971520 --db=$datadir > $logdata/lsmbplus_result_fillrandom_512_20971520
