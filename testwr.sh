datadir=/mnt/testdata1
logdata=/mnt/logdata


rm -rf $datadir/*
echo 3 > /proc/sys/vm/drop_caches

#10GB data volume
out-static/db_bench --benchmarks=fillrandom --value_size=512 --num=20971520 --db=$datadir > $logdata/result_fillrandom_512_20971520_opt

echo 3 > /proc/sys/vm/drop_caches
out-static/db_bench --benchmarks=readrandom --value_size=512 --num=20971520 --db=$datadir --use_existing_db=1 > $logdata/result_readrandom_512_20971520_opt
