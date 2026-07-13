

SRC := $(shell pwd)

EXTRA_CFLAGS += -O2
EXTRA_CFLAGS += -DCONFIG_RTW89_DEBUGMSG
EXTRA_CFLAGS += -DCONFIG_RTW89_DEBUGFS
KEY_FILE ?= MOK.der

obj-m += rtw89core.o
rtw89core-y +=  core.o \
		mac80211.o \
		mac.o \
		mac_be.o \
		phy.o \
		phy_be.o \
		fw.o \
		cam.o \
		efuse.o \
		efuse_be.o \
		regd.o \
		sar.o \
		coex.o \
		ps.o \
		chan.o \
		debug.o \
		ser.o \
		wow.o \
		acpi.o

obj-m += rtw_8851b.o
rtw_8851b-y := rtw8851b.o \
		    rtw8851b_table.o \
		    rtw8851b_rfk.o \
		    rtw8851b_rfk_table.o

obj-m += rtw_8851be.o
rtw_8851be-y := rtw8851be.o

obj-m += rtw_8852a.o
rtw_8852a-y := rtw8852a.o \
		    rtw8852a_table.o \
		    rtw8852a_rfk.o \
		    rtw8852a_rfk_table.o

obj-m += rtw_8852ae.o
rtw_8852ae-y := rtw8852ae.o

obj-m += rtw_8852b.o
rtw_8852b-y := rtw8852b.o \
		    rtw8852b_table.o \
		    rtw8852b_rfk.o \
		    rtw8852b_rfk_table.o

obj-m += rtw_8852be.o
rtw_8852be-y := rtw8852be.o

obj-m += rtw_8852c.o
rtw_8852c-y := rtw8852c.o \
	       rtw8852c_table.o \
	       rtw8852c_rfk.o \
	       rtw8852c_rfk_table.o

obj-m += rtw_8852ce.o
rtw_8852ce-y := rtw8852ce.o

obj-m += rtw_8922a.o 
rtw_8922a-y := rtw8922a.o \
	       rtw8922a_rfk.o

obj-m += rtw_8922ae.o
rtw_8922ae-y := rtw8922ae.o

obj-m += rtw89pci.o
rtw89pci-y := pci.o \
	      pci_be.o

ccflags-y += -D__CHECK_ENDIAN__


all:
	$(MAKE) -C $(KERNEL_SRC) M=$(SRC)

modules_install:
	$(MAKE) -C $(KERNEL_SRC) M=$(SRC) modules_install

clean:
	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c
	rm -f Module.markers Module.symvers modules.order
	rm -rf .tmp_versions Modules.symvers

sign:
ifeq ($(NO_SKIP_SIGN), y)
	@openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=Custom MOK/"
	@mokutil --import MOK.der
else
	echo "Skipping key creation"
endif
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw89core.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw89pci.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8851b.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8851be.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8852a.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8852ae.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8852b.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8852be.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8852c.ko
	@$(KSRC)/scripts/sign-file sha256 MOK.priv MOK.der rtw_8852ce.ko

sign-install: all sign install

