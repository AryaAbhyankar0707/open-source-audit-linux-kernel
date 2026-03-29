#!/bin/bash
# ─────────────────────────────────────────────────────────────────
# Script 2: FOSS Package Inspector
# Author: Arya Abhyankar | Reg No.: 24BAI10382
# Course: Open Source Software (NGMC) | Software Audited: Linux Kernel
# Usage: ./script2_package_inspector.sh [package-name]
# Description:
# Checks whether a package is installed, prints its metadata,
# and displays a FOSS philosophy note based on the package name.
# ─────────────────────────────────────────────────────────────────

# Parameter expansion with default: use $1 if provided, else 'kernel'
PACKAGE="${1:-kernel}"

echo "================================================"
echo "       FOSS Package Inspector"
echo "       Checking: $PACKAGE"
echo "================================================"

# --- Detect which package manager is available on this system ---
if command -v rpm &>/dev/null; then
    # RPM-based system (Fedora, CentOS, RHEL)
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "Status : INSTALLED"
        echo ""
        echo "--- Package Details ---"
        rpm -qi "$PACKAGE" | grep -E '^(Name|Version|Release|License|Summary)'
    else
        echo "Status : NOT INSTALLED"
        echo "Install with: sudo dnf install $PACKAGE"
    fi

elif command -v dpkg &>/dev/null; then
    # Debian/Ubuntu-based system
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q '^ii'; then
        echo "Status : INSTALLED"
        echo ""
        echo "--- Package Details ---"
        dpkg -s "$PACKAGE" | grep -E '^(Package|Version|Maintainer|Description)'
    else
        echo "Status : NOT INSTALLED"
        echo "Install with: sudo apt install $PACKAGE"
    fi

else
    echo "Neither rpm nor dpkg found. Cannot query packages."
fi

echo ""
echo "--- Open Source Philosophy Note ---"

# --- case statement: branch on the value of $PACKAGE ---
case "$PACKAGE" in
    kernel | linux-image*)
        echo "Linux Kernel (GPLv2): the foundation everything else runs on."
        echo "Built by thousands globally — the definitive open source project."
        ;;
    httpd | apache2)
        echo "Apache HTTP Server (Apache 2.0): the permissive licence that"
        echo "built the open web and powers around 30% of global websites."
        ;;
    mysql | mariadb)
        echo "MySQL/MariaDB (GPL v2/Commercial): open source at the heart of"
        echo "millions of apps, with an interesting dual-licence commercial model."
        ;;
    firefox)
        echo "Firefox (MPL 2.0): a nonprofit browser fighting for an open web,"
        echo "proving community values can compete with the largest corporations."
        ;;
    git)
        echo "Git (GPL v2): Linus Torvalds built this when a proprietary VCS"
        echo "failed him. Now the universal language of code collaboration."
        ;;
    python3 | python)
        echo "Python (PSF Licence): a language shaped entirely by community"
        echo "consensus, governed by the PSF — open governance in practice."
        ;;
    *)
        echo "$PACKAGE: research its licence to understand why its creators"
        echo "chose to share it with the world."
        ;;
esac

echo "================================================"