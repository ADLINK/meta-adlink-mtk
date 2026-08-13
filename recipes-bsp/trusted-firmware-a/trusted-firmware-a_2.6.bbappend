# OSM-MTK520 pins TF-A to the revision validated on IoT Yocto v25.1 and
# drops the binutils compatibility patch, which does not apply on top
# of that revision.
SRCREV:osm-mtk520 = "740c6c66e6d377c00cc2bfb5158a1fb3a795e756"
SRC_URI:remove:osm-mtk520 = " file://0002-feat-build-add-support-for-new-binutils-versions.patch"
