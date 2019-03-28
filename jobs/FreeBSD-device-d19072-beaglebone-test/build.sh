#!/bin/sh

export TARGET=${FBSD_TARGET}
export TARGET_ARCH=${FBSD_TARGET_ARCH}
export DEVICE=${DEVICE_NAME}
JOB_BASE=`dirname $0`

sh -x freebsd-ci/scripts/test/extract-artifacts.sh
sh -x ${WORKSPACE}/${JOB_BASE}/overlay_dts.sh
sh -x ${WORKSPACE}/${JOB_BASE}/overlay_repo.sh
sh -x freebsd-ci/scripts/test/run-device-tests.sh

