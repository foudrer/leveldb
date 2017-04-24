cmake_minimum_required(VERSION 2.8)
project(leveldb)
include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/include)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

#source files

#test files

#benchmark files

set(SOURCE_FILES
    db/builder.cc
    db/c.cc
    db/db_bench.cc
    db/db_impl.cc
    db/db_impl.h
    db/db_iter.cc
    db/db_iter.h
    db/dbformat.cc
    db/dumpfile.cc
    db/filename.cc
    db/leveldbutil.cc
    db/log_reader.cc
    db/log_reader.h
    db/log_test.cc
    db/log_writer.cc
    db/log_writer.h
    db/memtable.cc
    db/memtable.h
    db/recovery_test.cc
    db/repair.cc
    db/skiplist.h
    db/skiplist_test.cc
    db/snapshot.h
    db/table_cache.cc
    db/table_cache.h
    db/version_edit.cc
    db/version_edit.h
    db/version_edit_test.cc
    db/version_set.cc
    db/version_set.h
    db/version_set_test.cc
    db/write_batch.cc
    db/write_batch_internal.h
    db/write_batch_test.cc
    doc/bench/db_bench_sqlite3.cc
    doc/bench/db_bench_tree_db.cc
    helpers/memenv/memenv.cc
    helpers/memenv/memenv.h
    helpers/memenv/memenv_test.cc
    issues/issue178_test.cc
    issues/issue200_test.cc
    port/win/stdint.h
    port/atomic_pointer.h
    port/port.h
    port/port_example.h
    port/port_posix.cc
    port/port_posix.h
    port/port_posix_sse.cc
    port/thread_annotations.h
    table/block.cc
    table/block.h
    table/block_builder.cc
    table/block_builder.h
    table/filter_block.cc
    table/filter_block.h
    table/filter_block_test.cc
    table/format.cc
    table/format.h
    table/iterator.cc
    table/iterator_wrapper.h
    table/merger.cc
    table/merger.h
    table/table.cc
    table/table_builder.cc
    table/table_test.cc
    table/two_level_iterator.cc
    table/two_level_iterator.h
    util/arena.cc
    util/arena.h
    util/arena_test.cc
    util/bloom.cc
    util/bloom_test.cc
    util/cache.cc
    util/cache_test.cc
    util/coding.cc
    util/coding.h
    util/coding_test.cc
    util/comparator.cc
    util/crc32c.cc
    util/crc32c.h
    util/crc32c_test.cc
    util/env.cc
    util/env_posix.cc
    util/env_posix_test.cc
    util/env_posix_test_helper.h
    util/env_test.cc
    util/filter_policy.cc
    util/hash.cc
    util/hash.h
    util/hash_test.cc
    util/histogram.cc
    util/histogram.h
    util/logging.cc
    util/logging.h
    util/mutexlock.h
    util/options.cc
    util/posix_logger.h
    util/random.h
    util/status.cc
    util/testharness.cc
    util/testharness.h
    util/testutil.cc
    util/testutil.h)

add_executable(leveldb ${SOURCE_FILES})
