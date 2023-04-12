FILESEXTRAPATHS:prepend:lec-mtk-i1200-ufs:= "${THISDIR}/lec-mtk-i1200:"

SRC_URI:append:lec-mtk-i1200-ufs = " \
        file://audio-wm8960.dts \
        file://panel-boe-ne135fbm.dts \
        file://video.dts \
        file://display-dp.dts \
        file://display-dsi.dts \
        file://display-edp4k.dts \
        file://isp70.dtsi \
        file://camera-imx214-cam1.dts \
        file://camera-imx214-cam2.dts \
        file://camera-imx214-cam0.dts \
        file://mtk-camera.dtsi \
"

COMPATIBLE_MACHINE = "lec*"

