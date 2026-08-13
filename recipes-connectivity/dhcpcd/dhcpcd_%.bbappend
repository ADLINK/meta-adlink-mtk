FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:osm-mtk520 = " file://dhcpcd.conf"
SRC_URI:append:osm-mtk510 = " file://dhcpcd.conf"

do_install:append:osm-mtk520() {
    install -m 0644 ${WORKDIR}/dhcpcd.conf ${D}${sysconfdir}/dhcpcd.conf
}

do_install:append:osm-mtk510() {
    install -m 0644 ${WORKDIR}/dhcpcd.conf ${D}${sysconfdir}/dhcpcd.conf
}


SYSTEMD_AUTO_ENABLE:${PN}:osm-mtk520 = "disable"
SYSTEMD_AUTO_ENABLE:${PN}:osm-mtk510 = "disable"
