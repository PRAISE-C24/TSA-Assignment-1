#!/usr/bin/env bash

mkdir -p logs
LOG_FILE="logs/disk-check.log"

THRESHOLD="$1"
TARGET_PATH="${2:-/}"

perform_check() {
    echo "=========================================="
    echo "  DISK CHECK ENTRY - $(date '+%Y-%m-%d %H:%M:%S %Z')"
    echo "=========================================="
    echo "Path:       $TARGET_PATH"
    echo "Threshold:  ${THRESHOLD}%"

    if [ -z "$THRESHOLD" ]; then
        echo "Error: Threshold parameter is required." >&2
        echo "=========================================="
        echo ""
        return 2
    fi

    if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]] || [ "$THRESHOLD" -lt 1 ] || [ "$THRESHOLD" -gt 100 ]; then
        echo "Error: Threshold must be an integer from 1 to 100." >&2
        echo "=========================================="
        echo ""
        return 2
    fi

    if [ ! -e "$TARGET_PATH" ]; then
        echo "Error: Path '$TARGET_PATH' does not exist." >&2
        echo "=========================================="
        echo ""
        return 2
    fi

    USAGE=$(df -P "$TARGET_PATH" 2>/dev/null | awk 'NR==2 {gsub("%", "", $5); print $5}')
    if [ -z "$USAGE" ]; then
        echo "Error: Could not retrieve disk usage." >&2
        echo "=========================================="
        echo ""
        return 2
    fi

    echo "Current Usage: ${USAGE}%"

    if [ "$USAGE" -ge "$THRESHOLD" ]; then
        echo "Status: Usage reaches or exceeds threshold."
        echo "=========================================="
        echo ""
        return 1
    else
        echo "Status: Usage is below threshold."
        echo "=========================================="
        echo ""
        return 0
    fi
}

perform_check | tee -a "$LOG_FILE"
EXIT_CODE=${PIPESTATUS[0]}
exit "$EXIT_CODE"