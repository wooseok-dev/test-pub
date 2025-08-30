#include <string.h>
#include <stdio.h>

// ⚠️ 길이 검증 없는 strcpy — 교육/테스트 전용 취약 코드
void tinycopy_copy(const char *src) {
    char buf[16];
    strcpy(buf, src);       // 의도적 버그
    printf("%s\n", buf);    // 최적화 방지용
}
