FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRCBRANCH = "rity-kirkstone-v23.1"
SRC_URI = "git://git@github.com/ADLINK/mtk-lec-i1200_lib.git;protocol=ssh;branch=${SRCBRANCH};subpath=mtk-neuropilot-prebuilts"
SRCREV = "3v1"

S = "${WORKDIR}/mtk-neuropilot-prebuilts"
