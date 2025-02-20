FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " ${KERNEL_SRC_PATCHES}"

LINUX_VERSION_EXTENSION:absolute-vision = "-absolute-vision-2v0.1.1"

do_configure:append() {
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
