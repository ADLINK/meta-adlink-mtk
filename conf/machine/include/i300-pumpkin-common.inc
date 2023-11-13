require mt7668.inc

MACHINEOVERRIDES =. "i300-pumpkin:"

# Kernel
DTB_LOADADDRESS = "0x44000000"

# U-Boot
UBOOT_ENTRYPOINT = "0x40200000"
UBOOT_LOADADDRESS = "0x40200000"
UBOOT_DTB_LOADADDRESS = "0x44000000"
UBOOT_DTBO_LOADADDRESS = "0x44c00000"
UBOOT_MACHINE = "mt8516_pumpkin_defconfig"

# TF-A priv
TFA_BOARD_NAME = "mt8516-pumpkin"

# libdram
LIBDRAM_BOARD_NAME = "mt8516-pumpkin"

# LK
LK_PROJECT = "pumpkin8516-emmc"
LK_BOARD_NAME = "${LIBDRAM_BOARD_NAME}"

MACHINE_FEATURES:append = " alsa bluetooth usbgadget usbhost wifi"
