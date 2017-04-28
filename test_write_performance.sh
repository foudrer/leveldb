datadir=/mnt/testdata1
logdata=/mnt/logdata

# test log
rm -rf $datadir/*
echo 3 > /proc/sys/vm/drop_caches

out-static/db_bench --benchmarks=fillrandom --value_size=512 --num=1048576 --db=$datadir > $logdata/lsmbplus_result_fillrandom_log
