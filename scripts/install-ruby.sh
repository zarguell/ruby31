#!/bin/sh
set -e

mkdir -p /usr/src
tar -xzf ruby-3.1.tar.gz -C /usr/src/
rm -f ruby-3.1.tar.gz

RUBY_DIR=$(ls /usr/src/ | grep ruby)

cd /usr/src/${RUBY_DIR}
./configure --disable-install-doc --enable-shared

make -j "$(nproc)"
make install

rm -rf /usr/src/${RUBY_DIR}
