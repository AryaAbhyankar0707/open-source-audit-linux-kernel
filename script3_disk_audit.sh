#!/bin/bash
# ─────────────────────────────────────────────────────────────────
# Script 3: Disk and Permission Auditor
# Author: Arya Abhyankar | Reg No.: 24BAI10382
# Course: Open Source Software (NGMC) | Software Audited: Linux Kernel
# Description:
# Loops through key Linux system directories, reporting permissions,
# ownership, and disk usage. Also audits the kernel module directory.
# ─────────────────────────────────────────────────────────────────

# --- Array declaration ---
# Bash arrays are declared with () and elements separated by whitespace
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/boot" "/lib/modules")

echo "====================================================="
echo "          Directory Audit Report"
echo "====================================================="
echo ""

# --- for loop: iterate over every element in the DIRS array ---
for DIR in "${DIRS[@]}"; do

    # [ -d ] is a file test operator: true if path exists and is a directory
    if [ -d "$DIR" ]; then

        # awk extracts fields from ls -ld output:
        # $1 = permissions string, $3 = owner, $4 = group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh: human-readable size; 2>/dev/null suppresses 'permission denied'
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        echo "Directory  : $DIR"
        echo "  Permissions : $PERMS"
        echo "  Owner/Group : $OWNER / $GROUP"
        echo "  Disk Usage  : ${SIZE:-unavailable}"
        echo ""

    else
        echo "$DIR — does not exist on this system."
        echo ""
    fi

done

# --- Kernel-specific section: audit the module directory ---
KERNEL_VER=$(uname -r)
MOD_DIR="/lib/modules/$KERNEL_VER"

echo "====================================================="
echo "       Kernel Module Directory Audit"
echo "       Running kernel: $KERNEL_VER"
echo "====================================================="

if [ -d "$MOD_DIR" ]; then
    MOD_PERMS=$(ls -ld "$MOD_DIR" | awk '{print $1}')
    MOD_OWNER=$(ls -ld "$MOD_DIR" | awk '{print $3, $4}')
    MOD_SIZE=$(du -sh "$MOD_DIR" 2>/dev/null | cut -f1)
    MOD_COUNT=$(ls "$MOD_DIR" | wc -l)

    echo "Path             : $MOD_DIR"
    echo "Permissions      : $MOD_PERMS"
    echo "Owner/Group      : $MOD_OWNER"
    echo "Disk Usage       : $MOD_SIZE"
    echo "Top-level entries: $MOD_COUNT"
else
    echo "Module directory not found: $MOD_DIR"
fi

echo "====================================================="