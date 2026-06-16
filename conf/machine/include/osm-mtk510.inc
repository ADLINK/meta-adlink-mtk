require conf/machine/include/arm/arch-armv8a.inc
require conf/machine/include/soc-family.inc
require mediatek-common.inc

SOC_FAMILY = "mt8370"

# Trusted Firmware-A
TFA_PLATFORM = "mt8188"

# OP-TEE
OPTEE_TARGET = "mediatek-mt8370"
OPTEE_DRAM_SIZE = "0x80000000"

# LK
LK_PROJECT = "mt8390-evk"

MACHINE_FEATURES:append = " optee"
MACHINE_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "nda-mtk", "optee-efuse", "", d)}"

DISTRO_FEATURES:remove = " x11 "

# Mali
MALI_SOC = "mt8188"
MALI_VERSION ??= "48"

MACHINE_EXTRA_RRECOMMENDS:append = " \
	${@bb.utils.contains_any('DISTRO_FEATURES', 'opengl vulkan', 'libmali', '', d)} \
	mali-gpu-driver \
	linux-firmware-mt8188-scp \
	linux-firmware-mt8188-sof \
	${@bb.utils.contains("MACHINE_FEATURES", "optee-efuse", "optee-ewriter", "", d)} \
"

PREFERRED_PROVIDER_virtual/egl ?= "libmali"
PREFERRED_PROVIDER_virtual/libegl ?= "libmali"
PREFERRED_PROVIDER_virtual/libgbm ?= "libmali"
PREFERRED_PROVIDER_virtual/libgl ?= "libmali"
PREFERRED_PROVIDER_virtual/libgles1 ?= "libmali"
PREFERRED_PROVIDER_virtual/libgles2 ?= "libmali"
PREFERRED_PROVIDER_virtual/libgles3 ?= "libmali"
PREFERRED_PROVIDER_virtual/mesa ?= "libmali"
PREFERRED_PROVIDER_virtual/opencl ?= "libmali"

MACHINEOVERRIDES =. "mt8370:genio-510:"
# Kernel
KERNEL_DEFCONFIG = "adlink_osm_mtk510_defconfig"
KERNEL_CONFIG_AARCH64 = "adlink_osm_mtk510_defconfig"
KERNEL_DEVICETREE = "mediatek/osm-mtk510.dtb"

# kernel patches
EXTRA_KERNEL_PATCHES = " \
        file://adlink_osm_mtk510_defconfig \
        file://0001-Add-ADLINKTECH-boards-support.patch \
        file://0002-Add-TPM-I2C-driver.patch \
        file://0004-init-HDMI-re-driver-at-HDMI-plug.patch \
        file://0005-Add-read-MAC-address-from-nvmem-support.patch \
        file://0007-Add-SKU-and-PCB-INFO.patch \
        file://0009-DP-direct-output-for-24.1-and-older.patch \
        file://0001-fsource-add-fsource-driver-to-enable-vefuse.patch \
        file://0003-Add-RTL8211F-LED-config.patch \
        file://OSM-510_CVE-2026-43284_xfrm-esp-fix-shared-skb-decrypt.patch \
        file://OSM-510_CVE-2026-43284_xfrm-esp-ipv4-fix-up-flags-setting.patch \
        file://0001-b080uan01-dsi-panel-DCS-init-sequence.patch \
"
EXTRA_KERNEL_DTS = " \
        file://osm-mtk510.dts \
        file://mt8370.dtsi \
"

KERNEL_SRC_PATCHES ="\
	${EXTRA_KERNEL_PATCHES} \
	${EXTRA_KERNEL_DTS} \
"
# U-Boot patches
EXTRA_UBOOT_PATCHES = " \
        file://0001-Create-osm-mtk510-machine.patch \
        file://0002-Implement-different-dtbo-for-SKU-and-PCB-detection.patch \
        file://0003-sd-card-dts-support.patch \
"

EXTRA_UBOOT_DTS = " \
        file://osm-mtk510.dts \
"

UBOOT_SRC_PATCHES = " \
        ${EXTRA_UBOOT_PATCHES} \
        ${EXTRA_UBOOT_DTS} \
"
