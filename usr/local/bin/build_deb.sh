#!/bin/bash
set -e

# Config
PKG_NAME="nocaptive"
VERSION="1.0"
ARCH="all"
MAINTAINER="Kimathi Sedegah <youremail@example.com>"
HOMEPAGE="https://github.com/sedegah"

# Clean up old builds
rm -rf ${PKG_NAME}_${VERSION}
rm -f ${PKG_NAME}_${VERSION}.deb

# Create directory structure
mkdir -p ${PKG_NAME}_${VERSION}/DEBIAN
mkdir -p ${PKG_NAME}_${VERSION}/usr/local/bin

# Copy the script
cp nocaptive ${PKG_NAME}_${VERSION}/usr/local/bin/
chmod 755 ${PKG_NAME}_${VERSION}/usr/local/bin/nocaptive

# Create control file
cat > ${PKG_NAME}_${VERSION}/DEBIAN/control <<EOL
Package: ${PKG_NAME}
Version: ${VERSION}
Section: utils
Priority: optional
Architecture: ${ARCH}
Depends: python3, python3-requests
Maintainer: ${MAINTAINER}
Homepage: ${HOMEPAGE}
Description: Simple captive portal detection tool for the terminal.
 A CLI tool that checks for captive portals by sending HTTP requests
 to a known site and verifying expected content.
EOL

# Build the .deb package
dpkg-deb --build ${PKG_NAME}_${VERSION}

echo "[OK] Built ${PKG_NAME}_${VERSION}.deb"
