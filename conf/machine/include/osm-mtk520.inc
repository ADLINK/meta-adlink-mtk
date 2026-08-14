SUMMARY = "Defines Kernel patches, device tree and defconfig macros for OSM-MTK520"

MACHINEOVERRIDES =. "osm-mtk520:"

# Kernel
KERNEL_DEFCONFIG = "osm_mtk520_defconfig"
KERNEL_DEVICETREE = "mediatek/osm-mtk520.dtb"

# kernel patches
EXTRA_KERNEL_PATCHES = " \
	file://osm_mtk520_defconfig \
	file://0001-Add-osm-mtk520-support.patch \
	file://0002-Enable-GPIO-control-node.patch \
	file://0003-Add-read-MAC-address-from-nvmem-support.patch \
	file://0007-Add-SKU-and-PCB-INFO.patch \
	file://0009-Modify-RTL8211F-LED-activity.patch \
	file://0010-Add-DP-direct-output-for-V25.1-kernel-6.6.92.patch \
	file://0013-modify-i2sout0-share-i2sin0-clock.patch \
	file://0014-mt8189-aic3107-set-codec-sysclk.patch \
	file://0015-tlv3107-mic.patch \
"

EXTRA_KERNEL_DTS = " \
	file://osm-mtk520-ufs.dts \
	file://osm-mtk520.dts \
	file://osm-mtk520-core.dts \
"

KERNEL_SRC_PATCHES = "\
	${EXTRA_KERNEL_PATCHES} \
	${EXTRA_KERNEL_DTS} \
"

# u-boot defconfigs
EXTRA_UBOOT_PATCHES = " \
	file://osm_mtk520_emmc_defconfig \
	file://osm_mtk520_ufs_defconfig \
	file://osm_mtk520_ufs_qspi_defconfig \
"

EXTRA_UBOOT_DTS = " \
	file://osm-mtk520-emmc.dts \
	file://osm-mtk520-ufs.dts \
	file://osm-mtk520-ufs-qspi.dts \
"

UBOOT_SRC_PATCHES = " \
	${EXTRA_UBOOT_PATCHES} \
	${EXTRA_UBOOT_DTS} \
"
