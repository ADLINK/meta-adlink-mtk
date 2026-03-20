SUMMARY = "Auto reboot service"
LICENSE = "CLOSED"

SRC_URI = "file://reboot-script.sh \
	   file://reboot-script.service"

inherit systemd
RDEPENDS:${PN} += "bash"

do_install() {
        install -d -m 0755 ${D}${ROOT_HOME}/tools
	install -m 755 ${WORKDIR}/reboot-script.sh ${D}${ROOT_HOME}/tools/reboot-script.sh

    # systemd
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/reboot-script.service ${D}${systemd_unitdir}/system
    fi

}


FILES:${PN} = " \
        ${ROOT_HOME}/tools/reboot-script.sh \
        ${sysconfdir}/systemd/system/multi-user.target.wants/reboot-script.service \
"

SYSTEMD_SERVICE:${PN} = "reboot-script.service"


