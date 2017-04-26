datadir=/mnt/testdata1
logdata=/mnt/logdata

# test log
rm -rf $datadir/*
echo 3 > /proc/sys/vm/drop_caches

#10GB data volume
out-static/db_bench --benchmarks=fillrandom --value_size=512 --num=1048576 --db=$datadir > $logdata/result_fillrandom_log

echo 3 > /proc/sys/vm/drop_caches
out-static/db_bench --benchmarks=readrandom --value_size=512 --num=1048576 --db=$datadir --use_existing_db=1 > $logdata/result_readrandom_log


# normal
#rm -rf $datadir/*
#echo 3 > /proc/sys/vm/drop_caches
#
##10GB data volume
#out-static/db_bench --benchmarks=fillrandom --value_size=512 --num=20971520 --db=$datadir > $logdata/result_fillrandom_512_20971520_opt
#
#echo 3 > /proc/sys/vm/drop_caches
#out-static/db_bench --benchmarks=readrandom --value_size=512 --num=20971520 --db=$datadir --use_existing_db=1 > $logdata/result_readrandom_512_20971520_opt


# one parameter(write and read)
#rm -rf $datadir/*
#echo 3 > /proc/sys/vm/drop_caches
#
##10GB data volume
#out-static/db_bench --benchmarks=fillrandom --value_size=512 --num=20971520 --db=$datadir > $logdata/result_fillrandom_512_20971520_one_parameter
#
#echo 3 > /proc/sys/vm/drop_caches
#out-static/db_bench --benchmarks=readrandom --value_size=512 --num=20971520 --db=$datadir --use_existing_db=1 > $logdata/result_readrandom_512_20971520_one_parameter

# two parameter(write and read)
#rm -rf $datadir/*
#echo 3 > /proc/sys/vm/drop_caches
#
##10GB data volume
#out-static/db_bench --benchmarks=fillrandom --value_size=512 --num=20971520 --db=$datadir > $logdata/result_fillrandom_512_20971520_two_parameter
#
#echo 3 > /proc/sys/vm/drop_caches
#out-static/db_bench --benchmarks=readrandom --value_size=512 --num=20971520 --db=$datadir --use_existing_db=1 > $logdata/result_readrandom_512_20971520_two_parameter

