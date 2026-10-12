#!/usr/bin/env bash

mkdir -p logs
LOG_FILE="logs/network-check.log"

HOST="$1"
PORT="$2"

perform_check() {
    echo "=========================================="
    echo "  NETWORK CHECK ENTRY - $(date '+%Y-%m-%d %H:%M:%S %Z')"
    echo "=========================================="

    if [ -z "$HOST" ]; then
        echo "Error: Hostname or IP address is required." >&2
        echo "=========================================="
        echo ""
        return 1
    fi

    echo "Target Host:       $HOST"

    echo -n "Resolving host... "
    RESOLVED_IP=$(getent hosts "$HOST" 2>/dev/null | awk '{print $1}' | head -n 1)
    [ -z "$RESOLVED_IP" ] && RESOLVED_IP=$(nslookup "$HOST" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n 1)
    [ -z "$RESOLVED_IP" ] && RESOLVED_IP=$(ping -c 1 -W 2 "$HOST" 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)

    if [ -n "$RESOLVED_IP" ]; then
        echo -e "\nResolved Address: $RESOLVED_IP"
    else
        echo -e "\nCould not resolve address."
    fi

    echo "------------------------------------------"
    echo "Basic Connectivity Check (Ping):"
    if ping -c 2 -W 3 "$HOST" &>/dev/null; then
        echo "Status: Host is reachable via ICMP."
    else
        echo "Status: Host did not respond to ICMP ping."
    fi

    echo "------------------------------------------"
    echo "Local Network Interfaces:"
    if command -v ip &>/dev/null; then
        ip -brief addr show 2>/dev/null || ip addr show 2>/dev/null | grep -E 'inet |UP'
    else
        ifconfig 2>/dev/null || echo "Network interface tools not available."
    fi

    if [ -n "$PORT" ]; then
        echo "------------------------------------------"
        echo "TCP Port Check (Port: $PORT):"
        
        if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
            echo "Error: Invalid port '$PORT'." >&2
            echo "=========================================="
            echo ""
            return 2
        fi

        PORT_OPEN=false
        if command -v nc &>/dev/null; then
            nc -z -w 3 "$HOST" "$PORT" &>/dev/null && PORT_OPEN=true
        else
            timeout 3 bash -c "(: < /dev/tcp/$HOST/$PORT) 2>/dev/null" && PORT_OPEN=true
        fi

        if [ "$PORT_OPEN" = true ]; then
            echo "Status: TCP port $PORT on $HOST is OPEN."
            echo "=========================================="
            echo ""
            return 0
        else
            echo "Status: TCP port $PORT on $HOST is CLOSED or filtered."
            echo "=========================================="
            echo ""
            return 1
        fi
    fi

    echo "=========================================="
    echo ""
    return 0
}

perform_check | tee -a "$LOG_FILE"
EXIT_CODE=${PIPESTATUS[0]}
exit "$EXIT_CODE"