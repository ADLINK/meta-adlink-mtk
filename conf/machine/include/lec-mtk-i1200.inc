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
	file://0004-Added-display-port-over-DP-connector.patch \
        file://0005-Added-support-for-panel-b101uan01-and-ADLINK-Config.patch \
        file://0006-Added-TPM2.0-Support.patch \
        file://0007-Added-PCIe-compliance-test-support.patch \
        file://0008-Added-support-imx219-camera.patch \
	file://0009-Added-TLV320AIC3C-and-w8960-codec-support.patch \
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

# u-boot
UBOOT_DTB_NAME = "lec-mtk-i1200-ufs.dtb"


# u-boot patches
EXTRA_UBOOT_PATCHES = " \
	file://lec_mtk_i1200_nor_defconfig \
	file://lec_mtk_i1200_nor_8mb_defconfig \
	file://lec_mtk_i1200_ufs_defconfig \	
	file://fw_env.config  \
	file://boot.script \
	file://fdt-env.cfg \
	file://boot.script.its \
	${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://secure-boot.cfg", "", d)} \
	file://fdt-env.cfg \
	file://boot.script.its \
	file://0001-Added-Board-support-for-LEC-MTK-i1200.patch \
	file://0002-Enable-Clock-for-Adlink-configuration.patch \
	file://0003-Added-interfacetest-environment-variable-to-list.patch \
	file://0005-Added-DSI-panel-support.patch \
	file://0006-Eth-power-support.patch \
"
EXTRA_UBOOT_8MB_PATCHES = " ${@bb.utils.contains("MACHINE_FEATURES", "8MB-NOR", " file://0002-Modify-Boot-assets-partition-offset.patch ", "", d)}  "	
EXTRA_UBOOT_PATCHES:append = " ${EXTRA_UBOOT_8MB_PATCHES} "			

EXTRA_UBOOT_DTS = " \
	file://lec-mtk-i1200-ufs.dts \
	file://mt8195.dtsi \
"
UBOOT_SRC_PATCHES = " \
        ${EXTRA_UBOOT_PATCHES} \
        ${EXTRA_UBOOT_DTS} \
"

LK_SRC_PATCHES = "${@bb.utils.contains("MACHINE_FEATURES", "8MB-NOR", " file://0001-Adding-8MB-nor-W25Q64JWXGIQ-support.patch ", "", d)}  "

BL2_SRC_PATCHES = "${@bb.utils.contains("MACHINE_FEATURES", "8MB-NOR", " file://0002-Modify-fip_a-fip_b-misc-partition-offset.patch ", "", d)} "




