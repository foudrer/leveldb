datadir=/mnt/testdata1
logdata=/mnt/logdata

# test log
rm -rf $datadir/*
echo 3 > /proc/sys/vm/drop_caches

out-static/db_bench --benchmarks=fillrandom --value_size=512 --num=10485760 --db=$datadir > $logdata/result_fillrandom_log
