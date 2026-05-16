#!/bin/bash

VERSION=$(cat VERSION | sed 's/^v//;s/-/+/g')

# Update APKBUILD pkgver
if [ -f APKBUILD ]; then
	sed -i "s/^pkgver=.*/pkgver=$VERSION/" APKBUILD
fi

# Update PKGBUILD pkgver
if [ -f PKGBUILD ]; then
	sed -i "s/^pkgver=.*/pkgver=$VERSION/" PKGBUILD
fi

# Load source array from PKGBUILD
if [ -f PKGBUILD ]; then
	# shellcheck source=PKGBUILD
	. ./PKGBUILD
fi

# Update RPM spec
if [ -f rpm/setup.sh ]; then
	./rpm/setup.sh
fi

sha512_hash() { sha512sum "$1" | awk '{print $1}'; }

HASHES_ARCH=""
HASHES_ALPINE=""

for f in "${source[@]}"; do
	real_f="${f##*::}"
	hash=$(sha512_hash "$real_f")
	HASHES_ARCH+="'$hash' "
	HASHES_ALPINE+="$hash  ${f%%::*}\n"
done

# Update PKGBUILD hashes
if [ -f PKGBUILD ]; then
	sed -ri "s/^sha512sums=\(.+\)$/sha512sums=($HASHES_ARCH)/g" PKGBUILD
	makepkg --printsrcinfo >.SRCINFO
fi

# Setup source files
mv systemd/* ./
