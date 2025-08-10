#
# This file is the eltt2 recipe.
#

SUMMARY = "Simple eltt2 application"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://eltt2.c \
       file://eltt2.h \
	   file://Makefile \
		  "

S = "${WORKDIR}"
do_compile (){
        oe_runmake
}

do_install() {
		mkdir -p ${D}/usr/bin
		install -m 0755 eltt2 ${D}/usr/bin
}


