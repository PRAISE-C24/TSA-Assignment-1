# TS Academy Assignment – Assignment 1

## Linux & Bash System Administration Toolkit

A collection of lightweight Bash scripts designed for Linux system monitoring, disk usage validation, network diagnostics, and runtime logging.

This toolkit provides command-line utilities for gathering system information, monitoring filesystem utilization, troubleshooting network connectivity, and recording diagnostic results in log files.

## Features

- **System Information:** Collects essential system details, including hostname, current user, date and time, operating system, kernel version, uptime, CPU information, memory usage, and working directory.
- **Disk Usage Monitoring:** Checks filesystem utilization against a configurable percentage threshold.
- **Network Diagnostics:** Resolves hostnames, performs ICMP ping checks, inspects network interfaces, and optionally tests TCP connectivity to a specified port.
- **Runtime Logging:** Records timestamped diagnostic results in dedicated log files.
- **Input Validation:** Validates disk usage thresholds and TCP port numbers.
- **Automated Testing:** Includes a grading script to verify implementation against the assignment requirements.

## Project Structure

```text
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
```

**Note:** The directory structure is illustrative. Adjust it to match the actual repository. Log files may be created automatically when the scripts run.

## Prerequisites

Ensure the following are available in your Linux environment:

- Linux operating system
- Bash shell
- Standard Linux utilities for retrieving system, CPU, memory, and disk information
- Network utilities for hostname resolution, ICMP ping, network interface inspection, and TCP connectivity testing

The exact utility dependencies depend on the implementation of each script.

## Getting Started

### 1. Clone or Download the Repository

Clone the repository and navigate to the project directory:

```bash
git clone <your-repository-url>
cd <your-repository-directory>
```

Replace the placeholders with your actual repository URL and directory name.

Alternatively, download the project files and navigate to their location.

### 2. Make the Scripts Executable

Run the following command from the project root:

```bash
chmod +x system-info.sh disk-check.sh network-check.sh grade.sh
```

### 3. Run the Scripts

#### System Information

Display essential system information and append a timestamped entry to the log:

```bash
./system-info.sh
```

**Log file:** `logs/system-info.log`

The script records information such as:

- Hostname and current user
- Current date and time
- Operating system and kernel version
- System uptime
- CPU information
- Memory usage
- Current working directory

#### Disk Usage Monitoring

Check the root filesystem against an 80% utilization threshold:

```bash
./disk-check.sh 80
```

Check the `/var` filesystem path against a 50% threshold:

```bash
./disk-check.sh 50 /var
```

The script accepts a threshold between `1` and `100`. If no path is supplied, it defaults to the root filesystem (`/`).

**Log file:** `logs/disk-check.log`

##### Disk Check Exit Codes

| Exit Code | Description |
|---|---|
| `0` | Disk usage is below the specified threshold. |
| `1` | Disk usage has reached or exceeded the threshold. |
| `2` | Invalid input, such as a non-integer or out-of-range threshold. |

These exit codes allow the script to be used in automation and monitoring workflows.

For example, a monitoring script can inspect the exit code to determine whether disk usage requires attention.

#### Network Diagnostics

Resolve a hostname and perform an ICMP ping check:

```bash
./network-check.sh google.com
```

Check hostname resolution and connectivity, including a TCP connection test to port `443`:

```bash
./network-check.sh google.com 443
```

You can replace `google.com` with another hostname or IP address and provide a TCP port between `1` and `65535` when required.

The script performs network diagnostics that include:

- Hostname and IP address resolution
- ICMP ping connectivity checks
- Network interface inspection
- Optional TCP port connectivity testing

**Log file:** `logs/network-check.log`

**Note:** A failed ping does not always mean a host is unreachable. Some hosts and networks block ICMP traffic while still allowing TCP connections.

## Logging

The toolkit maintains separate log files for each script.

| Script | Log File |
|---|---|
| `system-info.sh` | `logs/system-info.log` |
| `disk-check.sh` | `logs/disk-check.log` |
| `network-check.sh` | `logs/network-check.log` |

Each script appends diagnostic results to its respective log file, preserving a history of previous executions.

Ensure the scripts have permission to create the `logs/` directory and write to the log files. If the directory does not exist, the scripts should create it automatically if that behavior is implemented.

## Automated Testing

The project includes a grading script that checks the implementation against the assignment requirements.

Run the following commands:

```bash
chmod +x grade.sh
./grade.sh
```

Review the output to identify failed tests, incorrect behavior, or unmet requirements.

Run the grading script after making changes to verify that the scripts continue to satisfy the expected requirements.

## Use Cases

- Linux system administration and monitoring
- Filesystem capacity monitoring and threshold validation
- Basic network troubleshooting
- Runtime diagnostic logging and auditing
- Bash scripting practice and automation
- Learning input validation, exit-code handling, and command-line utilities

## Skills Demonstrated

This assignment demonstrates practical skills in:

- Bash scripting and Linux command-line operations
- System information collection
- Disk utilization monitoring
- Hostname resolution and network connectivity testing
- TCP port validation and connectivity checks
- Log file creation and timestamped logging
- Input validation and exit-code handling
- Automated testing and troubleshooting

## License

No license has been specified. Consider adding a `LICENSE` file if you plan to distribute or publish this project publicly.

---

**Assignment:** TS Academy – Assignment 1  
**Project:** Linux & Bash System Administration Toolkit  
**Purpose:** Develop practical Linux system administration skills through Bash scripting, monitoring, network diagnostics, logging, and automated validation.
