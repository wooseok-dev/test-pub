// ini.c (UAF 주입 최종본)
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "ini.h"

// 의도적으로 취약한 INI 파서 (Use-After-Free 삽입)
int parse_ini(const uint8_t* d, size_t n) {
    size_t i = 0;
    char key[64]; // 원래 취약점(스택 버퍼) 유지해도 되지만, UAF가 더 확실히 터짐
    while (i < n) {
        size_t start = i;
        while (i < n && d[i] != '\n') i++;
        size_t len = i - start;

        // '=' 위치 찾기
        size_t eq = start;
        while (eq < start + len && d[eq] != '=') eq++;

        if (eq < start + len) {
            size_t klen = eq - start;
            // (고의적) 키 길이 검증 없이 복사
            if (klen > 0) {
                // 일부러 오버플로 위험을 남겨둠 (데모 목적)
                memcpy(key, d + start, klen);
                key[klen < sizeof(key) ? klen : sizeof(key) - 1] = '\0';
            }

            // value 조작
            size_t vstart = eq + 1;
            size_t vlen = (start + len > vstart) ? (start + len - vstart) : 0;

            char* val = (char*)malloc(vlen + 1);
            if (!val) return 0;
            if (vlen) memcpy(val, d + vstart, vlen);
            val[vlen] = '\0';

            // ======== 핵심 취약점: Use-After-Free ========
            free(val);
            if (vlen > 0) {
                // 해제 후 접근 → ASan이 즉시 탐지
                volatile unsigned s = 0;
                s += (unsigned)((unsigned char*)val)[0];
                (void)s;
            }
            // ============================================

        }
        if (i < n) i++; // '\n' 스킵
    }
    return 0;
}

