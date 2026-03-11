# 🖥️ System Health Monitor

A Bash script that automatically collects system health data and uploads timestamped reports to **Azure Blob Storage** — eliminating the need to manually check servers one by one.

---

## 📋 What It Does

- ✅ Collects **CPU usage** in real time
- ✅ Captures **Memory usage** (total, used, free)
- ✅ Reports **Disk usage** across all partitions
- ✅ Lists **Top 5 memory-consuming processes**
- ✅ Records **System uptime**
- ✅ Generates a **timestamped report file** automatically
- ✅ Uploads the report to **Azure Blob Storage** securely
- ✅ Built-in **error handling** — fails loud and early, not silently

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| Bash | Script automation |
| Azure CLI | Upload report to Azure Blob Storage |
| Azure Blob Storage | Cloud storage for reports |
| Azure AD Authentication | Secure login (no hardcoded credentials) |
| Linux / WSL | Runtime environment for the script |

---

## 📁 Project Structure

```
azure-health-monitor/
│
├── health_monitor.sh       # Main script
└── README.md               # Project documentation
```

---

## ✅ Prerequisites

Before running this script, make sure you have:

1. **Linux or WSL** installed on Windows
2. **Azure CLI** installed
3. **An Azure Storage Account** with a container named `healthreports`
4. **Azure login** completed via `az login`

---

## ⚙️ Setup & Installation

### Step 1 — Clone the Repository

```bash
git clone https://github.com/yourusername/serverz-health_monitor.git
cd azure-health-monitor
```

### Step 2 — Install Azure CLI (if not installed)

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Verify installation:
```bash
az --version
```

### Step 3 — Login to Azure

```bash
# If using WSL
az login --use-device-code

# If using native Linux
az login
```

Follow the instructions — open the link in your browser and enter the code shown in the terminal.

### Step 4 — Update Storage Details in Script

Open `health_monitor.sh` and update these two lines with your own values:

```bash
STORAGE_ACCOUNT="yourstorageaccount"   # ← your Azure storage account name
CONTAINER="healthreports"              # ← your container name
```

### Step 5 — Create Azure Storage Container (if not already created)

```bash
az storage container create \
    --account-name yourstorageaccount \
    --name healthreports \
    --auth-mode login
```

### Step 6 — Give Script Execute Permission

```bash
chmod +x health_monitor.sh
```

---

## 🚀 How to Run

```bash
./health_monitor.sh
```

---

## 📊 Sample Output

```
Starting server Health Check...

===== SYSTEM HEALTH REPORT =====
Date: 2026-03-10_06-09-04

----- CPU USAGE -----
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni, 100.0 id

---- Memory Usage ----
               total        used        free
Mem:           5.7Gi       590Mi       3.6Gi
Swap:          2.0Gi          0B       2.0Gi

---- Disk Usage ----
Filesystem      Size  Used Avail Use%
/dev/sdd       1007G  2.3G  954G   1%

---- Top 5 Memory Consuming Processes ----
  PID  PPID CMD                         %MEM %CPU
  220     1 /usr/bin/python3             0.3  0.0

System Uptime: up 10 minutes
-----------------------------

Report generated successfully: server_report_2026-03-10_06-09-04.txt
✅ Report uploaded successfully to container 'healthreports'
```

---

## 🔐 Security Practices Used

- **No hardcoded credentials** — uses `--auth-mode login` with Azure AD
- **`set -e`** — script stops immediately if any command fails
- **`set -o pipefail`** — catches errors inside piped commands
- **File existence check** — verifies report was created before attempting upload
- **Azure CLI check** — confirms Azure CLI is installed before running upload

---

## 🗺️ How It Works — Flow Diagram

```
Start Script
     │
     ▼
Collect System Data
(CPU, Memory, Disk, Processes, Uptime)
     │
     ▼
Generate Timestamped Report File
     │
     ▼
Check: Did report file get created?
     │
   Yes ▼
Check: Is Azure CLI installed?
     │
   Yes ▼
Upload Report to Azure Blob Storage
     │
     ▼
✅ Success / ❌ Fail with clear message
```

---

## 🔮 Future Improvements

- [ ] Schedule automatic runs every hour using `cron`
- [ ] Add email alerts when CPU or disk crosses threshold

---

## 👨‍💻 Author

**Karanbir Singh**
AZ-104 Certified | Computer Science & Networking Graduate | Cloud & DevOps in progress

- 🔗 [LinkedIn] https://www.linkedin.com/in/karanbir-singh-39945721a/
- 🐙 [GitHub] https://github.com/karanbir1111

---

## 📄 License

This project is open source and free to use under the [MIT License](LICENSE).
