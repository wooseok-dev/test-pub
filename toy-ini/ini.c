#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <stdlib.h>
#include "ini.h"

// deliberately naive/buggy INI-like parser for fuzzing
int parse_ini(const uint8_t* d, size_t n) {
    size_t i = 0;
    char key[64]; // BUG: fixed-size stack buffer
    while (i < n) {
        size_t start = i;
        while (i < n && d[i] != '\n') i++;
        size_t len = i - start;

        // Find '='
        size_t eq = start;
        while (eq < start + len && d[eq] != '=') eq++;

        if (eq < start + len) {
            size_t klen = eq - start;
            // BUG: no bounds check on klen -> stack-buffer-overflow when klen > 63
            memcpy(key, d + start, klen);
            key[klen] = '\0';

            // pretend to do something with the value
            size_t vstart = eq + 1;
            size_t vlen = start + len - vstart;
            // small dynamic allocation that may trigger allocator patterns
            char* val = (char*)malloc(vlen + 1);
            if (!val) return 0;
            memcpy(val, d + vstart, vlen);
            val[vlen] = 0;
            // touch a few bytes
            if (vlen >= 4) {
                volatile unsigned s = (unsigned)val[0] + val[1] + val[2] + val[3];
                (void)s;
            }
            free(val);
        }
        i++; // skip '\n'
    }
    return 0;
}
