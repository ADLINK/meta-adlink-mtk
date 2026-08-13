do_install:append:osm-mtk520 () {
	echo ${MACHINE} > ${D}${sysconfdir}/hostname
	echo "127.0.1.1 ${MACHINE}" >> ${D}${sysconfdir}/hosts
}

do_install:append:osm-mtk510 () {
        echo ${MACHINE} > ${D}${sysconfdir}/hostname
        echo "127.0.1.1 ${MACHINE}" >> ${D}${sysconfdir}/hosts
}

