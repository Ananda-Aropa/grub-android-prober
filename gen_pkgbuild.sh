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

. PKGBUILD

# Update RPM spec
if [ -f rpm/setup.sh ]; then
	./rpm/setup.sh
fi

sha512_hash() { sha512sum "$1" | awk '{print $1}'; }

HASHES=""

for f in "${source[@]}"; do
	real_f="${f##*::}"
	HASHES+="'$(sha512_hash "$real_f")' "
done

if [ -f PKGBUILD ]; then
	sed -ri "s/^sha512sums=\(.+\)$/sha512sums=($HASHES)/g" PKGBUILD
	makepkg --printsrcinfo >.SRCINFO
fi

mv systemd/* ./
