CC ?= $(CROSS_COMPILE)gcc
CFLAGS ?= -O2
LDFLAGS ?=

SRC = dhry21a.c dhry21b.c timers.c
TARGET = dhrystone

all:
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

clean:
	rm -f $(TARGET)
