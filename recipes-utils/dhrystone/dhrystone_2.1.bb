SUMMARY = "Dhrystone benchmark"
DESCRIPTION = "CPU integer performance benchmark (Dhrystone 2.1)"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://dhry21a.c \
       file://dhry21b.c \
       file://timers.c \
       file://dhry.h \
	   file://Makefile \
		  "

S = "${WORKDIR}"
do_compile() {
    oe_runmake
}

do_install() {
		mkdir -p ${D}/usr/bin
		install -m 0755 dhrystone ${D}/usr/bin
}




