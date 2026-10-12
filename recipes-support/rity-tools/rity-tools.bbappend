# ADLINK LEC-MTK-i1200 8MB-NOR: keep BSP 25.0 NOR flash behaviour.
#
# BSP 25.1 upstream rity_nor.json flashes UBI firmware to nor_firmware_a/b.
# On the 8MB-NOR layout these are 256 KiB, too small for UBI. BSP 25.0 never
# flashed them (DTB/DTBOs come from the FIT image), so for 8MB-NOR set them to
# null and drop them from the "all" flash group in the deployed rity.json.
# Default (32MB) NOR keeps upstream rity_nor.json unchanged.

do_deploy:append:nor-boot() {
	if ${@bb.utils.contains('MACHINE_FEATURES', '8MB-NOR', 'true', 'false', d)}; then
		J=${DEPLOYDIR}/rity.json

		sed -i \
			-e 's#"nor_firmware_a": *"[^"]*"#"nor_firmware_a": null#' \
			-e 's#"nor_firmware_b": *"[^"]*"#"nor_firmware_b": null#' \
			-e '/^ *"nor_firmware_a", *"nor_firmware_b", *$/d' \
			$J

		# Fail loudly if the upstream file format changes and the edit no longer matches
		if ! grep -q '"nor_firmware_a": null' $J || \
		   ! grep -q '"nor_firmware_b": null' $J || \
		   grep -q '"nor_firmware_[ab]",' $J; then
			bbfatal "rity.json: could not disable nor_firmware_a/b for 8MB-NOR; check upstream rity_nor.json format"
		fi
	fi
}
