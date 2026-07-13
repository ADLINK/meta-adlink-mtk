SUMMARY = "Auto Resize service"
LICENSE = "CLOSED"

SRC_URI = "file://resize.sh \
	   file://resize.service"

inherit systemd
RDEPENDS:${PN} += "bash"

do_install() {
	install -d -m 0755 ${D}${ROOT_HOME}/tools
    install -m 755 ${WORKDIR}/resize.sh ${D}${ROOT_HOME}/tools/resize.sh

    # systemd
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/resize.service ${D}${systemd_unitdir}/system
    fi
}


FILES:${PN} = " \
        ${ROOT_HOME}/tools/resize.sh \
        ${sysconfdir}/systemd/system/multi-user.target.wants/resize.service \
"

SYSTEMD_SERVICE:${PN} = "resize.service"

