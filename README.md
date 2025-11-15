# MAS-Pro: Microsoft Activation Scripts Professional v2.1

**Version:** 2.1.0  
**Author:** Abu Naser Khan (joyelkhan)  
**Repository:** https://github.com/joyelkhan/MAS-Pro  
**Status:** ✅ Production Ready

Professional-grade activation engine for Windows 11, Windows 10, Server, and Microsoft Office. Incorporates advanced techniques from leading open-source projects with enterprise-level reliability, intelligent method orchestration, comprehensive system analysis, and zero-touch deployment.

**New in v2.1.0:** Enhanced installation system, robust download validation, update detection, desktop shortcuts, advanced security detection, Microsoft 365 support, and professional error handling.

## Features

- **Professional HWID Activation** — Permanent Windows activation via hardware fingerprinting (Windows 11/10 optimized)
- **Enterprise KMS38** — Windows activation valid until 2038 with server support
- **Online KMS Network** — Enterprise KMS server rotation with automatic failover
- **Ohook Integration** — Multi-source Office perpetual activation with CDN support
- **Office KMS** — Modern Office and Microsoft 365 activation via professional KMS
- **Enterprise Strategy** — Intelligent method orchestration with priority-based execution
- **Advanced System Analysis** — Detects OS build, edition, architecture, Office version, SecureBoot, TPM, UEFI, and VM status
- **Professional Reporting** — Enterprise-grade activation status with detailed metrics
- **Safety & Reliability** — System restore points, comprehensive error handling, and professional logging

## Requirements

- **Windows 10/11** or **Windows Server 2016+**
- **Administrator privileges** (required for activation)
- **.NET Framework 4.5+** (included with modern Windows)
- **Internet connection** (optional, for online methods)

## Usage Examples

### For End Users (Easiest)

**One-Line Installation & Activation:**
```powershell
irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 | iex
```

**Or Download & Run Locally:**
1. Download `MAS-Pro.ps1` from GitHub
2. Right-click → "Run with PowerShell"
3. Select option 1 for installation
4. Script handles everything automatically

**Quick Start (Already Installed):**
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"
```

### For Advanced Users

**Installation with Custom Path:**
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Install
# Installs to: Desktop, Documents, C:\MAS-Pro\
```

**Online Mode (Direct from GitHub):**
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Online
```

**Interactive Menu:**
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Help
# Shows: Install, Run Online, View Docs, Exit
```

**View Documentation:**
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Help
# Option 3: Opens GitHub repository
```

### For Enterprise Deployment

**Silent Installation (No Prompts):**
```powershell
PowerShell -ExecutionPolicy Bypass -NoProfile -Command {
    $scriptUrl = 'https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1'
    Invoke-Expression (Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing).Content
}
```

**Batch Deployment Script:**
```powershell
# Deploy to multiple machines
$computers = @("PC1", "PC2", "PC3")
$scriptPath = "\\server\share\MAS-Pro.ps1"

foreach ($computer in $computers) {
    Invoke-Command -ComputerName $computer -ScriptBlock {
        PowerShell -ExecutionPolicy Bypass -File $using:scriptPath
    }
}
```

**Scheduled Task Activation:**
```powershell
# Create scheduled task for automatic activation
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" `
    -Argument "-ExecutionPolicy Bypass -File 'C:\MAS-Pro\MAS-Pro.ps1'"
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "MAS-Pro-Activation"
```

**Group Policy Deployment:**
```powershell
# Deploy via Group Policy (requires admin)
Copy-Item "MAS-Pro.ps1" "\\domain\SYSVOL\policies\scripts\"
# Configure GPO to run script at startup/logon
```

### For System Administrators

**Verify Activation Status:**
```powershell
# Check Windows activation
slmgr /dli

# Check Office activation
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus
```

**Reactivate System:**
```powershell
# Quick reactivation with retry
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"
# Select option 1 from menu for quick reactivation
```

**Troubleshooting:**
```powershell
# Run with verbose output
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Verbose

# Check system profile
Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber
```

### For Developers & Contributors

**Clone Repository:**
```powershell
git clone https://github.com/joyelkhan/MAS-Pro.git
cd MAS-Pro
```

**Test Locally:**
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro Microsoft Activation Scripts Pro.ps1"
```

**Modify & Test:**
```powershell
# Edit the script
notepad "MAS-Pro Microsoft Activation Scripts Pro.ps1"

# Test changes
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro Microsoft Activation Scripts Pro.ps1"
```

**Submit Changes:**
```powershell
git add .
git commit -m "Description of changes"
git push origin main
```

### Command-Line Arguments

| Argument | Usage | Example |
|----------|-------|---------|
| `-Install` or `-i` | Install locally | `MAS-Pro.ps1 -Install` |
| `-Online` or `-o` | Run from GitHub | `MAS-Pro.ps1 -Online` |
| `-Help` or `-h` | Show menu | `MAS-Pro.ps1 -Help` |
| (none) | Auto-detect & run | `MAS-Pro.ps1` |

### Execution Policies

**Temporary (Current Session Only):**
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"
```

**Permanent (All Sessions):**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
PowerShell -File "MAS-Pro.ps1"
```

**Restore Default:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope CurrentUser
```

## How It Works

### System Analysis
- Detects Windows build, Office version, and system architecture
- Checks for SecureBoot, TPM, and virtual machine status
- Verifies internet connectivity

### Professional Strategy
- **Windows 11** → HWID (primary) with KMS38 & OnlineKMS fallbacks
- **Windows 10 20H1+** → HWID (primary) with KMS38 & OnlineKMS fallbacks
- **Windows 10 1809+** → HWID with KMS38 fallback
- **Windows Server** → KMS38 with OnlineKMS fallback
- **Modern Office** → Ohook (if internet available) with OfficeKMS fallback
- **Microsoft 365** → OfficeKMS with professional KMS server rotation

### Professional Orchestration
Methods execute by priority weight (HWID: 100 > Ohook: 95 > KMS38: 90 > OfficeKMS: 85 > OnlineKMS: 80). Early optimization on critical success with intelligent fallback execution.

## Professional Innovations

Integrates proven techniques from:
- **MASSGRAVEL/MAS** — HWID/KMS38 core technology
- **Nirevil/windows-activation** — Ohook office integration
- **TGSAN/CMWTAT_Digital_Edition** — Enterprise UI/UX
- **elitekamrul/MAS** — Multi-method orchestration

**MAS-Pro Enhancements:**
- Windows 11 native support with edition detection
- Enterprise KMS server rotation with failover
- Microsoft 365 activation support
- Professional system analysis with UEFI/TPM detection
- CDN-backed Ohook deployment
- Priority-weighted method orchestration

## Enterprise Safety & Reliability

- Creates timestamped system restore points before activation
- Non-destructive activation methods with validation
- Comprehensive error handling and retry logic
- Professional logging with color-coded output
- Automatic fallback execution on method failure
- Enterprise-grade reliability metrics

## Disclaimer

This tool is for educational and testing purposes only. Use only on systems you own or have explicit permission to modify. Ensure compliance with your local laws and Microsoft's terms of service.

## License

MIT License — See LICENSE file for details.

---

**MAS-Pro: Microsoft Activation Scripts Professional v2.0** — Enterprise-grade reliability for Windows and Office activation.

## Version History

- **v2.0** (2025) — Professional release with Windows 11 support, enterprise KMS rotation, Microsoft 365 activation, priority-weighted orchestration, and advanced system analysis
- **v1.0** (2025) — Initial release with unified activation engine, intelligent orchestration, and comprehensive system analysis
