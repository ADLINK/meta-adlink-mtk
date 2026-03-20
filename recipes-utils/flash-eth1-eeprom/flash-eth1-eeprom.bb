SUMMARY = "Flash USB LAN7800 EEPROM script"
LICENSE = "CLOSED"

SRC_URI = "file://flash_eth1_eeprom.sh \
	   file://EEPROM_7800.bin "
RDEPENDS:${PN} += "bash"

do_install() {
        install -d -m 0755 ${D}${ROOT_HOME}/tools
	install -m 755 ${WORKDIR}/flash_eth1_eeprom.sh ${D}${ROOT_HOME}/tools/flash_eth1_eeprom.sh
	install -m 755 ${WORKDIR}/EEPROM_7800.bin ${D}${ROOT_HOME}/tools/EEPROM_7800.bin
}


FILES:${PN} = " \
        ${ROOT_HOME}/tools/flash_eth1_eeprom.sh \
        ${ROOT_HOME}/tools/EEPROM_7800.bin \
"



