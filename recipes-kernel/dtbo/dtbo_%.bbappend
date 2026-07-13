FILESEXTRAPATHS:prepend:osm-520 := "${THISDIR}/osm-520:"

SRC_URI:remove:osm-520 = " \
	file://camera-common-std.dtsi \
	file://camera-imx258-csi0-std.dts \
	file://camera-imx258-csi1-std.dts \
	file://camera-imx258-dual-std.dts \
	file://camera-ov5640-csi0-std.dts \
	file://camera-ov5640-csi1-std.dts \
	file://camera-ov5640-dual-std.dts \
	file://camera-imx258-csi0-ov5640-csi1-std.dts \
	file://camera-gmsl-macro-def.dtsi \
	file://camera-gmsl-deserializer-channel.dtsi \
	file://camera-gmsl-serializer.dtsi \
	file://camera-gmsl-ag190h.dtsi \
	file://camera-ag190h-max96724-csi0-std.dts \
	file://camera-ag190h-max96724-csi1-std.dts \
	file://camera-ag190h-max96724-dual-std.dts \
	file://camera-it6625-csi1-std.dts \
	file://spi-test.dts \
	file://display-dsi.dts \
	file://display-edp-4k.dts \
	file://display-edp-fhd.dts \
	file://display-dp.dts \
"

OSM_520_DTBO_FILES = " \
	file://temp-er.dts \
	file://memory-4G.dts \
	file://memory-8G.dts \
	file://camera-common-std-osm520.dtsi \
	file://camera-imx258-csi0-ov5640-csi1-std-osm520.dts \
	file://camera-imx258-dual-std-osm520.dts \
	file://panel-dp.dts \
	file://panel-edp.dts \
	file://panel-dsi-b080uan01.dts \
	file://panel-lvds-g101eat026.dts \
	file://camera-ov5640-dual-std-osm520.dts \
"

SRC_URI:append:osm-520 = " ${OSM_520_DTBO_FILES}"

COMPATIBLE_MACHINE = "(osm-520.*)"
