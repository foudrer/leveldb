// Copyright (c) 2011 The LevelDB Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file. See the AUTHORS file for names of contributors.

#include "db/builder.h"

#include "db/filename.h"
#include "db/dbformat.h"
#include "db/table_cache.h"
#include "db/version_edit.h"
#include "leveldb/db.h"
#include "leveldb/env.h"
#include "leveldb/iterator.h"
#include "leveldb/statistics.h"

namespace leveldb {

Status BuildTable(const std::string& dbname,
                  Env* env,
                  const Options& options,
                  TableCache* table_cache,
                  Iterator* iter,
                  FileMetaData* meta) {
#ifdef BUILDTABLE
  struct timeval start, end;
  double create_file = 0;
  double create_table = 0;
  double insert_data = 0;
  double table_finish = 0;
  double file_sync = 0;
  double file_close = 0;
#endif
  Status s;
  meta->file_size = 0;
  iter->SeekToFirst();

  std::string fname = TableFileName(dbname, meta->number);
  if (iter->Valid()) {
#ifdef BUILDTABLE
    gettimeofday(&start, NULL);
#endif
    WritableFile* file;
    s = env->NewWritableFile(fname, &file);  // 创建一个文件(open)
    if (!s.ok()) {
      return s;
    }
#ifdef BUILDTABLE
    gettimeofday(&end, NULL);
    create_file = timeval_diff(&start, &end);

    gettimeofday(&start, NULL);
#endif
    TableBuilder* builder = new TableBuilder(options, file);
#ifdef BUILDTABLE
    gettimeofday(&end, NULL);
    create_table = timeval_diff(&start, &end);
#endif
    meta->smallest.DecodeFrom(iter->key());
#ifdef BUILDTABLE
    gettimeofday(&start, NULL);
#endif
    for (; iter->Valid(); iter->Next()) {
      Slice key = iter->key();
      meta->largest.DecodeFrom(key);
      builder->Add(key, iter->value());
    }
#ifdef BUILDTABLE
    gettimeofday(&end, NULL);
    insert_data = timeval_diff(&start, &end);

    // Finish and check for builder errors
    gettimeofday(&start, NULL);
#endif
    if (s.ok()) {
      s = builder->Finish();
      if (s.ok()) {
        meta->file_size = builder->FileSize();
        assert(meta->file_size > 0);
      }
    } else {
      builder->Abandon();
    }
    delete builder;
#ifdef BUILDTABLE
    gettimeofday(&end, NULL);
    table_finish = timeval_diff(&start, &end);
    // Finish and check for file errors

    gettimeofday(&start, NULL);
#endif
    if (s.ok()) {
      s = file->Sync();
    }
#ifdef BUILDTABLE
    gettimeofday(&end, NULL);
    file_sync = timeval_diff(&start, &end);

    gettimeofday(&start, NULL);
#endif
    if (s.ok()) {
      s = file->Close();
    }
#ifdef BUILDTABLE
    gettimeofday(&end, NULL);
    file_close = timeval_diff(&start, &end);
#endif
    delete file;
    file = NULL;

    if (s.ok()) {
      // Verify that the table is usable
      Iterator* it = table_cache->NewIterator(ReadOptions(),
                                              meta->number,
                                              meta->file_size);
      s = it->status();
      delete it;
    }
  }

  // Check for input iterator errors
  if (!iter->status().ok()) {
    s = iter->status();
  }

  if (s.ok() && meta->file_size > 0) {
    // Keep it
  } else {
    env->DeleteFile(fname);
  }
#ifdef BUILDTABLE
  std::cout << "createfile " << create_file << " createtable " << create_table <<
            " insertdata " << insert_data << " tablefinish " << table_finish << " filesync "
            << file_sync << " fileclose " << file_close << std::endl;
#endif
  return s;
}

}  // namespace leveldb
