FILESEXTRAPATHS:prepend:osm-520 := "${THISDIR}/${PN}/osm-520:"

SRC_URI:append = " ${KERNEL_SRC_PATCHES}"

OSM_KERNEL_COMMON_VER = "1v0.0.7"
LINUX_VERSION_EXTENSION:osm-520-ufs = "-osm-520-ufs-${OSM_KERNEL_COMMON_VER}"
LINUX_VERSION_EXTENSION:osm-520-emmc = "-osm-520-emmc-${OSM_KERNEL_COMMON_VER}"
LINUX_VERSION_EXTENSION:osm-520-norboot-ufs = "-osm-520-${OSM_KERNEL_COMMON_VER}"


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

# OSM-520 handles its defconfig and device trees here instead of the
# do_copy_* tasks above (see the anonymous python below).
do_configure:append:osm-520() {
	# Handle kernel configuration files.
	if [ -n "${KERNEL_DEFCONFIG}" ]; then
		config_file="${WORKDIR}/${KERNEL_DEFCONFIG}"
		target_config="${S}/arch/arm64/configs/${KERNEL_DEFCONFIG}"

		if [ -f "${config_file}" ]; then
			bbnote "Copying kernel defconfig: ${KERNEL_DEFCONFIG} to ${target_config}"
			cp -f "${config_file}" "${target_config}"
			sed -i 's/\-mtk/\${LINUX_VERSION_EXTENSION}/g' ${target_config}
			cp ${S}/arch/arm64/configs/${KERNEL_DEFCONFIG} ${B}/.config
		fi
	fi

	# Handle additional device tree files
	dtb_dir="${S}/arch/arm64/boot/dts/mediatek"
	dtb_makefile="${dtb_dir}/Makefile"

	# Copy additional device tree source files.
	for extra_dts in ${EXTRA_KERNEL_DTS}; do
		dts_file=$(basename ${extra_dts})
		if [ -f "${WORKDIR}/${dts_file}" ]; then
		    bbnote "Copying ${dts_file} to ${dtb_dir}/"
		    cp -f "${WORKDIR}/${dts_file}" "${dtb_dir}/"
		fi
	done

	# Update the Makefile to add new device tree compilation targets.
	for extra_dts in ${EXTRA_KERNEL_DTS}; do
		dts_file=$(basename ${extra_dts})
		file_ext="${dts_file##*.}"
		base_name="${dts_file%%.*}"

		if [ "${file_ext}" = "dts" ]; then
			dtb_file="${base_name}.dtb"
			if ! grep -q "${dtb_file}" "${dtb_makefile}"; then
				bbnote "Adding ${dtb_file} to ${dtb_makefile}"
				echo "dtb-\$(CONFIG_ARCH_ADLINKTECH) += ${dtb_file}" >> "${dtb_makefile}"
			fi
		fi
	done
}

python () {
    machine = d.getVar('MACHINE') or ''

    if machine.startswith('osm-520'):
        # OSM-520 copies its defconfig and device trees in
        # do_configure:append:osm-520; drop do_copy_source so the dts
        # Makefile is not also rewritten with CONFIG_ARCH_ADLINK entries.
        bb.build.deltask('do_copy_source', d)
}
