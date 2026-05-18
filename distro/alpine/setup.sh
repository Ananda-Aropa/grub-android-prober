#!/bin/bash

# Navigate to the directory of this script
cd "$(dirname "$0")"

VERSION=$(cat ../../VERSION | sed 's/^v//;s/-/+/g')

# Update APKBUILD pkgver
sed -i "s/^pkgver=.*/pkgver=$VERSION/" APKBUILD

# Flatten src
find ../../src -type f -exec cp -t . {} +