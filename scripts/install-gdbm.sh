#!/bin/sh
set -e

mkdir -p /usr/src
tar -xzf gdbm.tar.gz -C /usr/src/
rm -f gdbm.tar.gz

GDBM_DIR=$(ls /usr/src/ | grep gdbm)

cd /usr/src/${GDBM_DIR}
./configure

make -j "$(nproc)"
make install

rm -rf /usr/src/${GDBM_DIR}
