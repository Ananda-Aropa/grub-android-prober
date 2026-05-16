#!/bin/bash
set -e

# Get version from VERSION file, removing leading 'v' and converting '-' to '+'
VERSION=$(cat VERSION | sed 's/^v//;s/-/+/g')
RELEASE=${RELEASE:-1}
SPEC_FILE="rpm/grub-android-prober.spec"

# Update version and release in spec file
sed -i "s/^Version:.*/Version:        $VERSION/" "$SPEC_FILE"
sed -i "s/^Release:.*/Release:        $RELEASE%{?dist}/" "$SPEC_FILE"

# Generate dynamic changelog from git
MAINTAINER=$(git log -1 --pretty=format:'%an <%ae>')
DATE=$(git log -1 --pretty=format:'%ad' --date=format:'%a %b %d %Y')
MSG=$(git log -1 --pretty=format:'%s')

# Clear existing %changelog and append new one
sed -i '/^%changelog/q' "$SPEC_FILE"
cat <<EOT >> "$SPEC_FILE"
* $DATE $MAINTAINER - $VERSION-$RELEASE
- $MSG
EOT

cp -r systemd/. ./
