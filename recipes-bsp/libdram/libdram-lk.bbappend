FILESEXTRAPATHS:prepend:osm-mtk520 := "${THISDIR}/files:"

SRC_URI:append:osm-mtk520 = " ${@bb.utils.contains('DISTRO_FEATURES', 'fixddrfreq', 'file://0001-fix-dram-freq.patch', '', d)}"
