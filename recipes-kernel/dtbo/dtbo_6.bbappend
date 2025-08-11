FILESEXTRAPATHS:prepend := "${THISDIR}/lec-mtk-i1200:"

SRC_URI:remove = " \
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


SRC_URI:append = " \
        file://memory-2G.dts \
        file://memory-4G.dts \
        file://memory-8G.dts \
        file://audio-wm8960.dts \
        file://panel-boe-ne135fbm.dts \
        file://panel-auo-g156han03.dts \
        file://display-dp.dts \
        file://display-dsi.dts \
        file://display-edp4k.dts \
	file://gpu-mali.dts \
        file://isp70.dtsi \
        file://mtk-camera.dtsi \
	file://camera-imx214-cam0.dts \
	file://camera-imx214-cam1.dts \
	file://camera-imx214-cam2.dts \
	file://display-hdmi.dts \
"

COMPATIBLE_MACHINE = "lec*"

