ASMSOURCES := $(wildcard *.asm)
PROGRAMS := $(patsubst %.asm,%,$(ASMSOURCES))
OBJS := $(patsubst %.asm,%.o,$(ASMSOURCES))

.PHONY: all clean $(PROGRAMS)

all: $(PROGRAMS)

$(PROGRAMS): %: %.o $(OBJS)
	ld -m elf_i386 -s -o $@ $(OBJS)

%.o: %.asm
	nasm -f elf $< -o $@

clean:
	rm -f $(PROGRAMS) $(OBJS)