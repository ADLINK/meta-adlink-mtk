FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRCBRANCH = "rity-kirkstone-v23.1"
SRC_URI = "git://git@github.com/ADLINK/linux-mtk.git;protocol=ssh;branch=${SRCBRANCH}"
SRCREV = "3v1"

SRC_URI:append:lec-mtk-i1200-ufs = " \
        file://0001-GENIO-media-i2c-modify-imx214-to-support-extra-exten.patch \
        file://0002-HACK-GENIO-media-i2c-Replace-mbus_code-to-mtk_mbus_c.patch \
        file://0003-WIP-GENIO-media-i2c-Modify-imx214-driver-to-support-.patch \
        file://0004-display-port-over-dp-connector.patch \
"


LINUX_VERSION_EXTENSION = "-lecmtki1200-3v1"

addtask copy_defconfig after do_kernel_configme before do_configure

do_copy_defconfig () {
	sed -i 's/\-mtk/\${LINUX_VERSION_EXTENSION}/g' ${S}/arch/arm64/configs/adlink_lec_i1200_ufs_defconfig
	cp ${S}/arch/arm64/configs/adlink_lec_i1200_ufs_defconfig ${B}/.config
	cp ${S}/arch/arm64/configs/adlink_lec_i1200_ufs_defconfig ${B}/../defconfig
}


