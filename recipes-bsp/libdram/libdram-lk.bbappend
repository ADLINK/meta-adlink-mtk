FILESEXTRAPATHS:prepend:osm-520 := "${THISDIR}/files:"

SRC_URI:append:osm-520 = " ${@bb.utils.contains('DISTRO_FEATURES', 'fixddrfreq', 'file://0001-fix-dram-freq.patch', '', d)}"
