#!/bin/bash

# Fetch git
version="$1"
git clone https://github.com/git/git/ -b v"$version" --depth=1

pushd git || exit

# Make path
mkdir -p release/usr

# Build git
make all PREFIX="$PWD"/release/usr

# Install git
make install PREFIX="$PWD"/release/usr

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
