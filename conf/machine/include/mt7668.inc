MTK_WIRELESS_RELEASE ?= "alps-release-r0.mp5-aiot"
MTK_WIRELESS_CHIP = "MT7668"
MACHINEOVERRIDES =. "mt7668:"

MACHINE_EXTRA_RRECOMMENDS:append = " \
	${@bb.utils.contains("DISTRO_FEATURES", "nda-mtk wifi", "kernel-module-mt7668-tk-wifi", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "bluetooth", "linux-firmware-mt7668", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "nda-mtk", "wifitest", "", d)} \
"
