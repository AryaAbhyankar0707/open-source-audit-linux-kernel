#!/bin/bash
# ─────────────────────────────────────────────────────────────────
# Script 1: System Identity Report
# Author: Arya Abhyankar | Reg No.: 24BAI10382
# Course: Open Source Software (NGMC) | Software Audited: Linux Kernel
# Description:
# Displays a formatted system identity screen showing OS details,
# kernel version, current user, uptime, and the kernel's licence.
# ─────────────────────────────────────────────────────────────────

# --- Static variables ---
STUDENT_NAME="Arya Abhyankar"
REG_NUMBER="24BAI10382"
SOFTWARE_CHOICE="Linux Kernel"

# --- Command substitution: capture system information at runtime ---
KERNEL=$(uname -r)
USER_NAME=$(whoami)
HOME_DIR=$HOME
UPTIME=$(uptime -p)
DATETIME=$(date '+%A, %d %B %Y %H:%M')

# Extract the distribution name from /etc/os-release
DISTRO=$(grep '^PRETTY_NAME' /etc/os-release | cut -d'=' -f2 | tr -d '"')

# --- Display the formatted output ---
echo "================================================"
echo "         Open Source Audit"
echo "  Student  : $STUDENT_NAME ($REG_NUMBER)"
echo "  Software : $SOFTWARE_CHOICE"
echo "================================================"
echo "OS Distribution : $DISTRO"
echo "Kernel Version  : $KERNEL"
echo "Logged-in User  : $USER_NAME"
echo "Home Directory  : $HOME_DIR"
echo "System Uptime   : $UPTIME"
echo "Date & Time     : $DATETIME"
echo "------------------------------------------------"
echo "Licence Note:"
echo "  The Linux kernel is distributed under the"
echo "  GNU General Public License v2 (GPLv2)."
echo "  You are free to study, modify, and redistribute"
echo "  it under the same licence terms."
echo "================================================"