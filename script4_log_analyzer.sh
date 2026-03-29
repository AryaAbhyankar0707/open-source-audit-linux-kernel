#!/bin/bash
# ─────────────────────────────────────────────────────────────────
# Script 4: Log File Analyzer
# Author: Arya Abhyankar | Reg No.: 24BAI10382
# Course: Open Source Software (NGMC) | Software Audited: Linux Kernel
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# Description:
# Reads a log file line by line, counts occurrences of a keyword,
# and prints a summary along with the last 5 matching lines.
# ─────────────────────────────────────────────────────────────────

# --- Assign command-line arguments to named variables ---
LOGFILE=$1
KEYWORD=${2:-"error"}   # Default keyword is 'error' if not supplied
COUNT=0

# --- Input validation: check a filename was actually supplied ---
if [ -z "$LOGFILE" ]; then
    echo "Usage: $0 <logfile> [keyword]"
    echo "Example: $0 /var/log/syslog error"
    exit 1
fi

# --- Check that the file exists and is a regular file ---
if [ ! -f "$LOGFILE" ]; then
    echo "Error: '$LOGFILE' was not found or is not a regular file."
    exit 1
fi

# --- Check that the file is not empty ---
if [ ! -s "$LOGFILE" ]; then
    echo "Warning: '$LOGFILE' is empty. Nothing to analyse."
    exit 0
fi

echo "====================================================="
echo "          Log File Analyser"
echo "  File    : $LOGFILE"
echo "  Keyword : '$KEYWORD' (case-insensitive)"
echo "====================================================="
echo ""

# --- while-read loop: read the file one line at a time ---
# IFS= prevents read from stripping leading/trailing whitespace
# -r prevents backslash sequences from being interpreted
while IFS= read -r LINE; do

    # grep -iq: case-insensitive, quiet (uses exit code only)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi

done < "$LOGFILE"

# --- Print the summary result ---
echo "Result: Keyword '$KEYWORD' found $COUNT time(s)."
echo ""

# --- Show the last 5 matching lines for context ---
if [ "$COUNT" -gt 0 ]; then
    echo "--- Last 5 matching lines ---"
    grep -i "$KEYWORD" "$LOGFILE" | tail -5
else
    echo "No lines matching '$KEYWORD' were found in $LOGFILE."
fi

echo ""
echo "====================================================="