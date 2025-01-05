FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_install:append () {
	rm -f ${D}${systemd_system_unitdir}/usbmass.service
}

do_install:append () {
	install -m 0644 ${WORKDIR}/usbgadget.conf ${D}/etc/usbgadget.conf
}

