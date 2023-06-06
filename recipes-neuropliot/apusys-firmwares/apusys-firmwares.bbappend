FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRCBRANCH = "rity-kirkstone-v22.2"
SRC_URI = "git://git@github.com/ADLINK/mtk-lec-i1200_lib.git;protocol=ssh;branch=${SRCBRANCH};subpath=mtk-apusys-firmware"
SRCREV:mt8195 = "2v7"

S = "${WORKDIR}/mtk-apusys-firmware"
