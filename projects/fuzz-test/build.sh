#!/bin/bash
set -euxo pipefail

# helper.py 가 /src/build.sh 를 실행하므로 CWD는 /src 입니다.
# 환경변수: CC/CXX/CFLAGS/CXXFLAGS/LIB_FUZZING_ENGINE/OUT

# 소스 존재 확인 (디버깅에 도움)
test -f toy-ini/ini.c
test -f toy-ini/fuzz_ini.cc

# C는 CC로 객체 생성, 링크는 CXX로 (libFuzzer는 C++ 링크 필요)
$CC  $CFLAGS   -I toy-ini -c toy-ini/ini.c -o ini.o
$CXX $CXXFLAGS            ini.o toy-ini/fuzz_ini.cc \
     $LIB_FUZZING_ENGINE -o $OUT/fuzz_ini

# --- Seed corpus 패키징 ---
# toy-ini/seed_corpus 폴더가 있으면 zip으로 묶어 fuzzer와 같은 이름 규칙으로 저장
if [ -d toy-ini/seed_corpus ]; then
  # -r: 재귀, -j: 경로 제거(파일만), -q: 조용히
  zip -r -j -q "$OUT/fuzz_ini_seed_corpus.zip" toy-ini/seed_corpus
fi

# 산출물 확인
ls -l "$OUT"

