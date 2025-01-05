
SUMMARY += "Bootassets vfat to replace emmc sector size 512k with ufs sector size 4k"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " \
    file://logo.bmp \
"


do_deploy:nor-boot() {
	cp ${WORKDIR}/logo.bmp ${DEPLOYDIR}/bootassets.img
}

