#!/bin/bash
echo 0 > /proc/sys/kernel/nmi_watchdog
modprobe msr
cpupower frequency-set -g userspace
cpupower frequency-set -f 2100000


