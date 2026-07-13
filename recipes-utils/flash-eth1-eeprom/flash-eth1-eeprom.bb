SUMMARY = "Flash USB LAN7800 EEPROM script, start_test genio_520_720_standard_v4l2_camera_testcase_20250905 "
DESCRIPTION = "start_test for TSP test, genio_520_720_standard_v4l2_camera_testcase_20250905 for camera testing"
LICENSE = "CLOSED"

SRC_URI = "file://flash_eth1_eeprom.sh \
        file://genio_520_720_standard_v4l2_camera_testcase_20250905.sh \
        file://start_test.sh \
        file://EEPROM_7800.bin "
RDEPENDS:${PN} += "bash"

do_install() {
        install -d -m 0755 ${D}${ROOT_HOME}/tools
	install -m 755 ${WORKDIR}/flash_eth1_eeprom.sh ${D}${ROOT_HOME}/tools/flash_eth1_eeprom.sh
	install -m 755 ${WORKDIR}/EEPROM_7800.bin ${D}${ROOT_HOME}/tools/EEPROM_7800.bin
        install -m 755 ${WORKDIR}/genio_520_720_standard_v4l2_camera_testcase_20250905.sh ${D}${ROOT_HOME}/tools/genio_520_720_standard_v4l2_camera_testcase_20250905.sh
	install -m 755 ${WORKDIR}/start_test.sh ${D}${ROOT_HOME}/tools/start_test.sh
}


FILES:${PN} = " \
        ${ROOT_HOME}/tools/flash_eth1_eeprom.sh \
        ${ROOT_HOME}/tools/EEPROM_7800.bin \
        ${ROOT_HOME}/tools/genio_520_720_standard_v4l2_camera_testcase_20250905.sh \
        ${ROOT_HOME}/tools/start_test.sh \
"



