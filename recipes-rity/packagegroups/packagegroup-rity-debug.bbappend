RDEPENDS:${PN} = " \
        devmem2 \
        gdb \
        i2c-tools \
        i2c-tools-misc \
        libgpiod-tools \
        os-release \
        strace \
        stress-ng \
        powertop \
"
RDEPENDS:${PN}:remove:osm-mtk510 = "opengl-es-cts vulkan-cts"

