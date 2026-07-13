#!/bin/bash

# Genio 520/720 Camera Test

## Environment Setup

# +---------------+--------+--------+-----------------------------------------+---------------------------------------------------------------------------------------------------------------------------+
# | Genio EVK     | CSI0   | CSI1   | DTBO                                    | Load DTBO Command                                                                                                         |
# +---------------+--------+--------+-----------------------------------------+---------------------------------------------------------------------------------------------------------------------------+
# | Genio 520/720 | OV5640 | x      | camera-ov5640-csi0-std.dtbo             | fw_setenv boot_conf "#conf-mediatek_mt8391-genio-720-evk.dtb#conf-emmc.dtbo#conf-camera-ov5640-csi0-std.dtbo"             |
# | Genio 510/700 | x      | OV5640 | camera-ov5640-csi1-std.dtbo             | fw_setenv boot_conf "#conf-mediatek_mt8391-genio-720-evk.dtb#conf-emmc.dtbo#conf-camera-ov5640-csi1-std.dtbo"             |
# | Genio 510/700 | OV5640 | OV5640 | camera-ov5640-dual-std.dtbo             | fw_setenv boot_conf "#conf-mediatek_mt8391-genio-720-evk.dtb#conf-emmc.dtbo#conf-camera-ov5640-dual-std.dtbo"             |
# | Genio 510/700 | IMX258 | x      | camera-imx258-csi0-std.dtbo             | fw_setenv boot_conf "#conf-mediatek_mt8391-genio-720-evk.dtb#conf-emmc.dtbo#conf-camera-imx258-csi0-std.dtbo"             |
# | Genio 510/700 | x      | IMX258 | camera-imx258-csi1-std.dtbo             | fw_setenv boot_conf "#conf-mediatek_mt8391-genio-720-evk.dtb#conf-emmc.dtbo#conf-camera-imx258-csi1-std.dtbo"             |
# | Genio 510/700 | IMX258 | IMX258 | camera-imx258-dual-std.dtbo             | fw_setenv boot_conf "#conf-mediatek_mt8391-genio-720-evk.dtb#conf-emmc.dtbo#conf-camera-imx258-dual-std.dtbo"             |
# | Genio 510/700 | IMX258 | OV5640 | camera-imx258-csi0-ov5640-csi1-std.dtbo | fw_setenv boot_conf "#conf-mediatek_mt8391-genio-720-evk.dtb#conf-emmc.dtbo#conf-camera-imx258-csi0-ov5640-csi1-std.dtbo" |
# +---------------+--------+--------+-----------------------------------------+---------------------------------------------------------------------------------------------------------------------------+

## Obtain Camera Nodes

CAM_NAME="seninf-top"
CAM_BUS_NAME=platform:$(basename `find /sys/bus/platform/devices/ -name "*${CAM_NAME}"`)
export CAM_MEDIA_DEV=$(v4l2-ctl -z ${CAM_BUS_NAME} --list-devices | grep media)
if [ -z ${CAM_MEDIA_DEV} ] ; then  echo "error: Cannot find media device"; [ "${BASH_SOURCE[0]}" != "${0}" ] && return; exit 1; fi

declare -a CAMSV_DEV_NAME=($(basename -a `find /sys/bus/platform/devices/ -name "*camsv*" | sort | tr "\n" " "`))
declare -a CAMSV_VIDEO_DEV=($(for i in ${CAMSV_DEV_NAME[@]}; do media-ctl -d ${CAM_MEDIA_DEV} --entity "${i} video stream"; done))
declare -a SENINF_DEV_NAME=(seninf-0 seninf-1)

## IMX258

IMX258_FMT () {
    MBUSFMT="SBGGR10_1X10"
    # V4L2FMT=BG10
    V4L2FMT=MBBA
    GSTFMT=UNKNOWN
    WIDTH=2104
    HEIGHT=1560
}

IMX258_CSI0 () {
    SENSOR="imx258 7-001a"
    NODE_ID=0
}

IMX258_CSI1 () {
    SENSOR="imx258 8-001a"
    NODE_ID=1
}

## OV5640

OV5640_FMT () {
    MBUSFMT=YUYV8_1X16
    V4L2FMT=YUYV
    GSTFMT=YUY2
    WIDTH=1920
    HEIGHT=1080
}

OV5640_CSI0 () {
    SENSOR="ov5640 7-003c"
    NODE_ID=0
}

OV5640_CSI1 () {
    SENSOR="ov5640 8-003c"
    NODE_ID=1
}

## Set Media Device

SET_MEDIA () {
    SENINF=${SENINF_DEV_NAME[${NODE_ID}]}
    CAMSV=${CAMSV_DEV_NAME[${NODE_ID}]}
    media-ctl -d ${CAM_MEDIA_DEV} -l "'${SENSOR}':0 -> '${SENINF}':0 [1]"
    media-ctl -d ${CAM_MEDIA_DEV} -l "'${SENINF}':1 -> '${CAMSV}':0 [1]"
    media-ctl -d ${CAM_MEDIA_DEV} -V "'${SENSOR}':0 [fmt:${MBUSFMT}/${WIDTH}x${HEIGHT}]"
    media-ctl -d ${CAM_MEDIA_DEV} -V "'${SENINF}':0 [fmt:${MBUSFMT}/${WIDTH}x${HEIGHT}]"
    media-ctl -d ${CAM_MEDIA_DEV} -V "'${CAMSV}':0 [fmt:${MBUSFMT}/${WIDTH}x${HEIGHT}]"
}

