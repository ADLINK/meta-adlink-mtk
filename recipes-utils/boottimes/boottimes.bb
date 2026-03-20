SUMMARY = "Boot times counter service"
LICENSE = "CLOSED"

SRC_URI = "file://boottimes.sh \
	   file://boottimes.service"

inherit systemd
RDEPENDS:${PN} += "bash"

do_install() {
        install -d -m 0755 ${D}${ROOT_HOME}/tools
	install -m 755 ${WORKDIR}/boottimes.sh ${D}${ROOT_HOME}/tools/boottimes.sh

    # systemd
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/boottimes.service ${D}${systemd_unitdir}/system
    fi

}


FILES:${PN} = " \
        ${ROOT_HOME}/tools/boottimes.sh \
        ${sysconfdir}/systemd/system/multi-user.target.wants/boottimes.service \
"

SYSTEMD_SERVICE:${PN} = "boottimes.service"


