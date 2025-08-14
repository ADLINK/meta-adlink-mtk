FILESEXTRAPATHS:prepend:lec-mtk1200 := "${THISDIR}/files:"

do_install:append:lec-mtk1200 () {
	rm -f ${D}${systemd_system_unitdir}/usbmass.service
}

do_install:append:lec-mtk1200 () {
	install -m 0644 ${WORKDIR}/usbgadget.conf ${D}/etc/usbgadget.conf
}

