ADDON_FILES_DIR:="${THISDIR}/files"

#Adlinktech package
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

configure_weston_service() {
    mkdir -p ${IMAGE_ROOTFS}/etc/systemd/system/weston.service.d
    cp ${ADDON_FILES_DIR}/weston.service.d/override.conf ${IMAGE_ROOTFS}/etc/systemd/system/weston.service.d/override.conf
}

ROOTFS_POSTPROCESS_COMMAND += "install_fw; modules_load; configure_weston_service;"


