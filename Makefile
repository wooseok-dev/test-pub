CC ?= clang
CFLAGS ?= -O2 -g -Iinclude

all: libtinycopy.a tinycopy

libtinycopy.a: src/tinycopy.o
	ar rcs $@ $^

src/tinycopy.o: src/tinycopy.c include/tinycopy.h
	$(CC) $(CFLAGS) -c $< -o $@

tinycopy: src/main.o libtinycopy.a
	$(CC) $(CFLAGS) $^ -o $@

src/main.o: src/main.c include/tinycopy.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f src/*.o libtinycopy.a tinycopy
