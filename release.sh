#!/bin/bash

# Fetch git
version="$1"
git clone https://github.com/git/git/ -b v"$version" --depth=1

pushd git || exit

# Make path
mkdir -p release/usr/local

# Build git
make configure
./configure --prefix="$PWD"/release/usr/local
make all doc

# Install git
make install install-doc install-html

# Set package
mkdir -p "$PWD"/release/DEBIAN
bash -c "cat > $PWD/release/DEBIAN/control" << EOF
Package: git
Version: $version
Maintainer: Jia Jia
Architecture: all
Description: Git Debian package
EOF

# Build package
dpkg-deb --build release

popd || exit
