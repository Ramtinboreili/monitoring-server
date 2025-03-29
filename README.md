# 🖥️ Server Monitoring Script

A lightweight and extensible Bash script to analyze **basic server performance statistics**. Ideal for debugging, monitoring, or tracking system health over time.

---

## 📊 What It Does

The script `server-stats.sh` provides the following information:

- ✅ Total CPU usage
- ✅ Memory usage (used, free, percentage)
- ✅ Disk usage (used, free, percentage)
- ✅ Top 5 processes by CPU
- ✅ Top 5 processes by Memory
- ✅ System info (uptime, OS version, load average, logged-in users)
- ✅ Failed SSH login attempts
- ✅ Daily logs saved with timestamp
- ✅ Automatic Git commit and push of logs

---

## 🛠️ Setup

1. **Clone the repository:**

```bash
git clone https://github.com/Ramtinboreili/monitoring-server.git
cd monitoring-server
```

2. **Make the script executable:**

```bash
chmod +x server-stats.sh
```

3. **Create `logs/` directory (optional, auto-created on run):**

```bash
mkdir -p logs
```

---

## 🧪 Run the script manually

```bash
./server-stats.sh
```

This will:

- 🎨 Print all stats with colors to terminal
- 📝 Save a daily log to `logs/YYYY-MM-DD.log`
- 🔄 Automatically commit and push the log file to GitHub (branch: `main`)

---

## 🕙 Schedule with Cron (Run daily at 10 PM)

To automate daily reporting:

1. Open your crontab:

```bash
crontab -e
```

2. Add this line at the bottom:

```bash
0 22 * * * /bin/bash /full/path/to/monitoring-server/server-stats.sh
```

✅ Replace `/full/path/to/...` with the **absolute path** to your script.

---

## 📦 Sample Output

Log files are saved in the `logs/` folder like this:

```
logs/
├── 2025-03-28.log
├── 2025-03-29.log
└── ...
```

Each log contains stats like:

```
===== CPU Usage =====
CPU Usage: 15.2%

===== Memory Usage =====
Used: 1048MB | Free: 512MB | Usage: 67.18%

...
```

---

## 🔐 Notes

- Requires **Bash** and standard Linux tools: `top`, `ps`, `df`, `free`, `lsb_release`, `uptime`, etc.
- Make sure your Git repo is initialized and connected to a remote (`origin`).
- You should have SSH keys or GitHub token-based authentication set up for push to work without password prompts.

---

## 🙌 Author

**Ramtin Boreili**  
GitHub: [@Ramtinboreili](https://github.com/Ramtinboreili)

---

🔥 If you'd like to improve this further (e.g. generate HTML/JSON reports, email daily summaries, or build a dashboard), just open an issue or fork the repo!
