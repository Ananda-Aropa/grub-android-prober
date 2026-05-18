#!/bin/bash

# Navigate to the directory of this script
cd "$(dirname "$0")"

VERSION=$(cat ../../VERSION | sed 's/^v//;s/-/+/g')

# Update PKGBUILD pkgver
if [ -f PKGBUILD ]; then
	sed -i "s/^pkgver=.*/pkgver=$VERSION/" PKGBUILD
fi

sha512_hash() { sha512sum "$1" | awk '{print $1}'; }

# Flatten src
find ../../src -type f -exec cp -t . {} +

# Update hashes
. PKGBUILD
HASHES_ARCH=""
for f in "${source[@]}"; do
	real_f="${f##*::}"
	hash=$(sha512_hash "$real_f")
	HASHES_ARCH+="'$hash' "
done
sed -ri "s/^sha512sums=\(.+\)$/sha512sums=($HASHES_ARCH)/g" PKGBUILD
makepkg --printsrcinfo >.SRCINFO
