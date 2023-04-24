FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRCBRANCH = "rity-kirkstone-v22.2"
SRC_URI = "git://git@github.com/ADLINK/linux-mtk.git;protocol=ssh;branch=${SRCBRANCH}"
SRCREV = "2v5"

SRC_URI:append:mt8195 = " \
    file://0003-WIP-GENIO-media-i2c-Modify-imx214-driver-to-support-.patch \
"

LINUX_VERSION_EXTENSION = "-lecmtki1200-2v5"

addtask copy_defconfig after do_kernel_configme before do_configure

do_copy_defconfig () {
	sed -i 's/\-mtk/\${LINUX_VERSION_EXTENSION}/g' ${S}/arch/arm64/configs/adlink_lec_i1200_ufs_defconfig
	cp ${S}/arch/arm64/configs/adlink_lec_i1200_ufs_defconfig ${B}/.config
	cp ${S}/arch/arm64/configs/adlink_lec_i1200_ufs_defconfig ${B}/../defconfig
}


