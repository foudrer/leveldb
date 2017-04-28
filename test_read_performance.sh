datadir=/mnt/testdata1
logdata=/mnt/logdata

# test log

echo 3 > /proc/sys/vm/drop_caches
out-static/db_bench --benchmarks=readrandom --value_size=512 --num=1048576 --db=$datadir --use_existing_db=1 > $logdata/lsmbplus_result_readrandom_log
