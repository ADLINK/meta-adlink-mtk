FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

BUILD = "${WORKDIR}/lk/build-${LK_PROJECT}"
SRCBRANCH = "rity-kirkstone-v22.2"
SRC_URI = "git://git@github.com/ADLINK/mtk-lec-i1200_lib.git;protocol=ssh;branch=${SRCBRANCH};subpath=lk"
SRCREV = "2v5"

S = "${WORKDIR}/lk"
