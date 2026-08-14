MACHINEOVERRIDES =. "mt7921:"

MACHINE_EXTRA_RRECOMMENDS:append = " \
	${@bb.utils.contains("DISTRO_FEATURES", "wifi", "kernel-module-mt7921e linux-firmware-mt7961", "", d)} \
"
