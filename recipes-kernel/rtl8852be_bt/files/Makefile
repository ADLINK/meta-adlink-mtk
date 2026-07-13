CROSS_COMPILE ?=
ARCH = arm64
PWD := $(shell pwd)
KDIR ?= /lib/modules/$(shell uname -r)/build

obj-m := rtk_btusb.o
rtk_btusb-objs := rtk_coex.o rtk_misc.o rtk_bt.o

all:
	$(MAKE) -C $(KDIR) M=$(PWD) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) modules

clean:
	rm -rf *.o *.ko *.mod.c *.mod.o *.symvers *.order

