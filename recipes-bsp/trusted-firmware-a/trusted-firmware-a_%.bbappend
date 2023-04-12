FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRCBRANCH = "rity-kirkstone-v22.2"
SRC_URI = "git://git@github.com/ADLINK/mtk-lec-i1200_lib.git;protocol=ssh;branch=${SRCBRANCH};subpath=trusted-firmware-a"
SRCREV = "2v5"
SRCREV_tfa = "e3b5adde430250d2358954d428a656d3b804b158"


S = "${WORKDIR}/trusted-firmware-a"
