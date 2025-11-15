# MAS-Pro v2.1.0 - Troubleshooting Guide

**Last Updated:** November 16, 2025  
**Version:** 2.1.0

---

## 🆘 Common Issues & Solutions

### **Issue 1: "Unexpected token '}' in expression or statement"**

**Symptoms:**
```
[ERROR] Failed to download full script: At line:964 char:1
+ }
+ ~ Unexpected token '}' in expression or statement.
```

**Causes:**
- GitHub CDN caching old version
- Corrupted download
- Network interruption

**Solutions:**

**Option A: Clear Cache (Recommended)**
```powershell
# Wait 5-10 minutes for GitHub cache to refresh
# Then try again:
irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 | iex
```

**Option B: Force Fresh Download**
```powershell
# Use cache-busting parameter
$timestamp = [System.DateTime]::UtcNow.Ticks
$url = "https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1?t=$timestamp"
irm $url | iex
```

**Option C: Local Installation**
```powershell
# Download and save locally first
$url = "https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1"
Invoke-WebRequest -Uri $url -OutFile "$env:USERPROFILE\Desktop\MAS-Pro.ps1"
PowerShell -ExecutionPolicy Bypass -File "$env:USERPROFILE\Desktop\MAS-Pro.ps1"
```

---

### **Issue 2: "Join-Path : Cannot bind argument to parameter 'Path' because it is an empty string"**

**Symptoms:**
```
Join-Path : Cannot bind argument to parameter 'Path' because it is an empty string.
At line:14 char:25
```

**Causes:**
- Running via `irm | iex` without proper online mode detection
- `$PSScriptRoot` is empty in online execution

**Solution:**
The script now automatically detects online mode and downloads the full script. If you still encounter this:

```powershell
# Use the -Online flag explicitly
PowerShell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 | iex"
```

---

### **Issue 3: "Access Denied" when installing to System Drive**

**Symptoms:**
```
[INSTALL] Failed to install to: C:\MAS-Pro\MAS-Pro.ps1
Access Denied
```

**Causes:**
- Insufficient permissions
- System drive protection
- Antivirus blocking

**Solutions:**

**Option A: Run as Administrator**
```powershell
# Right-click PowerShell → Run as Administrator
# Then run the script
```

**Option B: Install to User Directory Only**
```powershell
# Edit the script and modify $installPaths:
$installPaths = @(
    "$env:USERPROFILE\Desktop\MAS-Pro.ps1",
    "$env:USERPROFILE\Documents\MAS-Pro.ps1"
)
```

**Option C: Check Antivirus**
- Temporarily disable antivirus
- Add script to antivirus whitelist
- Check antivirus logs for blocked operations

---

### **Issue 4: "Failed to download: The remote name could not be resolved"**

**Symptoms:**
```
[ERROR] Failed to download: The remote name could not be resolved
```

**Causes:**
- No internet connection
- DNS resolution failure
- Network firewall blocking GitHub

**Solutions:**

**Option A: Check Internet Connection**
```powershell
# Test connectivity
Test-NetConnection -ComputerName github.com -Port 443
Test-NetConnection -ComputerName 8.8.8.8 -Port 53
```

**Option B: Use Alternative DNS**
```powershell
# Temporarily change DNS to Google Public DNS
# Settings → Network & Internet → Change adapter options
# → Right-click adapter → Properties → IPv4 → 8.8.8.8, 8.8.4.4
```

**Option C: Check Firewall**
```powershell
# Check Windows Firewall
Get-NetFirewallProfile | Select-Object Name, Enabled

# Temporarily disable (not recommended for production)
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled $false
```

**Option D: Use VPN**
- Connect to VPN if GitHub is blocked in your region
- Try from different network

---

### **Issue 5: "Windows is not activated" after running script**

**Symptoms:**
- Script runs successfully but Windows remains unactivated
- Activation status shows "Not activated"

**Causes:**
- System already has valid license
- Activation method not compatible with system
- Registry corruption
- KMS server unavailable

**Solutions:**

**Option A: Check Current Status**
```powershell
# Check Windows activation status
slmgr /xpr

# Check license status
slmgr /dli
```

**Option B: Manual Activation**
```powershell
# Install product key manually
slmgr /ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX

# Activate
slmgr /ato

# Check status
slmgr /xpr
```

**Option C: Reset Licensing**
```powershell
# Run as Administrator
# Clear licensing cache
slmgr /rearm

# Restart computer
Restart-Computer
```

**Option D: Try Different Method**
- If HWID fails, try KMS38
- If KMS38 fails, try Online KMS
- Check system compatibility

---

### **Issue 6: "Office is not activated" after running script**

**Symptoms:**
- Office shows "Not Activated"
- Watermark appears on documents
- Limited functionality

**Causes:**
- Office version not supported
- Ohook installation failed
- KMS server unavailable
- License file corrupted

**Solutions:**

**Option A: Check Office Version**
```powershell
# Find Office installation
Get-ChildItem "C:\Program Files\Microsoft Office" -Recurse | Where-Object {$_.Name -eq "ospp.vbs"}

# Check license status
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus
```

**Option B: Manual Office Activation**
```powershell
# Set KMS server
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /sethst:kms8.msguides.com

# Set port
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /setprt:1688

# Activate
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /act

# Check status
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus
```

**Option C: Reinstall Office**
```powershell
# Uninstall Office completely
# Download fresh from Microsoft
# Reinstall
# Run MAS-Pro again
```

