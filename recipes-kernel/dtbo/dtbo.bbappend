FILESEXTRAPATHS:prepend:absolute-vision := "${THISDIR}/absolute-vision:"

SRC_URI:remove = " \
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
        file://isp71.dtsi \
        file://mtk-camera.dtsi \
        file://camera-common.dtsi \
        file://camera-imx214-csi0.dts \
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
"


#SRC_URI:append = " \
#        file://memory-2G.dts \
#        file://memory-4G.dts \
#        file://memory-8G.dts \
#        file://audio-wm8960.dts \
#        file://panel-boe-ne135fbm.dts \
#        file://panel-auo-g156han03.dts \
#        file://display-dp.dts \
#        file://display-dsi.dts \
#        file://display-edp4k.dts \
#        file://isp70.dtsi \
#        file://mtk-camera.dtsi \
#        file://camera-imx214-cam0.dts \
#        file://camera-imx214-cam1.dts \
#        file://camera-imx214-cam2.dts \
#"

COMPATIBLE_MACHINE = "absolute-vision"

