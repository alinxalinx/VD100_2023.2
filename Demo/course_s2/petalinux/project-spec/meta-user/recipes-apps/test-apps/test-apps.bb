#
# This file is the test-apps recipe.
#
SUMMARY = "Simple test-apps application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

OPENCV_PACKAGES = " \
        opencv \
        libopencv-core \
        libopencv-highgui \
        libopencv-imgproc \
        libopencv-objdetect \
        libopencv-ml \
        libopencv-calib3d \
        libopencv-ccalib \
		libopencv-videoio \
        "


RDEPENDS:${PN} = "bash ${OPENCV_PACKAGES}"

FILESEXTRAPATHS:prepend  := "${THISDIR}/files:"

SRC_URI = "file://0_dis_dpms.sh"
SRC_URI += "file://2_demosaic_init.sh"
SRC_URI += "file://eeprom_test.sh"
SRC_URI += "file://leds_keys_test.sh"
SRC_URI += "file://mipi_init.sh"
SRC_URI += "file://mipi_senser1_show"
SRC_URI += "file://1_senser_init.sh"
SRC_URI += "file://3_vdma_init.sh"
SRC_URI += "file://emmc_test.sh"
SRC_URI += "file://lm75_test.sh"
SRC_URI += "file://mipi_senser0_show"
SRC_URI += "file://qspi_flash_test.sh"

dirs755:append = "/home/petalinux/test_apps"
FILES:${PN} += "/home/petalinux/test_apps/*"

do_install() {
	     install -d ${D}/home/petalinux/test_apps
	     install -m 0755 ${WORKDIR}/0_dis_dpms.sh ${D}/home/petalinux/test_apps/0_dis_dpms.sh
	     install -m 0755 ${WORKDIR}/2_demosaic_init.sh ${D}/home/petalinux/test_apps/2_demosaic_init.sh
	     install -m 0755 ${WORKDIR}/eeprom_test.sh ${D}/home/petalinux/test_apps/eeprom_test.sh
	     install -m 0755 ${WORKDIR}/leds_keys_test.sh ${D}/home/petalinux/test_apps/leds_keys_test.sh
	     install -m 0755 ${WORKDIR}/mipi_init.sh ${D}/home/petalinux/test_apps/mipi_init.sh
	     install -m 0755 ${WORKDIR}/mipi_senser1_show ${D}/home/petalinux/test_apps/mipi_senser1_show
	     install -m 0755 ${WORKDIR}/1_senser_init.sh ${D}/home/petalinux/test_apps/1_senser_init.sh
	     install -m 0755 ${WORKDIR}/3_vdma_init.sh ${D}/home/petalinux/test_apps/3_vdma_init.sh
	     install -m 0755 ${WORKDIR}/emmc_test.sh ${D}/home/petalinux/test_apps/emmc_test.sh
	     install -m 0755 ${WORKDIR}/lm75_test.sh ${D}/home/petalinux/test_apps/lm75_test.sh
	     install -m 0755 ${WORKDIR}/mipi_senser0_show ${D}/home/petalinux/test_apps/mipi_senser0_show
	     install -m 0755 ${WORKDIR}/qspi_flash_test.sh ${D}/home/petalinux/test_apps/qspi_flash_test.sh
} 
