FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRCBRANCH = "rity-kirkstone-v23.1"
SRC_URI = "git://git@github.com/ADLINK/mtk-lec-i1200_lib.git;protocol=ssh;branch=${SRCBRANCH};subpath=vpud"
SRCREV = "3v0"

S = "${WORKDIR}/vpud"

SRC_URI += " \
        file://vpud.service \
        file://vpud.sh \
"

