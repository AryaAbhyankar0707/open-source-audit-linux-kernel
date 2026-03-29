#!/bin/bash
# ─────────────────────────────────────────────────────────────────
# Script 5: Open Source Manifesto Generator
# Author: Arya Abhyankar | Reg No.: 24BAI10382
# Course: Open Source Software (NGMC) | Software Audited: Linux Kernel
# Description:
# Prompts the user for three inputs and generates a personalised
# open source philosophy statement, saved to a .txt file.
#
# Alias concept (demonstration — aliases work in interactive shells):
# In an interactive Bash session you could run:
#   alias manifesto='bash script5_manifesto_generator.sh'
# Then simply type 'manifesto' to invoke this script.
# Aliases defined inside scripts are not inherited by the parent shell.
# ─────────────────────────────────────────────────────────────────

echo "====================================================="
echo "      Open Source Manifesto Generator"
echo "====================================================="
echo "Answer three questions to create your manifesto."
echo ""

# --- read -p: display a prompt and wait for user input ---
read -p "1. Name one open-source tool you use every day: " TOOL
read -p "2. In one word, what does 'freedom' mean to you? " FREEDOM
read -p "3. Name something you would build and share freely: " BUILD

echo ""

# --- Generate file metadata ---
USERNAME=$(whoami)
DATESTAMP=$(date '+%Y-%m-%d')           # e.g. 2026-03-29 (for filename)
DATE_LONG=$(date '+%d %B %Y')           # e.g. 29 March 2026 (for display)
OUTPUT="manifesto_${USERNAME}_${DATESTAMP}.txt"

# --- Write the manifesto to the output file ---
# > creates/overwrites the file on first use; >> appends thereafter
echo "====================================================" > "$OUTPUT"
echo "           OPEN SOURCE MANIFESTO"              >> "$OUTPUT"
echo "  By: $USERNAME | Date: $DATE_LONG"            >> "$OUTPUT"
echo "====================================================" >> "$OUTPUT"
echo ""                                               >> "$OUTPUT"
echo "I believe in the power of open source software." >> "$OUTPUT"
echo "Every day I rely on $TOOL — a tool built freely" >> "$OUTPUT"
echo "and maintained openly by people who chose to share" >> "$OUTPUT"
echo "their work with the world rather than lock it away." >> "$OUTPUT"
echo ""                                               >> "$OUTPUT"
echo "To me, freedom means $FREEDOM. In software, this is" >> "$OUTPUT"
echo "the freedom to read, modify, and share the tools we" >> "$OUTPUT"
echo "depend on — without needing anyone's permission."  >> "$OUTPUT"
echo ""                                               >> "$OUTPUT"
echo "I commit to this tradition. One day I will build"  >> "$OUTPUT"
echo "$BUILD and share it openly, so that others may"    >> "$OUTPUT"
echo "stand on my shoulders as I have stood on the"      >> "$OUTPUT"
echo "shoulders of those who came before me."            >> "$OUTPUT"
echo ""                                               >> "$OUTPUT"
echo "This is my open source manifesto."              >> "$OUTPUT"
echo "====================================================" >> "$OUTPUT"

# --- Confirm and display the saved manifesto ---
echo "Manifesto saved to: $OUTPUT"
echo ""
cat "$OUTPUT"