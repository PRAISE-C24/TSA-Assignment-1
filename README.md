# TS Academy Assignment - Assignment 1

# Linux & Bash System Administration Toolkit

A collection of lightweight Bash scripts designed for system monitoring, disk space validation, network connectivity checks, and runtime logging.

## Included Scripts

1. **`system-info.sh`**
   - Gathers and displays runtime system information including hostname, current user, date/time, operating system, kernel version, uptime, CPU info, memory usage, and working directory.
   - Automatically appends a timestamped entry to `logs/system-info.log`.

2. **`disk-check.sh`**
   - Monitors disk usage against a specified percentage threshold (default: `/`).
   - Validates input parameters (threshold must be an integer between 1 and 100).
   - Exits with `0` (below threshold), `1` (threshold reached/exceeded), or `2` (invalid input).
   - Logs results to `logs/disk-check.log`.

3. **`network-check.sh`**
   - Resolves target hostnames or IP addresses, performs ICMP ping checks, inspects network interfaces, and optionally tests TCP port connectivity (ports 1–65535).
   - Logs results to `logs/network-check.log`.

---

## Usage Instructions

1. System Information

./system-info.sh

2. Disk Check

# Check root partition against an 80% threshold

./disk-check.sh 80

# Check a custom path against a 50% threshold

./disk-check.sh 50 /var

3. Network Check

# Check host resolution and ping
./network-check.sh google.com

# Check host and a specific TCP port (e.g., HTTPS)
./network-check.sh google.com 443

4. Automated  Testing

# To run the automated local grader and verify all requirements:

./grade.sh