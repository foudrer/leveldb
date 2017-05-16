datadir=/mnt/testdata1
logdata=/mnt/logdata

# test log

echo 3 > /proc/sys/vm/drop_caches
out-static/db_bench --benchmarks=readrandom --value_size=512 --num=20971520 --db=$datadir --use_existing_db=1 > $logdata/lsmbplus2_result_readrandom_512_20971520
