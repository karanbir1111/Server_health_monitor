#!/bin/bash

# ============================================
# Script  : System Health Monitor
# Author  : Karan
# ============================================

# --- Stop script if any command fails ---
set -e
set -o pipefail

echo "Starting server Health Check..."

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT="server_report_$DATE.txt"

# --- Azure Storage Details ---
STORAGE_ACCOUNT="tfstatedd9xg5"
CONTAINER="healthreports"

# ============================================
# SECTION 1: Generate the Report
# ============================================


echo "===== SYSTEM HEALTH REPORT =====" > $REPORT
echo "date: $DATE" >> $REPORT
echo "" >> $REPORT

echo "----- CPU USAGE -----" >> $REPORT
top -bn1 | grep "Cpu" >> $REPORT

echo "---- Memory Usage ----" >> $REPORT
free -h >> $REPORT
echo "" >> $REPORT

echo "---- Disk Usage ----" >> $REPORT
df -h >> $REPORT
echo "" >> $REPORT

echo "---- Top 5 Memory Consuming Processes ----" >> $REPORT
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 >> $REPORT

#System_Uptime
UPTIME=$(uptime -p)
echo "System Uptime: $UPTIME" >> $REPORT

echo "-----------------------------" >> $REPORT
echo "Report generated successfully: $REPORT"

# ============================================
# SECTION 2: Check Report Exists Before Upload
# ============================================

if [ ! -f "$REPORT" ]; then
    echo "ERROR: Report file '$REPORT' was not created. Exiting."
    exit 1
fi

if az storage blob upload \
    --account-name $STORAGE_ACCOUNT \
    --container-name $CONTAINER \
    --file $REPORT \
    --name $REPORT \
    --auth-mode login; then
    echo "✅ Report uploaded successfully to container '$CONTAINER'"
else
    echo "❌ Upload failed. Please check your Azure credentials and storage account."
    exit 1
fi


