FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRCBRANCH = "rity-kirkstone-v23.1"
SRC_URI = "git://git@github.com/ADLINK/mtk-lec-i1200_lib.git;protocol=ssh;branch=${SRCBRANCH};subpath=optee-os"
SRCREV = "d50b90b62f8b89cf567842252b749c36b1475165"

S = "${WORKDIR}/optee-os"
