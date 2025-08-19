set -eu

PKG_NAME="nocaptive"
ARCH="all"
MAINTAINER="Kimathi Sedegah <sedegahkim@gnail.com>"
HOMEPAGE="https://github.com/sedegah"

if grep -q '^VERSION=' nocaptive 2>/dev/null; then
    VERSION=$(grep '^VERSION=' nocaptive | head -n 1 | cut -d'=' -f2 | tr -d '"')
elif grep -q '__version__' nocaptive 2>/dev/null; then
    VERSION=$(grep '__version__' nocaptive | head -n 1 | cut -d'=' -f2 | tr -d '" ')
else
    echo "Error: Could not detect version from nocaptive script."
    exit 1
fi

echo "[INFO] Detected version: $VERSION"

rm -rf "${PKG_NAME}_${VERSION}"
rm -f "${PKG_NAME}_${VERSION}.deb"

mkdir -p "${PKG_NAME}_${VERSION}/DEBIAN"
mkdir -p "${PKG_NAME}_${VERSION}/usr/local/bin"

cp "nocaptive" "${PKG_NAME}_${VERSION}/usr/local/bin/"
chmod 755 "${PKG_NAME}_${VERSION}/usr/local/bin/nocaptive"

cat > "${PKG_NAME}_${VERSION}/DEBIAN/control" <<EOL
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

cat > "${PKG_NAME}_${VERSION}/DEBIAN/postinst" <<'EOL'
#!/bin/bash
set -e
echo "nocaptive installed successfully."
EOL
chmod 755 "${PKG_NAME}_${VERSION}/DEBIAN/postinst"

dpkg-deb --build --root-owner-group "${PKG_NAME}_${VERSION}"

echo "[OK] Built ${PKG_NAME}_${VERSION}.deb"
