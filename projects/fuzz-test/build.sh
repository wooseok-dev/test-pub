#!/bin/bash
# Build three fuzzers and package seed corpora for OSS-Fuzz.
set -euxo pipefail

# Environment provided by base-builder:
#  - CC/CXX/CFLAGS/CXXFLAGS
#  - LIB_FUZZING_ENGINE
#  - OUT (output dir for fuzz targets)
#  - SRC (source dir)

# 1) toy-ini -> fuzz_ini
$CXX $CXXFLAGS -I projects/toy-ini \
  projects/toy-ini/ini.c projects/toy-ini/fuzz_ini.cc \
  $LIB_FUZZING_ENGINE -o $OUT/fuzz_ini

# 2) tlv -> fuzz_tlv
$CXX $CXXFLAGS -I projects/tlv \
  projects/tlv/tlv.c projects/tlv/fuzz_tlv.cc \
  $LIB_FUZZING_ENGINE -o $OUT/fuzz_tlv

# 3) numparse -> fuzz_numparse
$CXX $CXXFLAGS -I projects/numparse \
  projects/numparse/numparse.c projects/numparse/fuzz_numparse.cc \
  $LIB_FUZZING_ENGINE -o $OUT/fuzz_numparse

# Seed corpora (flattened)
zip -r -j -q "$OUT/fuzz_ini_seed_corpus.zip" projects/toy-ini/seed_corpus || true
#zip -r -j -q "$OUT/fuzz_tlv_seed_corpus.zip" projects/tlv/seed_corpus || true
#zip -r -j -q "$OUT/fuzz_numparse_seed_corpus.zip" projects/numparse/seed_corpus || true

echo "Built fuzzers into $OUT:"
ls -l $OUT

