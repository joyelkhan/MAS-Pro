[START OUTPUT}
# MAS-Pro: Microsoft Activation Scripts Professional

<p align="center">
  <img src="https://img.shields.io/badge/Version-3.0.0-blue?style=for-the-badge&logo=windows">
  <img src="https://img.shields.io/badge/Platform-Windows-lightblue?style=for-the-badge&logo=windows">
  <img src="https://img.shields.io/badge/PowerShell-5.0+-blue?style=for-the-badge&logo=powershell">
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge">
</p>

<p align="center">
  <b>Professional-grade Windows & Office activation script with enterprise-level reliability</b>
</p>

## 🚀 Quick Start

### One-Line Installation & Activation
```powershell
irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 | iex
```

### Alternative Methods
```powershell
# Download and run directly
iwr -useb https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 | iex

# Local installation for offline use
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Install
```

## ✨ Features

### 🎯 Premium Activation Engine
- **Intelligent Method Selection** - Automatically chooses optimal activation method
- **Multi-Method Orchestration** - HWID, KMS38, Online KMS, Ohook with fallbacks
- **Enterprise Reliability** - Comprehensive error handling and retry logic
- **Smart Optimization** - Skips unnecessary methods when primary succeeds

### 🔍 Advanced System Analysis
- **Comprehensive Profiling** - Detailed hardware and software analysis
- **Security Feature Detection** - TPM, SecureBoot, UEFI, BitLocker status
- **Office Installation Scanning** - Automatic detection of all Office versions
- **Activation Status Tracking** - Real-time Windows and Office activation monitoring

### 🛠 Professional Tools
- **System Diagnostics** - Detailed hardware and activation reports
- **Troubleshooting Toolkit** - Advanced problem-solving utilities
- **Update Management** - Automatic version checking and updates
- **Network Testing** - Comprehensive connectivity verification

### 💎 User Experience
- **Premium UI/UX** - Professional interface with color schemes
- **Multiple Installation Modes** - Online, local, and silent deployments
- **Progress Tracking** - Real-time progress with step indicators
- **Comprehensive Logging** - Detailed execution logs and status reports

## 🖥️ Supported Products

### Windows Editions
| Version | HWID | KMS38 | Online KMS |
|---------|------|-------|------------|
| Windows 11 (All editions) | ✅ | ✅ | ✅ |
| Windows 10 (1809+) | ✅ | ✅ | ✅ |
| Windows 10 (Legacy) | ❌ | ✅ | ✅ |
| Windows 8.1 | ❌ | ✅ | ✅ |
| Windows 7 | ❌ | ❌ | ✅ |
| Server 2022/2019/2016 | ❌ | ✅ | ✅ |

### Microsoft Office
| Version | Ohook | KMS |
|---------|-------|-----|
| Office 2021/365 | ✅ | ✅ |
| Office 2019 | ✅ | ✅ |
| Office 2016 | ✅ | ✅ |
| Office 2013 | ❌ | ✅ |
| Office 2010 | ❌ | ✅ |

## 📥 Installation

### Method 1: One-Line Execution (Recommended)
```powershell
# Run directly from GitHub (no installation required)
irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 | iex
```

### Method 2: Local Installation
```powershell
# Download and install locally for offline use
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Install

# Run from local installation
PowerShell -ExecutionPolicy Bypass -File "$env:USERPROFILE\Desktop\MAS-Pro.ps1"
```

