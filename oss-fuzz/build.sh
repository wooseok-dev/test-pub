#!/bin/bash -eu
# 환경변수:
#  $SRC  : /src
#  $OUT  : /out (fuzzer 실행파일과 dict, options를 여기 둠)
#  $CFLAGS/$CXXFLAGS : sanitizer/coverage 옵션 포함

cd $SRC/example-ini-parser

# 프로젝트 빌드(예: 단순 라이브러리)
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j"$(nproc)"

# fuzz 타깃 빌드
$CXX $CXXFLAGS -std=c++17 -I../src \
  ../fuzz/fuzz_ini.cc \
  -o $OUT/ini_fuzzer \
  -fsanitize=fuzzer,address \
  ../build/libyourini.a 2>/dev/null || true

# 시드 복사(있으면)
mkdir -p $OUT/seeds
cp -r $SRC/example-ini-parser/fuzz/seeds/* $OUT/seeds/ || true
