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
#include <iostream>

namespace leveldb {

Status BuildTable(const std::string& dbname,
                  Env* env,
                  const Options& options,
                  TableCache* table_cache,
                  Iterator* iter,
                  FileMetaData* meta,
                  Db* bdb) {
  Status s;
  meta->file_size = 0;
  iter->SeekToFirst();

  std::string fname = TableFileName(dbname, meta->number);
  if (iter->Valid()) {
    WritableFile* file;
    s = env->NewWritableFile(fname, &file);
    if (!s.ok()) {
      return s;
    }

    TableBuilder* builder = new TableBuilder(options, file);
    meta->smallest.DecodeFrom(iter->key());
    if (bdb == NULL) {
      for (; iter->Valid(); iter->Next()) {
        Slice key = iter->key();
        meta->largest.DecodeFrom(key);
        builder->Add(key, iter->value());
      }
    } else {
      for (; iter->Valid(); iter->Next()) {
        Slice key = iter->key();
        meta->largest.DecodeFrom(key);
        builder->Add(key, Slice());
        std::cout << ExtractUserKey(key).ToString() << " " <<
                  ExtractSequenceNumber(key) << " " << ExtractValueType(key) << std::endl;
        // bdb insert
        Slice bdbkey = ExtractSequenceNumandValueTypeforString(key);
        Slice bdbvalue = iter->value();
        Dbt* bdb_key = new Dbt(const_cast<char*>(bdbkey.data()), bdbkey.size());
        Dbt* bdb_value = new Dbt(const_cast<char*>(bdbvalue.data()), bdbvalue.size());
        if (bdb->put(NULL, bdb_key, bdb_value, 0) != 0) {
          s = Status::Corruption("BDB put failure");
          break;
        }
      }
    }

    // Finish and check for builder errors
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

    // Finish and check for file errors
    if (s.ok()) {
      s = file->Sync();
    }
    if (s.ok()) {
      s = file->Close();
    }
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
  return s;
}

}  // namespace leveldb
