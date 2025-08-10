
SUMMARY += "Firmware vfat to Replace emmc sector size 512k with ufs sector size 4k"

do_deploy() {
	#
	# Step 1: Populate firmware directory structure
	#
	mkdir -p ${FW_IMAGE_FS}

	#
	# Step 2: Copy firmware files
	#
	collect_artifacts

	#
	# Step 3: Create fs image
	#
	FW_IMAGE="${WORKDIR}/firmware.vfat"

	test -e $FW_IMAGE && rm -f $FW_IMAGE
	mkfs.vfat -n "firmware" -S ${WIC_SECTOR_SIZE} -C $FW_IMAGE ${BLK_NUM}
	mcopy -i $FW_IMAGE -s ${WORKDIR}/fwimage/* ::/
	cp $FW_IMAGE ${DEPLOYDIR}
}

