SUMMARY = "Defines Kernel, U-Boot Patches,device tree, defconfig macros"

# Kernel
KERNEL_CONFIG_AARCH64 = "adlink_lec_i1200_defconfig"
KERNEL_DEVICETREE = "mediatek/lec-mtk-i1200-ufs.dtb"

# kernel patches
EXTRA_KERNEL_PATCHES = " \
	file://adlink_lec_i1200_defconfig \
        file://0001-Modify-i2c-imx214-to-support-extra-extension.patch \
        file://0002-Replace-i2c-mbus_code-to-mtk_mbus_code.patch \
        file://0003-Modify-i2c-imx214-driver-to-support-2-4-lane-mode.patch \
        file://0004-Added-display-port-over-DP-connector.patch\
        file://0005-Added-support-for-panel-b101uan01-and-ADLINK-Config.patch \
        file://0006-Added-TPM2.0-Support.patch \
        file://0007-Added-support-PCIe-WIFI-BT-TLV320-Support.patch \
        file://0008-Added-support-imx219-camera.patch \
"
EXTRA_KERNEL_DTS = " \
	file://lec-mtk-i1200-ufs.dts \
        file://lec-mtk-i1200.dts \
        file://mt8195.dtsi \
"

KERNEL_SRC_PATCHES ="\
	${EXTRA_KERNEL_PATCHES} \
	${EXTRA_KERNEL_DTS} \
"

# U-Boot
UBOOT_MACHINE = "lec_mtk_i1200_defconfig"

# u-boot
UBOOT_DTB_NAME = "lec-mtk-i1200-ufs.dtb"


# u-boot patches
EXTRA_UBOOT_PATCHES = " \
	file://lec_mtk_i1200_defconfig \
	file://0001-Added-Board-support-for-LEC-MTK-i1200.patch \
	file://0002-Enable-I2C-clock-and-individual-xHCI-controller.patch \
	file://0003-Added-interfacetest-environment-variable-to-list.patch \
	file://0004-Added-edp-panel-support.patch \
	file://0005-Added-DSI-panel-support.patch \
	file://fw_env.config  \
	file://boot.script \
	file://fdt-env.cfg \
	file://boot.script.its \
	${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://secure-boot.cfg", "", d)} \
	file://fdt-env.cfg \
	file://boot.script.its \
	${@bb.utils.contains("AB_FWUPDATE_ENABLE", "1", "file://ab-fwupdate.cfg", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "fwupdate", "file://secure-cap.dts", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "fwupdate", "file://u-boot-cap.key", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "fwupdate", "file://u-boot-cap.crt", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "fwupdate", "file://u-boot-cap", "", d)} \
"

EXTRA_UBOOT_DTS = " \
	file://lec-mtk-i1200-ufs.dts \
"
UBOOT_SRC_PATCHES = " \
        ${EXTRA_UBOOT_PATCHES} \
        ${EXTRA_UBOOT_DTS} \
"
