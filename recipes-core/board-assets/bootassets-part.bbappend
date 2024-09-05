
SUMMARY += "Bootassets vfat to replace emmc sector size 512k with ufs sector size 4k"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " \
    file://logo.bmp \
"


do_deploy() {
	mkdir -p ${BOOTASSETS_IMAGE_FS}
	collect_artifacts

	BOOTASSETS_IMAGE="${WORKDIR}/bootassets.vfat"

	test -e $BOOTASSETS_IMAGE && rm -f $BOOTASSETS_IMAGE
	mkfs.vfat -n "bootassets" -S ${WIC_SECTOR_SIZE} -C $BOOTASSETS_IMAGE ${BLK_NUM}
	mcopy -i $BOOTASSETS_IMAGE -s ${WORKDIR}/bootassetsimage/* ::/
	cp $BOOTASSETS_IMAGE ${DEPLOYDIR}
}

