ADDON_FILES_DIR:="${THISDIR}/files"


require rity-image-adlink.inc

install_fw() {
	mkdir -p ${IMAGE_ROOTFS}/lib/firmware/nxp
	cp ${ADDON_FILES_DIR}/pcieuart8997_combo_v4.bin ${IMAGE_ROOTFS}/lib/firmware/nxp/
	cp ${ADDON_FILES_DIR}/wifi_mod_para.conf ${IMAGE_ROOTFS}/lib/firmware/nxp/
}

modules_load() {
	cp ${ADDON_FILES_DIR}/adlink.conf ${IMAGE_ROOTFS}/etc/modprobe.d/adlink.conf
	cp ${ADDON_FILES_DIR}/moal.conf ${IMAGE_ROOTFS}/etc/modules-load.d/moal.conf
}
ROOTFS_POSTPROCESS_COMMAND += "install_fw; modules_load;"


