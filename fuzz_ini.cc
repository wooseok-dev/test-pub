#include <stdint.h>
#include <stddef.h>
extern "C" int parse_ini(const uint8_t* data, size_t size);

extern "C" int LLVMFuzzerTestOneInput(const uint8_t* Data, size_t Size) {
    parse_ini(Data, Size);
    return 0;
}
