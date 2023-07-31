FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRCBRANCH = "rity-kirkstone-v22.2"
SRC_URI = "git://git@github.com/ADLINK/u-boot-mtk.git;protocol=ssh;branch=${SRCBRANCH}"
SRCREV = "2v8"

SRC_URI += " \
        file://0001-Revert-cmd-pxe_utils-Check-fdtcontroladdr-in-label_b.patch \
        file://fw_env.config \
        file://boot.script \
        ${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://secure-boot.cfg", "", d)} \
        file://fdt-env.cfg \
"


UBOOT_LOCALVERSION = "-adlink"
