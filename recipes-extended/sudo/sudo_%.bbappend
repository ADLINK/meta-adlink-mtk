do_install:append:osm-mtk520() {
    echo "weston ALL=(ALL) NOPASSWD: ALL" >> ${D}${sysconfdir}/sudoers
}

do_install:append:osm-mtk510() {
    echo "weston ALL=(ALL) NOPASSWD: ALL" >> ${D}${sysconfdir}/sudoers
}

