echo $PWD
echo $SRC
ls -alh
find / -name "ini.c" 2> /dev/null
$CC $CFLAGS $SANITIZER_FLAGS -c $SRC/fuzz-test/ini.c -I.
$CC $CFLAGS $SANITIZER_FLAGS -c $SRC/fuzz.c -I.
$CC $CFLAGS $SANITIZER_FLAGS $LIB_FUZZING_ENGINE ini.o fuzz.o -o $OUT/fuzz