## Run pipeline

LAUNCH () {
    if [ "${GSTFMT}" != "UNKNOWN" ] ; then
        gst-launch-1.0 -e v4l2src device=${CAMSV_VIDEO_DEV[${NODE_ID}]} num-buffers=300 io-mode=mmap ! video/x-raw,width=${WIDTH},height=${HEIGHT},format=${GSTFMT} ! waylandsink sync=false
    else
        v4l2-ctl -v width=${WIDTH},height=${HEIGHT},pixelformat=${V4L2FMT} --stream-mmap --stream-count=300 -d ${CAMSV_VIDEO_DEV[${NODE_ID}]}
    fi
}

## Single Camera

SINGLE_CAMERA() {
    media-ctl -d ${CAM_MEDIA_DEV} -r

    ${FMT0}
    ${CSI0}
    SET_MEDIA
    LAUNCH
}

## Dual Camera

DUAL_CAMERA() {
    media-ctl -d ${CAM_MEDIA_DEV} -r

    ${FMT0}
    ${CSI0}
    SET_MEDIA
    LAUNCH &


    ${FMT1}
    ${CSI1}
    SET_MEDIA
    LAUNCH
}

# Buffer Starvation

BUFFER_STARVATION() {
    media-ctl -d ${CAM_MEDIA_DEV} -r

    ${FMT1}
    ${CSI0}
    SET_MEDIA

    v4l2-ctl -v width=${WIDTH},height=${HEIGHT},pixelformat=${V4L2FMT} --stream-mmap --stream-count=100 -d ${CAMSV_VIDEO_DEV[${NODE_ID}]} --stream-sleep count=10
}

# Test Cases

SINGLE_CAMERA_OV5640_CSI0 () {
    echo "Run ${FUNCNAME}"
    FMT0=OV5640_FMT
    CSI0=OV5640_CSI0
    SINGLE_CAMERA
}

SINGLE_CAMERA_OV5640_CSI1 () {
    echo "Run ${FUNCNAME}"
    FMT0=OV5640_FMT
    CSI0=OV5640_CSI1
    SINGLE_CAMERA
}

DUAL_CAMERA_OV5640_CSI0_OV5640_CSI1 () {
    echo "Run ${FUNCNAME}"
    FMT0=OV5640_FMT
    CSI0=OV5640_CSI0
    FMT1=OV5640_FMT
    CSI1=OV5640_CSI1
    DUAL_CAMERA
}

SINGLE_CAMERA_IMX258_CSI0 () {
    echo "Run ${FUNCNAME}"
    FMT0=IMX258_FMT
    CSI0=IMX258_CSI0
    SINGLE_CAMERA
}

SINGLE_CAMERA_IMX258_CSI1 () {
    echo "Run ${FUNCNAME}"
    FMT0=IMX258_FMT
    CSI0=IMX258_CSI1
    SINGLE_CAMERA
}

SINGLE_CAMERA_IMX258_CSI0_BUFFER_STARVATION () {
    echo "Run ${FUNCNAME}"
    FMT0=IMX258_FMT
    CSI0=IMX258_CSI0
    BUFFER_STARVATION
}

DUAL_CAMERA_IMX258_CSI0_IMX258_CSI1 () {
    echo "Run ${FUNCNAME}"
    FMT0=IMX258_FMT
    CSI0=IMX258_CSI0
    FMT1=IMX258_FMT
    CSI1=IMX258_CSI1
    DUAL_CAMERA
}

DUAL_CAMERA_IMX258_CSI0_OV5640_CSI1 () {
    echo "Run ${FUNCNAME}"
    FMT0=IMX258_FMT
    CSI0=IMX258_CSI0
    FMT1=OV5640_FMT
    CSI1=OV5640_CSI1
    DUAL_CAMERA
}

help () {
    echo "Run the following test according to your hardware setting:"
    echo ""
    echo "    SINGLE_CAMERA_OV5640_CSI0"
    echo "    SINGLE_CAMERA_OV5640_CSI1"
    echo "    DUAL_CAMERA_OV5640_CSI0_OV5640_CSI1"
    echo "    SINGLE_CAMERA_IMX258_CSI0"
    echo "    SINGLE_CAMERA_IMX258_CSI1"
    echo "    SINGLE_CAMERA_IMX258_CSI0_BUFFER_STARVATION"
    echo "    DUAL_CAMERA_IMX258_CSI0_IMX258_CSI1"
    echo "    DUAL_CAMERA_IMX258_CSI0_OV5640_CSI1"
    echo ""
    echo "    e.g. # SINGLE_CAMERA_OV5640_CSI0"
}

help
