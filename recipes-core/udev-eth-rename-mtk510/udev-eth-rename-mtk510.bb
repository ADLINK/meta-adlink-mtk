SUMMARY = "Deterministic systemd network link configuration for OSM-MTK510"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://10-onboard.link \
    file://20-usb.link \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/systemd/network
    
    # Install custom link files
    install -m 0644 ${WORKDIR}/10-onboard.link ${D}${sysconfdir}/systemd/network/
    install -m 0644 ${WORKDIR}/20-usb.link ${D}${sysconfdir}/systemd/network/
    
    # Mask systemd's default link policy to prevent naming conflicts
    ln -s /dev/null ${D}${sysconfdir}/systemd/network/99-default.link
}

FILES:${PN} = "${sysconfdir}/systemd/network/*"
