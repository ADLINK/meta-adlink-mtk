#
# This file is the efuse writer recipe.
#

SUMMARY = "MTK efuse writer application"
LICENSE = "CLOSE"

SRC_URI = "file://ewriter.c \
       file://ewriter.h \
	   file://Makefile \
		  "

S = "${WORKDIR}"
do_compile (){
        oe_runmake
}

do_install() {
		mkdir -p ${D}/usr/bin
		install -m 0755 ewriter ${D}/usr/bin
}