### Method 3: Manual Download
1. Download `MAS-Pro.ps1` from [Releases](https://github.com/joyelkhan/MAS-Pro/releases)
2. Right-click and "Run with PowerShell"
3. Or execute: `PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"`

## 🎮 Usage

### Automatic Activation (Recommended for most users)
1. Run MAS-Pro
2. Select **Option 1: Auto Activation**
3. The script will automatically:
   - Analyze your system
   - Select optimal activation methods
   - Execute with intelligent fallbacks
   - Provide comprehensive results

### Manual Method Selection
For advanced users who prefer manual control:

1. **HWID Activation** - Permanent digital license for Windows 10/11
2. **KMS38 Activation** - Local emulation until year 2038
3. **Online KMS** - 180-day activation with auto-renewal
4. **Office Activation** - Ohook (permanent) or KMS activation

### System Tools
- **System Diagnostics** - Comprehensive hardware and activation report
- **Advanced System Analysis** - Performance metrics, disk info, and system uptime
- **Activation Status** - Check current Windows and Office activation
- **Troubleshooting** - Advanced tools for problem resolution

## 🔧 Activation Methods

### HWID (Hardware ID) Activation
- **Type**: Permanent digital license
- **Requirements**: Windows 10/11, Internet connection
- **Duration**: Permanent
- **Best For**: Personal computers, permanent activation

### KMS38 Activation
- **Type**: Local KMS emulation
- **Requirements**: Windows 7+, No internet needed
- **Duration**: Until year 2038
- **Best For**: All Windows versions, offline use

### Online KMS Activation
- **Type**: Remote KMS server activation
- **Requirements**: Internet connection
- **Duration**: 180 days (auto-renewing)
- **Best For**: Temporary activation, testing

### Office Activation
- **Ohook**: Permanent activation for Office 2016+
- **KMS**: 180-day activation for all Office versions

## ⚙️ System Requirements

### Minimum Requirements
- **OS**: Windows 7 or later
- **PowerShell**: Version 5.0 or later
- **Architecture**: x86 or x64
- **Permissions**: Administrator rights

### Recommended Requirements
- **OS**: Windows 10/11 for full feature set
- **RAM**: 2GB or more
- **Storage**: 50MB free space
- **Network**: Internet connection for online features

## 🎯 Command Line Options

```powershell
# Installation and Update
-Install, -i          # Install MAS-Pro locally
-Online, -o           # Run directly from GitHub
-Update, -u           # Check for updates
-Help, -h, -?         # Show help information

# Execution Modes
-Silent, -s           # Silent mode (no prompts)
-Auto, -a             # Auto activation and exit

# Examples
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Install
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Silent -Auto
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Online
```

## 🔍 Troubleshooting

### Common Issues & Solutions

#### ❌ "Execution Policy Restricted"
```powershell
# Set execution policy temporarily
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

# Or run with bypass
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"
```

#### ❌ "Administrator Rights Required"
- Right-click PowerShell and "Run as Administrator"
- Or use: `Start-Process PowerShell -Verb RunAs`

#### ❌ "Network Connectivity Issues"
- Ensure internet connection for online features
- Use offline methods (HWID/KMS38) without internet
- Check firewall and antivirus settings

#### ❌ "Activation Failed"
1. Run **System Diagnostics** (Option 6)
2. Check **Activation Status** (Option 7)
3. Use **Troubleshooting Tools** (Option 8)
4. Try manual method selection

### Advanced Troubleshooting

#### Reset Windows Activation
```powershell
# Manual reset commands
slmgr /upk
slmgr /ckms
slmgr /rearm
```

#### Office Activation Issues
```powershell
# Reset Office licensing
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /rearm
```

## ❓ FAQ

### 🤔 Is MAS-Pro safe to use?
**Yes**, MAS-Pro uses only open-source, well-established activation methods and includes comprehensive safety features:
- No malware or viruses
- No data collection
- Automatic restore point creation
- Content validation before execution

### 🔒 Will this affect my system stability?
**No**, the activation methods used are non-invasive and reversible:
- No system files are modified
- No drivers are installed
- All changes can be reverted
- Built-in safety measures

### 🌐 Does it work without internet?
**Yes**, HWID and KMS38 methods work completely offline. Online features require internet connection.

### ⏰ How long does activation last?
- **HWID**: Permanent
- **KMS38**: Until 2038
- **Online KMS**: 180 days (auto-renews)
- **Ohook**: Permanent for Office

### 🔄 Can I revert activation?
**Yes**, all activation methods can be reversed:
- Use built-in troubleshooting tools
- Manual command line options available
- System restore points created automatically

### 🏢 Is it suitable for enterprise use?
**Yes**, MAS-Pro includes enterprise-grade features:
- Silent deployment mode
- Comprehensive logging
- Network awareness
- Professional reporting

## ⚖️ Legal

### Educational Purpose
MAS-Pro is provided for **educational and testing purposes only**. Use only on systems you own or have explicit permission to manage.

### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Disclaimer
- Use at your own risk
- The authors are not responsible for any damages
- Ensure compliance with local laws and Microsoft Terms of Service
- Intended for educational and testing environments

<p align="center">
  <b>MAS-Pro - Professional Activation Solutions</b><br>
  <i>Enterprise-grade reliability for Windows and Office activation</i>
</p>

<p align="center">
  <sub>Made with ❤️ for the open-source community</sub>
</p>
This README positions MAS-Pro as the **professional evolution** of activation scripts, maintaining the simplicity that made the original popular while adding enterprise-grade features and reliability for professional use cases.
