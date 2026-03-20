SUMMARY = "Tool to modify display settings by ddc (hdmi)"
HOMEPAGE = "http://www.ddcutil.com"
AUTHOR = "Sanford Rockowitz"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
BRANCH = "master"

SRCREV = "5080161b456cc6a1fd3e6db3dc537e1dcd1c809b"

PV = "1.2.2+${SRCREV}"

SRC_URI = " \
    git://github.com/rockowitz/ddcutil;branch=${BRANCH};protocol=https; \
"

# disable trying to fetch from mirrors
PREMIRRORS = ""
MIRRORS = ""

DEPENDS += " \
    i2c-tools \
    libusb1 \
    libdrm \
    libgudev \
"

RDEPENDS_${PN} += " \
    i2c-tools \
    i2c-tools-misc \
    libdrm \
"

S = "${WORKDIR}/git"

EXTRA_OECONF += " \
    --disable-x11 --enable-drm --disable-usb --enable-lib --disable-doxygen \
"

inherit autotools pkgconfig

