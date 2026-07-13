do_install:append:osm-520 () {
	echo ${MACHINE} > ${D}${sysconfdir}/hostname
	echo "127.0.1.1 ${MACHINE}" >> ${D}${sysconfdir}/hosts
}

