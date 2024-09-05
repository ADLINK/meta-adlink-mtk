FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " ${UBOOT_SRC_PATCHES}"

do_copy_source () {
  configs=$(echo "${UBOOT_MACHINE}" | xargs)
  dtbes=$(echo "${UBOOT_DTB_NAME}" | xargs)
  srces=$(echo "${UBOOT_SRC_PATCHES}" | xargs)
  bbnote "u-boot dtbes: ${dtbes}, srces: ${srces}"

  # Copy config and dts
  for config in ${configs}; do
    if [ -f ${WORKDIR}/${config} ]; then
      bbnote "copy u-boot config: ${config} to ${S}/configs/"
      cp -f ${WORKDIR}/${config} ${S}/configs/
    fi
  done
  for dtbname in ${dtbes}; do
    dtsname=$(echo "${dtbname%%.*}.dts")
    if [ -f ${WORKDIR}/${dtsname} ]; then
      bbnote "copy u-boot dts: ${dtsname} to ${S}/arch/arm/dts/"
      cp -f ${WORKDIR}/${dtsname} ${S}/arch/arm/dts/
      if ! grep -q ${dtbname} ${S}/arch/arm/dts/Makefile; then
        bbnote "modify ${S}/arch/arm/dts/Makefile: add ${dtbname}"
        sed -e 's,dtb-$(CONFIG_ARCH_MEDIATEK) += \\,dtb-$(CONFIG_ARCH_MEDIATEK) += \\\n\t'${dtbname}' \\,g' -i ${S}/arch/arm/dts/Makefile
      fi
    fi
  done
  for src in ${srces}; do
    srcfile=$(basename -- ${src} | xargs)
    case "${srcfile}" in
    *.dtsi)
      if [ -f ${WORKDIR}/${srcfile} ]; then
        bbnote "copy u-boot dtsi: ${srcfile} to ${S}/arch/arm/dts/"
        cp -f ${WORKDIR}/${srcfile} ${S}/arch/arm/dts/
      fi
      ;;
    esac
  done
}

addtask do_copy_source before do_patch after do_unpack



UBOOT_LOCALVERSION = "-adlink"

