FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_install:append:genio-1200-evk() {
	rm -f ${D}${systemd_system_unitdir}/usbmass.service
}

do_install:append:genio-1200-evk() {
	install -m 0644 ${WORKDIR}/usbgadget.conf ${D}/etc/usbgadget.conf
}

