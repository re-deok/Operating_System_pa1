TARGET	= posh
CFLAGS	= -g -c -D_POSIX_C_SOURCE -D_GNU_SOURCE -D_XOPEN_SOURCE=700
CFLAGS += -std=c99 -Wimplicit-function-declaration -Werror
LDFLAGS	=

all: posh toy

posh: pa1.o parser.o
	gcc $(LDFLAGS) $^ -o $@

toy: toy.o
	gcc $(LDFLAGS) $^ -o $@

%.o: %.c
	gcc $(CFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -rf $(TARGET) toy *.o *.dSYM
 

.PHONY: test-run
test-run: $(TARGET) toy testcases/test-run
	./$< -q < testcases/test-run

.PHONY: test-cd
test-cd: $(TARGET) testcases/test-cd
	./$< -q < testcases/test-cd

.PHONY: test-history
test-cd: $(TARGET) testcases/test-history
	./$< -q < testcases/test-history

.PHONY: test-pipe
test-cd: $(TARGET) testcases/test-pipe
	./$< -q < testcases/test-pipe

test-all: test-run test-cd test-history test-pipe
	echo
