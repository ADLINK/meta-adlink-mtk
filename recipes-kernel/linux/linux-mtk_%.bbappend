FILESEXTRAPATHS:prepend:absolute-vision := "${THISDIR}/${PN}/absolute-vision:"
FILESEXTRAPATHS:prepend:lec-mtk1200 := "${THISDIR}/${PN}/lec-mtk1200:"

SRC_URI:append = " ${KERNEL_SRC_PATCHES}"

LINUX_VERSION_EXTENSION:absolute-vision = "-absolute-vision-4v0.0.0"


do_copy_source () {
  dtbes=$(echo "${KERNEL_DEVICETREE}" | xargs)
  extras=$(echo "${KERNEL_SRC_PATCHES}" | xargs)
	

# copy dts, dtso and dtsi
  if [ -n "${extras}" -a -n "${dtbes}" ]; then
    if [ ! -d ${S}/arch/arm64/boot/dts/mediatek ]; then
      bbnote "create ${S}/arch/arm64/boot/dts/mediatek/ directory"
      mkdir -p ${S}/arch/arm64/boot/dts/mediatek/
      if [ -f ${S}/arch/arm64/boot/dts/Makefile ]; then
        if ! grep -q "subdir-y.*mediatek" ${S}/arch/arm64/boot/dts/Makefile; then
          bbnote "Makefile: modify to build ${S}/arch/arm64/boot/dts/mediatek/ directory"
	      echo "subdir-y += mediatek" >> ${S}/arch/arm64/boot/dts/Makefile
	    else
	      bbnote "Makefile: Already building ${S}/arch/arm64/boot/dts/mediatek/ directory"
	    fi
	  fi
    fi
    for extra in ${extras}; do
      extrafile=$(basename -- ${extra})
      extraname=$(echo ${extrafile%%.*})
      if [ -f ${WORKDIR}//${extrafile} ]; then
        case ${extrafile} in
        *.dtsi)
          bbnote "copy kernel dtsi: ${extrafile}"  
          cp -f ${WORKDIR}//${extrafile} ${S}/arch/arm64/boot/dts/mediatek/
          ;;
        *.dtso)
          for dtb in ${dtbes}; do if [ "$dtb" = *"${extraname}"* ]; then dtbname=$(basename ${dtb}) else dtbname=""; fi; done
          if [ -n ${dtbname} ]; then
            bbnote "copy kernel dtso: ${extrafile}"
            cp -f ${WORKDIR}//${extrafile} ${S}/arch/arm64/boot/dts/mediatek/
            if ! grep -q ${extraname} ${S}/arch/arm64/boot/dts/mediatek/Makefile; then
              bbnote "Makefile: add ${extraname}.dtbo"
              echo "dtb-\$(CONFIG_ARCH_ADLINK) += ${extraname}.dtbo" >> ${S}/arch/arm64/boot/dts/mediatek/Makefile
            fi
          fi
          ;;
        *.dts)
          for dtb in ${dtbes}; do if [ "$dtb" = *"${extraname}"* ]; then dtbname=$(basename ${dtb}) else dtbname=""; fi; done
          if [ -n ${dtbname} ]; then
            bbnote "copy kernel dts: ${extrafile} for ${dtbname}"
            cp -f ${WORKDIR}//${extrafile} ${S}/arch/arm64/boot/dts/mediatek/
            if ! grep -q ${extraname} ${S}/arch/arm64/boot/dts/mediatek/Makefile; then
              bbnote "Makefile: add ${extraname}.dtb"
              echo "dtb-\$(CONFIG_ARCH_ADLINK) += ${extraname}.dtb" >> ${S}/arch/arm64/boot/dts/mediatek/Makefile
            fi
          fi
          ;;
        esac
      fi
    done
  fi
}


addtask do_copy_source after do_kernel_configme before do_configure


do_copy_defconfig () {

  configs=$(echo "${KERNEL_CONFIG_AARCH64}" | xargs)
  deltaconfigs=$(echo "${DELTA_KERNEL_DEFCONFIG}" | xargs)
  
  # Copy main kernel build config
  if [ -n "${configs}" ]; then
    for config in ${configs}; do
      if [ -f ${WORKDIR}//${config} -a ! -f ${S}/arch/arm64/configs/${config} ]; then
        bbnote "copy kernel build config: $config to ${S}/arch/arm64/configs/${config}"
        cp -f ${WORKDIR}//${config} ${S}/arch/arm64/configs/${config}

      fi
    done
  fi

  if [ -n "${deltaconfigs}" ]; then
    for deltacfg in ${deltaconfigs}; do
      if [ -f ${WORKDIR}//${deltacfg} -a ! -f ${S}/arch/${ARCH}/configs/${deltacfg} ]; then
        bbnote "copy kernel delta config: $deltacfg to ${S}/arch/arm64/configs/${deltacfg}"
        cp -f ${WORKDIR}//${deltacfg} ${S}/arch/arm64/configs/${deltacfg}
      fi
    done
  fi

  sed -i 's/\-mtk/\${LINUX_VERSION_EXTENSION}/g' ${S}/arch/arm64/configs/${KERNEL_CONFIG_AARCH64}
  cp ${S}/arch/arm64/configs/${KERNEL_CONFIG_AARCH64} ${B}/.config
  cp ${S}/arch/arm64/configs/${KERNEL_CONFIG_AARCH64} ${B}/../defconfig

}

python () {
    if d.getVar('MACHINE') != 'absolute-vision':
        bb.build.addtask('do_copy_defconfig', 'do_configure', 'do_copy_source', d)

    if d.getVar('MACHINE') == 'absolute-vision':
        bb.build.addtask('do_copy_defconfig', 'do_kernel_configme', 'do_patch', d)
}

