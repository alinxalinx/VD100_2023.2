FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://bsp.cfg \
            "
SRC_URI:append = " file://0001-fbmem-for-x11.patch "
KERNEL_FEATURES:append = " bsp.cfg"

