FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:osm-520 = " file://dhcpcd.conf"

do_install:append:osm-520() {
    install -m 0644 ${WORKDIR}/dhcpcd.conf ${D}${sysconfdir}/dhcpcd.conf
}

SYSTEMD_AUTO_ENABLE:${PN}:osm-520 = "disable"
