do_install:append:osm-520() {
    echo "weston ALL=(ALL) NOPASSWD: ALL" >> ${D}${sysconfdir}/sudoers
}
