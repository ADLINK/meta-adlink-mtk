FILESEXTRAPATHS:prepend:osm-mtk520 := "${THISDIR}/osm-mtk520:"
FILESEXTRAPATHS:prepend:osm-mtk510 := "${THISDIR}/osm-mtk510:"

SRC_URI:remove:osm-mtk520 = " \
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
SRC_URI:remove:osm-mtk510 = " \
        file://camera-imx214-csi1.dts \
        file://camera-imx214-2lanes-csi0.dts \
        file://camera-ar0430-ap1302-csi0.dts \
        file://camera-ar0430-ap1302-csi1.dts \
        file://camera-ar0830-ap1302-csi0.dts \
        file://camera-ar0830-ap1302-csi1.dts \
        file://camera-ar0830-ap1302-2lanes-csi0.dts \
        file://camera-imx214-csi0-imx214-csi1.dts \
        file://camera-imx214-csi0-ar0830-ap1302-csi1.dts \
        file://camera-ar0830-ap1302-csi0-imx214-csi1.dts \
        file://camera-ar0830-ap1302-csi0-ar0830-ap1302-csi1.dts \
        file://camera-ar0430-ap1302-csi0-std.dts \
        file://camera-ar0830-ap1302-csi0-std.dts \
        file://camera-it6510-csi0-std.dts \
        file://camera-ar0830-ap1302-dual-std.dts \
        file://camera-it6510-dual-std.dts \
        file://camera-ar0830-ap1302-csi0-it6510-csi1-std.dts \
        file://camera-lt6911uxe-csi0-std.dts \
        file://camera-lt6911uxe-dual-std.dts \
        file://camera-ag190c-max9286-csi0-std.dts \
        file://camera-ag190c-max9286-dual-std.dts \
        file://camera-imx214-csi0-std.dts \
        file://camera-imx214-csi1-std.dts \
"

OSM_MTK520_DTBO_FILES = " \
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

OSM_MTK510_DTBO_FILES = " \
        file://memory-2G.dts \
        file://memory-4G.dts \
        file://memory-8G.dts \
        file://temp-er.dts \
        file://video.dts \
        file://apusys.dts \
        file://panel-dsi-b080uan01.dts \
"

SRC_URI:append:osm-mtk520 = " ${OSM_MTK520_DTBO_FILES}"
SRC_URI:append:osm-mtk510 = " ${OSM_MTK510_DTBO_FILES}"

COMPATIBLE_MACHINE = "(osm-mtk510|osm-mtk520.*)"
