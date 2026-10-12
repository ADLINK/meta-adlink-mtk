SUMMARY = "USB OTG Host mode switch"
LICENSE = "CLOSED"

SRC_URI = "file://setup-acm.sh \
           file://setup-acm.service \
"

RDEPENDS:${PN} += "bash"

inherit systemd

SYSTEMD_SERVICE:${PN} = "setup-acm.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
    install -d ${D}${systemd_unitdir}/system

    install -m 0644 ${WORKDIR}/setup-acm.service ${D}${systemd_unitdir}/system/
    install -m 0755 ${WORKDIR}/setup-acm.sh ${D}${systemd_unitdir}
}

FILES:${PN} = " \
	    ${systemd_unitdir}/system/setup-acm.service \
    	    ${systemd_unitdir}/setup-acm.sh \
"

