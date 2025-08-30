#include <string.h>
#include <stdio.h>

// 의도적으로 취약한 코드: 길이 검증 없이 strcpy
void vuln_copy(const char *src) {
    char buf[16];
    // ⚠️ 절대 실제 코드에 사용하지 마세요. 교육/테스트 전용.
    strcpy(buf, src);
    // 최적화 방지용 출력
    printf("%s\n", buf);
}
