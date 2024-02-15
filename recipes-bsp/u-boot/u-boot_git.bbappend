FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRCBRANCH = "rity-kirkstone-v23.1"
SRC_URI = "git://git@github.com/ADLINK/u-boot-mtk.git;protocol=ssh;branch=${SRCBRANCH}"
SRCREV = "3v1"

SRC_URI += " \
        file://0001-Revert-cmd-pxe_utils-Check-fdtcontroladdr-in-label_b.patch \
        file://fw_env.config \
        file://boot.script \
        ${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://secure-boot.cfg", "", d)} \
        file://fdt-env.cfg \
        file://0001-cmd-Add-new-command-to-source-embedded-script.patch \
        file://0001-cmd-Add-new-command-dtbprobe.patch \
        file://boot.script.its \
        ${@bb.utils.contains("AB_FWUPDATE_ENABLE", "1", "file://ab-fwupdate.cfg", "", d)} \
        ${@bb.utils.contains("AB_FWUPDATE_ENABLE", "1", "file://0001-GENIO-board-mediatek-add-AB-firmware-updates-support.patch", "", d)} \
        ${@bb.utils.contains("DISTRO_FEATURES", "fwupdate", "file://secure-cap.dts", "", d)} \
        ${@bb.utils.contains("DISTRO_FEATURES", "fwupdate", "file://u-boot-cap.key", "", d)} \
        ${@bb.utils.contains("DISTRO_FEATURES", "fwupdate", "file://u-boot-cap.crt", "", d)} \
        ${@bb.utils.contains("DISTRO_FEATURES", "fwupdate", "file://u-boot-cap", "", d)} \
"

UBOOT_LOCALVERSION = "-adlink"
