SUMMARY = "Defines Kernel, U-Boot Patches,device tree, defconfig macros"

# Kernel
KERNEL_CONFIG_AARCH64 = "absolute-vision_mtk510_defconfig"
KERNEL_DEVICETREE = "mediatek/absolute-vision.dtb"

# kernel patches
EXTRA_KERNEL_PATCHES = " \
        file://absolute-vision_mtk510_defconfig \
        file://0001-Add-absolute-vision-support.patch \
	file://0002-Add-RTL8211F-LED-config-and-TPM.patch \
        file://0003-fsource-add-fsource-driver-to-enable-vefuse.patch \
        file://0004-init-HDMI-re-driver-at-HDMI-plug.patch \
        file://0005-Add-read-MAC-address-from-nvmem-support.patch \
	file://0006-Enable-audio-codec-tlv320aic3106.patch \
"
EXTRA_KERNEL_DTS = " \
        file://absolute-vision.dts \
"

KERNEL_SRC_PATCHES ="\
	${EXTRA_KERNEL_PATCHES} \
	${EXTRA_KERNEL_DTS} \
"
