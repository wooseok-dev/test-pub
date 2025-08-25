#include <stdint.h>
#include <stddef.h>
extern "C" {
  int parse_ini(const char* data, size_t len); // 당신의 파서 함수(예)
}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
  if (Size == 0 || Size > (1<<20)) return 0; // 1MB 상한 안전장치
  // 파서에 바로 먹이기
  (void)parse_ini(reinterpret_cast<const char*>(Data), Size);
  return 0;
}