---

### **Issue 7: Script runs but shows no output**

**Symptoms:**
- Script executes silently
- No progress messages
- No error messages

**Causes:**
- Output redirection
- Silent mode enabled
- Console buffering

**Solutions:**

**Option A: Run with Verbose Output**
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Verbose
```

**Option B: Redirect Output to File**
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" > "C:\MAS-Pro-Output.txt" 2>&1
```

**Option C: Check Event Viewer**
```powershell
# Open Event Viewer
eventvwr.msc

# Check Windows PowerShell logs
# Applications and Services Logs → Windows PowerShell
```

---

### **Issue 8: "WMI query failed" or "Security feature detection limited"**

**Symptoms:**
```
[SYSTEM] Security feature detection limited
[SYSTEM] WMI query failed
```

**Causes:**
- WMI service not running
- Insufficient permissions
- WMI repository corrupted

**Solutions:**

**Option A: Check WMI Service**
```powershell
# Check if WMI service is running
Get-Service winmgmt

# Start WMI service if stopped
Start-Service winmgmt

# Set to automatic startup
Set-Service winmgmt -StartupType Automatic
```

**Option B: Repair WMI Repository**
```powershell
# Run as Administrator
# Stop WMI service
Stop-Service winmgmt -Force

# Rebuild repository
Remove-Item "$env:SystemRoot\System32\wbem\Repository" -Recurse -Force

# Start WMI service
Start-Service winmgmt

# Verify
Get-WmiObject Win32_OperatingSystem
```

**Option C: Run as Administrator**
```powershell
# Right-click PowerShell → Run as Administrator
# Then run the script
```

---

### **Issue 9: "Registry update failed" messages**

**Symptoms:**
```
[KMS38-PRO] Registry update failed for HKLM:\SOFTWARE\...
```

**Causes:**
- Insufficient permissions
- Registry corruption
- Antivirus blocking
- Registry path doesn't exist

**Solutions:**

**Option A: Run as Administrator**
```powershell
# Essential for registry modifications
# Right-click PowerShell → Run as Administrator
```

**Option B: Check Registry Permissions**
```powershell
# Open Registry Editor
regedit

# Navigate to: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform

# Right-click → Permissions
# Ensure your user has Full Control
```

**Option C: Disable Antivirus Temporarily**
```powershell
# Temporarily disable antivirus
# Run the script
# Re-enable antivirus
```

---

### **Issue 10: "Activation attempt X of 5 failed" (repeated retries)**

**Symptoms:**
```
[HWID-PRO] Activation attempt 1 of 5...
[HWID-PRO] Activation attempt 2 of 5...
[HWID-PRO] Activation attempt 3 of 5...
```

**Causes:**
- Product key invalid for edition
- System time incorrect
- KMS server unavailable
- Network connectivity issues

**Solutions:**

**Option A: Check System Time**
```powershell
# Verify system time is correct
Get-Date

# If incorrect, sync with NTP server
w32tm /resync
```

**Option B: Check Product Key**
```powershell
# Verify product key matches Windows edition
slmgr /dli

# Check if key is valid for your edition
```

**Option C: Check Network**
```powershell
# Test KMS server connectivity
Test-NetConnection -ComputerName kms8.msguides.com -Port 1688

# If fails, try different KMS server
```

**Option D: Wait and Retry**
```powershell
# Wait 24 hours
# System may activate automatically
# Check status: slmgr /xpr
```

---

## 🔧 Advanced Troubleshooting

### **Enable Debug Mode**

```powershell
# Add to script for detailed logging
$DebugPreference = "Continue"
$VerbosePreference = "Continue"

# Run script
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"
```

### **Check Logs**

```powershell
# PowerShell event logs
Get-EventLog -LogName "Windows PowerShell" -Newest 50

# System event logs
Get-EventLog -LogName System -Newest 50 | Where-Object {$_.Source -like "*License*"}

# Application event logs
Get-EventLog -LogName Application -Newest 50
```

### **Manual Activation Testing**

```powershell
# Test HWID activation
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr /ato
slmgr /xpr

# Test KMS38 activation
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr /skms 127.0.0.1
slmgr /ato
slmgr /xpr
```

---

## 📞 Getting Help

### **If Issues Persist:**

1. **Check GitHub Issues**
   - https://github.com/joyelkhan/MAS-Pro/issues
   - Search for similar issues
   - Create new issue with details

2. **Provide Information**
   - Windows version: `[System.Environment]::OSVersion.Version`
   - Office version: `cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus`
   - Error message (full text)
   - Steps to reproduce

3. **Collect Logs**
   ```powershell
   # Save output to file
   PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" > "MAS-Pro-Log.txt" 2>&1
   
   # Include in issue report
   ```

---

## ✅ Verification Checklist

After running MAS-Pro, verify:

- [ ] Windows activation status: `slmgr /xpr`
- [ ] Office activation status: `cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus`
- [ ] No error messages in output
- [ ] System rebooted successfully (if required)
- [ ] All features working normally

---

## 🚀 Quick Recovery Steps

If something goes wrong:

```powershell
# 1. Check current status
slmgr /xpr
slmgr /dli

# 2. Reset licensing
slmgr /rearm

# 3. Restart computer
Restart-Computer

# 4. Try again
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"
```

---

**For more help, visit:** https://github.com/joyelkhan/MAS-Pro
