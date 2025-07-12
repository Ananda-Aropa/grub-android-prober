#! /usr/bin/bash

# Exit Immediately if a command fails
set -e

cd "$(dirname "$0")"

DISTRO="${DISTRO:-unstable}"
MAINTAINER=$(git log -1 --pretty=format:'%an <%ae>')
VERSION=$(cat ../VERSION | cut -d'v' -f2)
REVISION=${REVISION:-0}

PACKAGE_NAME=$(grep 'Source:' control | cut -d' ' -f2)

# Gen changelog (from latest commit)
MSG=$(git log -1 --pretty=format:'%s')
DATE=$(git log -1 --pretty=format:'%ad' --date=format:'%a, %d %b %Y %H:%M:%S %z')

# Generate changelog
cat <<EOF >changelog
$PACKAGE_NAME ($VERSION-$REVISION) $DISTRO; urgency=medium

$(echo -e "$MSG" | sed -r 's/^/  * /g')

 -- $MAINTAINER  $DATE

EOF

# Update PKGBUILD
sed -i "s/^pkgver=.*/pkgver=$VERSION/" ../PKGBUILD
sed -i "s/^pkgrel=.*/pkgrel=$REVISION/" ../PKGBUILD