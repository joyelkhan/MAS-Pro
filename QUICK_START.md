# MAS-Pro v1.0 - Quick Start Guide

**Author:** Abu Naser Khan (joyelkhan)  
**Repository:** https://github.com/joyelkhan/MAS-Pro

---

## 🚀 Quickest Start (30 seconds)

```powershell
irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 | iex
```

That's it! One command, everything else is automatic.

---

## 📋 Quick Reference

### For Different User Types

| User Type | Command | Time |
|-----------|---------|------|
| **End User** | `irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 \| iex` | 30s |
| **Advanced User** | `PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Install` | 1m |
| **Enterprise** | Batch script with multiple machines | 5m+ |
| **Admin** | `PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"` | 2m |

---

## 🎯 Common Tasks

### Install Locally
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Install
```
✅ Installs to Desktop, Documents, C:\MAS-Pro\

### Run Online (No Installation)
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Online
```
✅ Downloads and runs directly from GitHub

### Show Help Menu
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1" -Help
```
✅ Interactive menu with all options

### Quick Activation (Already Installed)
```powershell
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"
```
✅ Auto-detects and activates

---

## 🔧 Enterprise Deployment

### Silent Installation (No Prompts)
```powershell
PowerShell -ExecutionPolicy Bypass -NoProfile -Command {
    $url = 'https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1'
    Invoke-Expression (Invoke-WebRequest -Uri $url -UseBasicParsing).Content
}
```

### Deploy to Multiple Machines
```powershell
$computers = @("PC1", "PC2", "PC3")
foreach ($computer in $computers) {
    Invoke-Command -ComputerName $computer -ScriptBlock {
        PowerShell -ExecutionPolicy Bypass -File "\\server\share\MAS-Pro.ps1"
    }
}
```

### Scheduled Task (Auto-Activate at Startup)
```powershell
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" `
    -Argument "-ExecutionPolicy Bypass -File 'C:\MAS-Pro\MAS-Pro.ps1'"
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "MAS-Pro-Activation"
```

---

## ✅ Verify Activation

### Check Windows Activation
```powershell
slmgr /dli
```

### Check Office Activation
```powershell
cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus
```

---

## ⚠️ Troubleshooting

### Script Won't Run
```powershell
# Try this:
PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"

# Or run as Administrator:
# Right-click PowerShell → Run as Administrator
# Then: PowerShell -ExecutionPolicy Bypass -File "MAS-Pro.ps1"
```

### Activation Failed
1. ✅ Check internet connection
2. ✅ Run as Administrator
3. ✅ Disable antivirus temporarily
4. ✅ Verify system time is correct
5. ✅ Try again with `-Online` option

### Need Help
- 📖 **Documentation:** https://github.com/joyelkhan/MAS-Pro
- 🐛 **Issues:** https://github.com/joyelkhan/MAS-Pro/issues
- 👤 **Author:** Abu Naser Khan (joyelkhan)

---

## 📦 What Gets Installed

When you use `-Install`, MAS-Pro is copied to:
- `Desktop\MAS-Pro.ps1`
- `Documents\MAS-Pro.ps1`
- `C:\MAS-Pro\MAS-Pro.ps1`

All three locations have the same script for redundancy.

---

## 🔐 Safety Features

✅ Creates system restore point before activation  
✅ Non-destructive activation methods  
✅ Comprehensive error handling  
✅ Automatic cleanup of temporary files  
✅ No credentials stored or transmitted  
✅ All operations local to your system  

---

## 💡 Pro Tips

1. **First Time?** Use the one-liner: `irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 | iex`

2. **Need Offline?** Use `-Install` to save locally

3. **Enterprise?** Use batch deployment scripts

4. **Troubleshooting?** Run with `-Help` to see all options

5. **Contributing?** Clone the repo and submit pull requests

---

## 🎓 Learning Resources

- **Full Documentation:** See README.md
- **Technical Details:** See PROJECT_ANALYSIS.md
- **Source Code:** MAS-Pro Microsoft Activation Scripts Pro.ps1
- **GitHub:** https://github.com/joyelkhan/MAS-Pro

---

## 📞 Support

**Need Help?**
- Check README.md for detailed documentation
- Review PROJECT_ANALYSIS.md for technical details
- Visit GitHub repository for issues and discussions

**Report Issues:**
- GitHub Issues: https://github.com/joyelkhan/MAS-Pro/issues

---

**MAS-Pro v1.0** — Professional Windows and Office Activation  
**Author:** Abu Naser Khan (joyelkhan)  
**License:** MIT
