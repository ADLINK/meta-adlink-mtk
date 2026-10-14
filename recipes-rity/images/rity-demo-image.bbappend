require rity-image-adlink.inc

IMAGE_INSTALL:append:osm-mtk520 = " lmsensors modemmanager python3 python3-core python3-modules python3-misc"

#OSM-MTK510
IMAGE_INSTALL:append:osm-mtk510 = " lmsensors modemmanager python3 python3-core python3-modules python3-misc"

ADDON_FILES_DIR:="${THISDIR}/files"

install_fw() {
	mkdir -p ${IMAGE_ROOTFS}/lib/firmware/nxp
	cp ${ADDON_FILES_DIR}/pcieuart8997_combo_v4.bin ${IMAGE_ROOTFS}/lib/firmware/nxp/
	cp ${ADDON_FILES_DIR}/wifi_mod_para.conf ${IMAGE_ROOTFS}/lib/firmware/nxp/
}

modules_load() {
	mkdir -p ${IMAGE_ROOTFS}/etc/modprobe.d ${IMAGE_ROOTFS}/etc/modules-load.d
	cp ${ADDON_FILES_DIR}/adlink.conf ${IMAGE_ROOTFS}/etc/modprobe.d/adlink.conf
	cp ${ADDON_FILES_DIR}/moal.conf ${IMAGE_ROOTFS}/etc/modules-load.d/moal.conf
}

ROOTFS_POSTPROCESS_COMMAND:append:lec-mtk1200 = " install_fw; modules_load;"