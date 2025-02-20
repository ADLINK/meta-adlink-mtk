FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:absolute-vision = "file://0001-Create-absolute-vision-machine.patch \
            "
