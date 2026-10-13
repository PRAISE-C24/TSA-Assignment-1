# TS Academy Assignment – Assignment 1

Linux & Bash System Administration Toolkit

A collection of lightweight Bash scripts designed for Linux system monitoring, disk space validation, network connectivity checks, and runtime logging.

This toolkit provides simple command-line utilities for gathering system information, monitoring disk usage, and diagnosing network connectivity.

Features
System Information — Collects essential system details, including hostname, current user, date and time, operating system, kernel version, uptime, CPU information, memory usage, and working directory.
Disk Usage Monitoring — Checks disk utilization against a configurable percentage threshold.
Network Diagnostics — Resolves hostnames and IP addresses, performs ICMP ping checks, inspects network interfaces, and optionally tests TCP port connectivity.
Runtime Logging — Records timestamped diagnostic results in log files.
Input Validation — Validates disk usage thresholds and TCP port numbers.
Automated Testing — Includes a grading script to verify the implementation against the project's requirements.
Included Scripts
1. system-info.sh

Collects and displays runtime system information, including:

Hostname
Current user
Current date and time
Operating system
Kernel version
System uptime
CPU information
Memory usage
Current working directory

Log file: logs/system-info.log

Each execution appends a timestamped entry to the log file.

2. disk-check.sh

Monitors disk usage against a specified percentage threshold.

Features:

Accepts a usage threshold between 1 and 100.
Defaults to the root filesystem (/) when no path is specified.
Supports checking a custom filesystem path.
Logs disk usage results to logs/disk-check.log.

Exit codes:

Exit Code	Description
0	Disk usage is below the specified threshold.
1	Disk usage has reached or exceeded the threshold.
2	Invalid input, such as an out-of-range or non-integer threshold.
3. network-check.sh

Performs network diagnostics against a specified hostname or IP address.

Features:

Resolves target hostnames and IP addresses.
Performs ICMP ping connectivity checks.
Inspects available network interfaces.
Optionally tests TCP connectivity to a specified port.
Supports TCP port numbers from 1 to 65535.
Logs diagnostic results to logs/network-check.log.
Prerequisites

Ensure the following are available in your Linux environment:

Linux operating system
Bash shell
Standard system utilities for retrieving system and disk information
Network utilities required for hostname resolution, ICMP ping, interface inspection, and TCP connectivity testing

The exact utilities required depend on how the scripts implement their checks.

Getting Started
1. Clone or Download the Repository

Download the project files and navigate to the project directory.

2. Make the Scripts Executable

Run the following command:

chmod +x system-info.sh disk-check.sh network-check.sh grade.sh

3. Run the Scripts
System Information

Display system details and append the results to the system information log:

./system-info.sh

Disk Usage Check

Check the root filesystem against an 80% usage threshold:

./disk-check.sh 80


Check the /var path against a 50% usage threshold:

./disk-check.sh 50 /var


The script returns an exit code indicating whether the threshold was exceeded or the input was invalid.

Network Connectivity Check

Resolve a hostname and perform a ping check:

./network-check.sh google.com


Check a hostname and test TCP connectivity to port 443 (HTTPS):

./network-check.sh google.com 443


Replace google.com with your desired hostname or IP address, and specify a TCP port when needed.

Logging

The toolkit stores diagnostic results in the following log files:

Script	Log File
system-info.sh	logs/system-info.log
disk-check.sh	logs/disk-check.log
network-check.sh	logs/network-check.log

The scripts append diagnostic entries to their respective logs, helping maintain a record of previous executions.

Ensure the scripts have permission to create and write to the logs/ directory.

Automated Testing

The project includes a local grading script to verify the implementation against the expected requirements.

Run the following commands:

chmod +x grade.sh
./grade.sh


Review the output to identify any failed checks or unmet requirements.

Example Project Structure
.
├── system-info.sh
├── disk-check.sh
├── network-check.sh
├── grade.sh
├── logs/
│   ├── system-info.log
│   ├── disk-check.log
│   └── network-check.log
└── README.md


Note: The structure above is illustrative. Adjust it to match the actual repository layout. Log files may be created automatically when the scripts run.

Use Cases
Linux system administration and monitoring
Disk capacity monitoring and threshold validation
Basic network troubleshooting
Runtime diagnostic logging and auditing
Bash scripting practice and automation
Learning shell scripting, input validation, and exit-code handling
License

No license has been specified. Consider adding a license file if you plan to distribute or publish the project publicly.
