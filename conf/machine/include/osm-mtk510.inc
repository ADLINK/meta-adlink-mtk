require conf/machine/include/arm/arch-armv8a.inc
require conf/machine/include/soc-family.inc
require mediatek-common.inc

SOC_FAMILY = "mt8370"
SOC_SRAM_ADDR = "0x201000"

# Trusted Firmware-A
TFA_PLATFORM = "mt8188"

# OP-TEE
OPTEE_TARGET = "mediatek-mt8370"
OPTEE_DRAM_SIZE = "0x80000000"

# LK
LK_PROJECT = "mt8390-evk"

MACHINE_FEATURES:append = " optee"
MACHINE_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "nda-mtk", "optee-efuse", "", d)}"

# Mali
# Arm Mali GPU driver & graphics library provider

# By default, Rity images come with graphics support using the Mali DDK
# driver and libmali userspace library.
#
# To use Panfrost driver and Mesa, set the following values in your conf files.
# (local.conf, machine conf or distro conf):
# GPU_DRIVER = "panfrost"
# GPU_LIB = "mesa"
GPU_DRIVER ??= "mali-gpu-driver"
GPU_LIB ??= "libmali"

# If GPU_LIB is "libmali",
# each SoC needs to define MALI_SOC and MALI_VERSION (DDK version)
MALI_SOC ??= "mt8188"
MALI_VERSION ??= "48"

# Mali DDK does not support x11
DISTRO_FEATURES:remove = " x11 "

MACHINEOVERRIDES:append = ":mt7921:mt7925:"

MACHINE_EXTRA_RRECOMMENDS:append = "\
    ${@bb.utils.contains_any('DISTRO_FEATURES', 'opengl vulkan', '${GPU_LIB}', '', d)} \
    ${@bb.utils.contains_any('GPU_DRIVER', 'mali-gpu-driver', 'mali-gpu-driver', '', d)} \
    linux-firmware-mt8188-scp \
    linux-firmware-mt8188-sof \
    ${@bb.utils.contains("MACHINE_FEATURES", "optee-efuse", "optee-ewriter", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "wifi", "kernel-module-mt7921e linux-firmware-mt7961", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "wifi", "kernel-module-mt7925e linux-firmware-mt7925", "", d)} \
"

PREFERRED_PROVIDER_virtual/egl ?= "${GPU_LIB}"
PREFERRED_PROVIDER_virtual/libegl ?= "${GPU_LIB}"
PREFERRED_PROVIDER_virtual/libgbm ?= "${GPU_LIB}"
PREFERRED_PROVIDER_virtual/libgl ?= "${GPU_LIB}"
PREFERRED_PROVIDER_virtual/libgles1 ?= "${GPU_LIB}"
PREFERRED_PROVIDER_virtual/libgles2 ?= "${GPU_LIB}"
PREFERRED_PROVIDER_virtual/libgles3 ?= "${GPU_LIB}"
PREFERRED_PROVIDER_virtual/mesa ?= "${GPU_LIB}"
PREFERRED_PROVIDER_virtual/opencl ?= "${GPU_LIB}"


MACHINEOVERRIDES =. "mt8370:genio-510:"

# Kernel
KERNEL_DEFCONFIG = "adlink_osm_mtk510_defconfig"
KERNEL_CONFIG_AARCH64 = "adlink_osm_mtk510_defconfig"
KERNEL_DEVICETREE = "mediatek/osm-mtk510.dtb"

# kernel patches
EXTRA_KERNEL_PATCHES = " \
        file://adlink_osm_mtk510_defconfig \
	file://0001-Add-ADLINKTECH-boards-support.patch \
	file://0002-init-HDMI-re-driver-at-HDMI-plug.patch \
        file://0003-Add-RTL8211F-LED-config.patch \
        file://0004-Add-phy-dp83867-LED-setup.patch \
        file://0005-Add-read-MAC-address-from-nvmem-support.patch \
        file://0006-Add-fsource-driver-to-enable-vefuse.patch \
        file://0007-Add-SKU-and-PCB-INFO.patch \
        file://0008-Add-DP-direct-output-for-V25.1-kernel-6.6.92.patch \
        file://0009-b080uan01-dsi-panel-DCS-reboot-init-sequence.patch \
	file://0010-tlv3107-mic.patch \
        file://0011-mt8188-set-codec-sysclk.patch \
        file://0012-Setting-PWM_BL-stays-always-on-for-DSI.patch \
"
EXTRA_KERNEL_DTS = " \
        file://osm-mtk510.dts \
"

KERNEL_SRC_PATCHES ="\
	${EXTRA_KERNEL_PATCHES} \
	${EXTRA_KERNEL_DTS} \
"
# U-Boot defconfig
EXTRA_UBOOT_PATCHES = " \
	file://adlink_osm_mtk510_defconfig \
	file://0002-Implement-different-dtbo-for-SKU-and-PCB-detection.patch \
"

EXTRA_UBOOT_DTS = " \
        file://osm-mtk510.dts \
"

UBOOT_SRC_PATCHES = " \
        ${EXTRA_UBOOT_PATCHES} \
        ${EXTRA_UBOOT_DTS} \
"
