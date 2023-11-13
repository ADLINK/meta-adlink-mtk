SUMMARY = "Update ethernet MAC address script"
LICENSE = "CLOSED"

SRC_URI = "file://update_eth_mac.sh"
RDEPENDS:${PN} += "bash"

do_install() {
        install -d -m 0755 ${D}${ROOT_HOME}/tools
	install -m 755 ${WORKDIR}/update_eth_mac.sh ${D}${ROOT_HOME}/tools/update_eth_mac.sh
}


FILES:${PN} = " \
        ${ROOT_HOME}/tools/update_eth_mac.sh \
"



