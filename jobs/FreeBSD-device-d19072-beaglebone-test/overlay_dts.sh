#!/bin/sh

: ${TFTPROOT:="/b/tftpboot"}
: ${DESTDIR:="${TFTPROOT}/${DEVICE}/install"}

# Compile DTSO
MACHINE=arm dtc -O dtb -o am335x-boneblack-cpsw.dtbo -b 0 -@ am335x-boneblack-cpsw.dtso
sudo mkdir -p ${DESTDIR}/boot/dtbo
sudo mv am335x-boneblack-cpsw.dtbo ${DESTDIR}/boot/dtbo

# Use overlay
sudo sysrc -f ${DESTDIR}/boot/loader.conf fdt_overlays+=",/boot/dtbo/am335x-boneblack-cpsw.dtbo"
