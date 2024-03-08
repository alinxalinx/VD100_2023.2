FILESEXTRAPATHS:prepend  := "${THISDIR}/files:"

SRC_URI += "file://eth1_phy_init.sh"
SRC_URI += "file://eth1-phy-set.service"

dirs755:append = " ${sysconfdir}/init.d"
dirs755:append = " ${sysconfdir}/systemd/system"
dirs755:append = " ${sysconfdir}/systemd/system/multi-user.target.wants"

do_install:append () {
        install -m 0755 ${WORKDIR}/eth1_phy_init.sh ${D}${sysconfdir}/init.d/eth1_phy_init.sh
        install -m 644 ${WORKDIR}/eth1-phy-set.service ${D}${sysconfdir}/systemd/system/eth1-phy-set.service
        ln -s ${D}${sysconfdir}/systemd/system/eth1-phy-set.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/eth1-phy-set.service
}

