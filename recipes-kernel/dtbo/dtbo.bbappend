FILESEXTRAPATHS:prepend := "${THISDIR}/lec-mtk-i1200:"
FILESEXTRAPATHS:prepend:osm-mtk510 := "${THISDIR}/osm-mtk510:"

SRC_URI:remove:lec-mtk1200 = " \
	file://panel-raspberrypi.dtsi \
        file://display-edp.dts \
        file://display-edp2lvds.dts \
        file://display-hdmi.dts \
        file://display-dsiedp.dts \
        file://display-dsilvds.dts \
        file://display-dsidp.dts \
        file://display-edphdmi.dts \
        file://display-edpdp.dts \
        file://display-lvdshdmi.dts \
        file://display-lvdsdp.dts \
        file://display-hdmidp.dts \
        file://display-dsiedphdmi.dts \
        file://display-dsiedpdp.dts \
        file://display-dsilvdshdmi.dts \
        file://display-dsilvdsdp.dts \
        file://display-dsihdmidp.dts \
        file://display-edphdmidp.dts \
        file://display-lvdshdmidp.dts \
        file://display-headless.dts \
        file://camera-imx214-csi0.dts \
        file://camera-imx214-csi1.dts \
        file://camera-imx214-csi2.dts \
        file://camera-imx214-2lanes-csi0.dts \
        file://camera-ar0430-ap1302-csi0.dts \
        file://camera-ar0430-ap1302-csi1.dts \
        file://camera-ar0430-ap1302-csi2.dts \
        file://camera-ar0830-ap1302-csi0.dts \
        file://camera-ar0830-ap1302-csi1.dts \
        file://camera-ar0830-ap1302-csi2.dts \
        file://camera-ar0830-ap1302-2lanes-csi0.dts \
	file://camera-ar0830-ap1302-csi0-ar0830-ap1302-csi2.dts \
	file://camera-ar0430-ap1302-csi0-std.dts\
	file://camera-ar0830-ap1302-csi0-std.dts\
	file://camera-it6510-csi0-std.dts \
	file://camera-lt6911uxe-csi0-std.dts \
	file://camera-ag190c-max9286-csi0-std.dts \
	file://camera-imx214-csi0-ar0830-ap1302-csi1-ar0830-ap1302-csi2.dts \
	file://camera-imx214-csi0-ar0830-ap1302-csi1.dts \
	file://camera-imx214-csi0-ar0830-ap1302-csi1-imx214-csi2.dts \
	file://camera-imx214-csi0-ar0830-ap1302-csi1-ar0830-ap1302-csi2.dts \
	file://camera-imx214-csi0-ar0830-ap1302-csi2.dts \	
"
SRC_URI:remove:osm-mtk510 = " \
        file://display-dsi.dts \
        file://display-dsi2lvds.dts \
        file://display-edp.dts \
        file://display-hdmi.dts \
        file://display-dp.dts \
        file://display-dsiedp.dts \
        file://display-dsidp.dts \
        file://display-lvdsedp.dts \
        file://display-lvdshdmi.dts \
        file://display-lvdsdp.dts \
        file://display-edpdp.dts \
        file://display-edphdmi.dts \
        file://display-hdmidp.dts \
        file://display-headless.dts \
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
        file://audio-sof.dts \
        file://camera-imx214-csi0-std.dts \
        file://camera-imx214-csi1-std.dts \"


SRC_URI:append:lec-mtk1200 = " \
        file://memory-2G.dts \
        file://memory-4G.dts \
        file://memory-8G.dts \
        file://audio-wm8960.dts \
        file://panel-boe-ne135fbm.dts \
        file://panel-auo-g156han03.dts \
        file://display-dp.dts \
        file://display-dsi.dts \
        file://display-edp4k.dts \
        file://isp70.dtsi \
        file://mtk-camera.dtsi \
        file://camera-imx214-cam0.dts \
        file://camera-imx214-cam1.dts \
        file://camera-imx214-cam2.dts \
"

SRC_URI:append:lec-mtk-i1200-qspi = "\ 
	file://nor-qspi.dts \
"
SRC_URI:append:osm-mtk510 = " \
        file://memory-2G.dts \
        file://memory-4G.dts \
        file://memory-8G.dts \
        file://temp-er.dts \
        file://panel-dphdmi.dts \
        file://video.dts \
        file://gpu-mali.dts \
        file://apusys.dts \
        file://cam-imx214-csi0.dts \
"

COMPATIBLE_MACHINE = "(osm-mtk510|lec*)"
