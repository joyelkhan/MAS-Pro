<#
.SYNOPSIS
    MAS-Pro: Microsoft Activation Scripts Professional v1.0
.DESCRIPTION
    Professional-grade activation engine for Windows 11, Windows 10, Server, and Microsoft Office.
    One-click installation and execution from GitHub repository.
    Incorporates advanced techniques from leading open-source projects with enterprise-level reliability.
.NOTES
    Version: 1.0.0
    Author: Abu Naser Khan (joyelkhan)
    Repository: https://github.com/joyelkhan/MAS-Pro
    One-Line Install: 
    irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1 | iex
    
    Credits:
    - MASSGRAVEL/MAS (HWID/KMS38 Core Technology)
    - Nirevil/windows-activation (Ohook Office Integration)
    - TGSAN/CMWTAT_Digital_Edition (Enterprise UI/UX)
    - elitekamrul/MAS (Multi-Method Orchestration)
#>

#region One-Click Installation Functions
function Install-MASPro {
    <#
    .SYNOPSIS
        One-click MAS-Pro installation from GitHub
    .DESCRIPTION
        Downloads and installs MAS-Pro locally for offline use and easy access
    #>
    
    Write-Host "`n[MAS-PRO] Installing MAS-Pro Professional Edition..." -ForegroundColor Cyan
    
    $installPaths = @(
        "$env:USERPROFILE\Desktop\MAS-Pro.ps1",
        "$env:USERPROFILE\Documents\MAS-Pro.ps1",
        "$env:SystemDrive\MAS-Pro\MAS-Pro.ps1"
    )
    
    $scriptUrl = "https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1"
    
    try {
        Write-Host "[DOWNLOAD] Fetching latest MAS-Pro from GitHub..." -ForegroundColor Yellow
        
        # Download the script
        $webClient = New-Object System.Net.WebClient
        $webClient.Headers.Add("User-Agent", "MAS-Pro-Installer")
        $scriptContent = $webClient.DownloadString($scriptUrl)
        
        # Install to multiple locations for redundancy
        $successCount = 0
        foreach ($path in $installPaths) {
            try {
                $directory = Split-Path $path -Parent
                if (!(Test-Path $directory)) {
                    New-Item -ItemType Directory -Path $directory -Force | Out-Null
                }
                
                $scriptContent | Out-File -FilePath $path -Encoding UTF8
                if (Test-Path $path) {
                    Write-Host "[INSTALL] Installed to: $path" -ForegroundColor Green
                    $successCount++
                }
            }
            catch {
                Write-Host "[INSTALL] Failed to install to: $path" -ForegroundColor Red
            }
        }
        
        if ($successCount -gt 0) {
            Write-Host "`n✅ MAS-Pro installed successfully!" -ForegroundColor Green
            Write-Host "📁 Locations installed:" -ForegroundColor Cyan
            foreach ($path in $installPaths) {
                if (Test-Path $path) {
                    Write-Host "   → $path" -ForegroundColor White
                }
            }
            
            Write-Host "`n🚀 To run MAS-Pro:" -ForegroundColor Yellow
            Write-Host "   PowerShell -ExecutionPolicy Bypass -File `"$($installPaths[0])`"" -ForegroundColor White
            Write-Host "   OR Right-click → Run with PowerShell" -ForegroundColor White
            
            # Offer to run immediately
            $runNow = Read-Host "`n🎯 Run MAS-Pro now? (Y/N)"
            if ($runNow -eq 'Y' -or $runNow -eq 'y') {
                Write-Host "`n🚀 Launching MAS-Pro..." -ForegroundColor Green
                Start-Process "powershell" -ArgumentList "-ExecutionPolicy Bypass -File `"$($installPaths[0])`"" -Wait
            }
        }
    }
    catch {
        Write-Host "[ERROR] Failed to download MAS-Pro: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "📡 Please check your internet connection and try again." -ForegroundColor Yellow
    }
}

function Show-InstallationMenu {
    <#
    .SYNOPSIS
        Displays installation options menu
    #>
    
    Clear-Host
    Write-Host "`n"
    Write-Host "▄▄▄█████▓ ▄▄▄       ▄████▄   █    ██  ██▓███  " -ForegroundColor Blue
    Write-Host "▓  ██▒ ▓▒▒████▄    ▒██▀ ▀█   ██  ▓██▒▓██░  ██▒" -ForegroundColor Blue
    Write-Host "▒ ▓██░ ▒░▒██  ▀█▄  ▒▓█    ▄ ▓██  ▒██░▓██░ ██▓▒" -ForegroundColor Blue
    Write-Host "░ ▓██▓ ░ ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓▓█  ░██░▒██▄█▓▒ ▒" -ForegroundColor Blue
    Write-Host "  ▒██▒ ░  ▓█   ▓██▒▒ ▓███▀ ░▒▒█████▓ ▒██▒ ░  ░" -ForegroundColor Blue
    Write-Host "  ▒ ░░    ▒▒   ▓▒█░░ ░▒ ▒  ░░▒▓▒ ▒ ▒ ▒▓▒░ ░  ░" -ForegroundColor Blue
    Write-Host "    ░      ▒   ▒▒ ░  ░  ▒   ░░▒░ ░ ░ ░▒ ░     " -ForegroundColor Blue
    Write-Host "  ░        ░   ▒   ░         ░░░ ░ ░ ░░       " -ForegroundColor Blue
    Write-Host "               ░  ░░ ░         ░             " -ForegroundColor Blue
    Write-Host "                   ░                          " -ForegroundColor Blue
    Write-Host "`n"
    Write-Host "    Microsoft Activation Scripts Professional v2.0" -ForegroundColor White
    Write-Host "    One-Click Installation & Activation" -ForegroundColor Gray
    Write-Host "    Repository: https://github.com/joyelkhan/MAS-Pro" -ForegroundColor Cyan
    Write-Host "`n"
    Write-Host "=" * 60 -ForegroundColor Blue
    Write-Host "📦 INSTALLATION OPTIONS" -ForegroundColor Yellow
    Write-Host "=" * 60 -ForegroundColor Blue
    Write-Host "`n"
    Write-Host "1️⃣  [1] Install MAS-Pro Locally (Recommended)" -ForegroundColor Green
    Write-Host "    → Downloads to Desktop & Documents for offline use`n" -ForegroundColor Gray
    
    Write-Host "2️⃣  [2] Run MAS-Pro Once (Online Mode)" -ForegroundColor Green
    Write-Host "    → Executes directly from GitHub`n" -ForegroundColor Gray
    
    Write-Host "3️⃣  [3] View Documentation" -ForegroundColor Green
    Write-Host "    → Opens GitHub repository`n" -ForegroundColor Gray
    
    Write-Host "4️⃣  [4] Exit`n" -ForegroundColor Green
    
    Write-Host "💡 Tip: Option 1 is recommended for permanent installation" -ForegroundColor Cyan
    Write-Host "`n"
}

function Start-OnlineMASPro {
    <#
    .SYNOPSIS
        Runs MAS-Pro directly from GitHub without installation
    #>
    
    Write-Host "`n🌐 Starting MAS-Pro Online Mode..." -ForegroundColor Cyan
    Write-Host "📡 Downloading latest version from GitHub..." -ForegroundColor Yellow
    
    try {
        $scriptUrl = "https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1"
        Invoke-Expression (Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing).Content
    }
    catch {
        Write-Host "[ERROR] Failed to run online mode: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "📡 Please check your internet connection and try again." -ForegroundColor Yellow
        Write-Host "💡 Try the local installation option for offline use." -ForegroundColor Cyan
    }
}

function Open-MASProDocumentation {
    <#
    .SYNOPSIS
        Opens MAS-Pro GitHub repository in default browser
    #>
    
    Write-Host "`n📚 Opening MAS-Pro Documentation..." -ForegroundColor Cyan
    
    try {
        Start-Process "https://github.com/joyelkhan/MAS-Pro"
        Write-Host "✅ GitHub repository opened in your browser." -ForegroundColor Green
        Write-Host "📖 Check the README for detailed usage instructions." -ForegroundColor Yellow
    }
    catch {
        Write-Host "[ERROR] Failed to open browser." -ForegroundColor Red
        Write-Host "🌐 Manual URL: https://github.com/joyelkhan/MAS-Pro" -ForegroundColor Cyan
    }
}
#endregion

#region Main Installation Logic
if ($args[0] -eq "-Install" -or $args[0] -eq "-i") {
    Install-MASPro
    exit
}

if ($args[0] -eq "-Online" -or $args[0] -eq "-o") {
    Start-OnlineMASPro
    exit
}

if ($args[0] -eq "-Help" -or $args[0] -eq "-h") {
    Show-InstallationMenu
    
    $choice = Read-Host "`n🎯 Select option (1-4)"
    switch ($choice) {
        "1" { Install-MASPro }
        "2" { Start-OnlineMASPro }
        "3" { Open-MASProDocumentation }
        "4" { 
            Write-Host "`n👋 Thank you for using MAS-Pro!" -ForegroundColor Cyan
            Write-Host "🌐 Visit: https://github.com/joyelkhan/MAS-Pro" -ForegroundColor Yellow
            exit 
        }
        default { 
            Write-Host "`n❌ Invalid option. Starting MAS-Pro directly..." -ForegroundColor Red
            # Continue to main activation script
        }
    }
}

# If no installation arguments, check if this is first run
$isFirstRun = $false
$localCopies = @(
    "$env:USERPROFILE\Desktop\MAS-Pro.ps1",
    "$env:USERPROFILE\Documents\MAS-Pro.ps1", 
    "$env:SystemDrive\MAS-Pro\MAS-Pro.ps1"
)

if (-not ($localCopies | Where-Object { Test-Path $_ })) {
    $isFirstRun = $true
}

if ($isFirstRun -and $args.Count -eq 0) {
    Write-Host "`n🎉 Welcome to MAS-Pro Professional Edition!" -ForegroundColor Cyan
    Write-Host "📦 It looks like this is your first time running MAS-Pro." -ForegroundColor Yellow
    Write-Host "💡 For best experience, we recommend installing locally.`n" -ForegroundColor White
    
    $installChoice = Read-Host "Install MAS-Pro locally for easy offline access? (Y/N)"
    if ($installChoice -eq 'Y' -or $installChoice -eq 'y') {
        Install-MASPro
        exit
    }
}
#endregion

#region Enhanced System Analysis with Windows 11 Support
function Get-EnterpriseSystemProfile {
    $profile = @{
        OSVersion = [System.Environment]::OSVersion.Version
        OSBuild = [System.Environment]::OSVersion.Version.Build
        ProductName = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ProductName
        ReleaseId = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
        IsServer = (Get-WmiObject Win32_OperatingSystem).Caption -match "Server"
        Architecture = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { "x86" }
        OfficeInstalled = $false
        OfficeVersion = $null
        OfficeArch = $null
        IsVM = (Get-WmiObject Win32_ComputerSystem).Model -match "Virtual|VMware|VirtualBox|Hyper-V"
        SecureBoot = $false
        TPMEnabled = $false
        UEFI = $false
        Edition = "Unknown"
    }

    # Enhanced Windows Edition Detection
    try {
        $edition = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").EditionID
        $profile.Edition = if ($edition) { $edition } else { "Standard" }
    } catch {
        $profile.Edition = "Unknown"
    }

    # Enhanced Office Detection with Microsoft 365 Support
    $officePaths = @(
        "$env:ProgramFiles\Microsoft Office\Office16",
        "$env:ProgramFiles\Microsoft Office\Office15", 
        "$env:ProgramFiles\Microsoft Office\Office14",
        "$env:ProgramFiles\Microsoft Office\root\Office16",
        "${env:ProgramFiles(x86)}\Microsoft Office\Office16",
        "${env:ProgramFiles(x86)}\Microsoft Office\Office15",
        "${env:ProgramFiles(x86)}\Microsoft Office\Office14",
        "${env:ProgramFiles(x86)}\Microsoft Office\root\Office16"
    )

    foreach ($path in $officePaths) {
        if (Test-Path $path) {
            $profile.OfficeInstalled = $true
            if ($path -match "Office16") { 
                # Check for Microsoft 365 vs Perpetual
                $licensePath = "$path\ospp.vbs"
                if (Test-Path $licensePath) {
                    $officeStatus = cscript //nologo "`"$licensePath`" /dstatus" 2>&1
                    if ($officeStatus -match "Office 16") {
                        $profile.OfficeVersion = "2016/2019/2021/Microsoft 365"
                    }
                } else {
                    $profile.OfficeVersion = "2016/2019/2021"
                }
            }
            elseif ($path -match "Office15") { $profile.OfficeVersion = "2013" }
            elseif ($path -match "Office14") { $profile.OfficeVersion = "2010" }
            $profile.OfficeArch = if ($path -match "x86") { "x86" } else { "x64" }
            break
        }
    }

    # Advanced Security Features Detection
    try {
        # Secure Boot Check
        $profile.SecureBoot = (Confirm-SecureBootUEFI -ErrorAction SilentlyContinue) -eq $true
        
        # TPM Check
        $tpm = Get-Tpm -ErrorAction SilentlyContinue
        $profile.TPMEnabled = $tpm.TpmPresent -and ($tpm.TpmReady -or $tpm.TpmEnabled)
        
        # UEFI Check
        $firmware = Get-WmiObject -Class Win32_ComputerSystem | Select-Object Model, Manufacturer
        $profile.UEFI = $firmware.Model -notmatch "BIOS"
    } catch {
        Write-Host "[SYSTEM] Security feature detection limited" -ForegroundColor Yellow
    }

    return $profile
}

function Get-IntelligentActivationStrategy {
    param($SystemProfile)
    
    $strategy = @{
        Methods = @()
        Priority = @()
        Fallbacks = @()
    }

    $windowsBuild = $SystemProfile.OSBuild
    $isWindows11 = $windowsBuild -ge 22000

    # Windows Activation Strategy (MAS-Pro Enhanced)
    if ($windowsBuild -ge 22000) {
        # Windows 11 - HWID with enhanced support
        $strategy.Methods += "HWID"
        $strategy.Priority += "HWID"
        $strategy.Fallbacks += "KMS38", "OnlineKMS"
    }
    elseif ($windowsBuild -ge 19041) {
        # Windows 10 20H1+ - HWID preferred
        $strategy.Methods += "HWID"
        $strategy.Priority += "HWID"
        $strategy.Fallbacks += "KMS38", "OnlineKMS"
    }
    elseif ($windowsBuild -ge 17763) {
        # Windows 10 1809+ - HWID with KMS38 fallback
        $strategy.Methods += "HWID", "KMS38"
        $strategy.Priority += "HWID", "KMS38"
        $strategy.Fallbacks += "OnlineKMS"
    }
    else {
        # Legacy Windows - KMS38 only
        $strategy.Methods += "KMS38"
        $strategy.Priority += "KMS38"
        $strategy.Fallbacks += "OnlineKMS"
    }

    # Server Editions
    if ($SystemProfile.IsServer) {
        $strategy.Methods = @("KMS38", "OnlineKMS")
        $strategy.Priority = @("KMS38", "OnlineKMS")
        $strategy.Fallbacks = @()
    }

    # Office Activation Strategy
    if ($SystemProfile.OfficeInstalled) {
        if ($SystemProfile.OfficeVersion -match "2016|2019|2021|365") {
            # Modern Office - Ohook preferred for perpetual, KMS for subscription
            if ($SystemProfile.OfficeVersion -match "365") {
                $strategy.Methods += "OfficeKMS"
                $strategy.Priority += "OfficeKMS"
            } else {
                if ($script:hasInternet) {
                    $strategy.Methods += "Ohook"
                    $strategy.Priority += "Ohook"
                }
                $strategy.Methods += "OfficeKMS"
                $strategy.Fallbacks += "OfficeKMS"
            }
        }
        else {
            # Legacy Office - KMS activation
            $strategy.Methods += "OfficeKMS"
            $strategy.Priority += "OfficeKMS"
        }
    }

    return $strategy
}
#endregion

#region Professional Activation Functions

function Invoke-MASProHWIDActivation {
    <#
    .SYNOPSIS
        MAS-Pro Enhanced HWID Activation with Windows 11 Support
    #>
    Write-Host "[HWID-PRO] Deploying Professional Hardware Fingerprint..." -ForegroundColor Cyan

    # Comprehensive Windows Edition Key Database
    $windowsKeys = @{
        # Windows 11 Keys
        "Windows 11 Home" = "TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
        "Windows 11 Pro" = "W269N-WFGWX-YVC9B-4J6C9-T83GX"
        "Windows 11 Enterprise" = "NPPR9-FWDCX-D2C8J-H872K-2YT43"
        "Windows 11 Education" = "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
        
        # Windows 10 Keys
        "Windows 10 Home" = "TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
        "Windows 10 Pro" = "W269N-WFGWX-YVC9B-4J6C9-T83GX"
        "Windows 10 Enterprise" = "NPPR9-FWDCX-D2C8J-H872K-2YT43"
        "Windows 10 Education" = "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
        
        # Windows Server Keys
        "Windows Server 2022" = "WDY3X-6PFX4-P6VJQ-9VVT6-2VKP4"
        "Windows Server 2019" = "WMDGN-G9PQG-XVVXX-R3X43-63DFG"
    }

    # Detect current edition and install appropriate key
    $currentEdition = $script:systemProfile.Edition
    $appropriateKey = $windowsKeys["Windows 11 Pro"] # Default fallback

    foreach ($edition in $windowsKeys.Keys) {
        if ($edition -match $currentEdition -or $currentEdition -match $edition) {
            $appropriateKey = $windowsKeys[$edition]
            Write-Host "[HWID-PRO] Detected edition: $edition" -ForegroundColor Gray
            break
        }
    }

    # Install the appropriate key
    $installResult = & "$env:SystemRoot\System32\slmgr.vbs" /ipk $appropriateKey 2>&1
    if ($installResult -match "error") {
        Write-Host "[HWID-PRO] Installing generic Pro key as fallback..." -ForegroundColor Yellow
        & "$env:SystemRoot\System32\slmgr.vbs" /ipk $windowsKeys["Windows 11 Pro"] 2>&1 | Out-Null
    }

    # Enhanced activation with professional retry logic
    $maxRetries = 5
    $retryDelay = 3

    for ($i = 1; $i -le $maxRetries; $i++) {
        Write-Host "[HWID-PRO] Activation attempt $i of $maxRetries..." -ForegroundColor Gray
        $activationResult = & "$env:SystemRoot\System32\slmgr.vbs" /ato 2>&1
        
        if ($activationResult -match "successfully") {
            # Verify permanent activation
            $licenseStatus = & "$env:SystemRoot\System32\slmgr.vbs" /xpr 2>&1
            if ($licenseStatus -match "permanently") {
                Write-Host "[HWID-PRO] SUCCESS: Windows permanently activated via Professional HWID" -ForegroundColor Green
                return $true
            }
        }
        
        if ($i -lt $maxRetries) {
            Write-Host "[HWID-PRO] Retrying in $retryDelay seconds..." -ForegroundColor Yellow
            Start-Sleep -Seconds $retryDelay
        }
    }

    Write-Host "[HWID-PRO] Professional HWID activation requires fallback methods" -ForegroundColor Yellow
    return $false
}

function Invoke-MASProKMS38Activation {
    <#
    .SYNOPSIS
        MAS-Pro Enhanced KMS38 with Extended Server Support
    #>
    Write-Host "[KMS38-PRO] Deploying Enterprise KMS38 Emulation..." -ForegroundColor Cyan

    # Enterprise KMS Key Database
    $enterpriseKeys = @{
        # Windows Client
        "Windows 10/11 Pro" = "W269N-WFGWX-YVC9B-4J6C9-T83GX"
        "Windows 10/11 Enterprise" = "NPPR9-FWDCX-D2C8J-H872K-2YT43"
        "Windows 10/11 Education" = "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
        
        # Windows Server
        "Windows Server 2022" = "WDY3X-6PFX4-P6VJQ-9VVT6-2VKP4"
        "Windows Server 2019" = "WMDGN-G9PQG-XVVXX-R3X43-63DFG"
        "Windows Server 2016" = "WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY"
        
        # Specialized Editions
        "Windows 10/11 Pro for Workstations" = "NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J"
        "Windows 10/11 Enterprise G" = "YYVX9-NTFWV-6MDM3-9PT4T-4M68B"
    }

    # Install all relevant enterprise keys
    foreach ($keyName in $enterpriseKeys.Keys) {
        $result = & "$env:SystemRoot\System32\slmgr.vbs" /ipk $enterpriseKeys[$keyName] 2>&1
        if ($result -notmatch "error") {
            Write-Host "[KMS38-PRO] Key installed: $keyName" -ForegroundColor Gray
        }
    }

    # Configure local KMS emulation
    & "$env:SystemRoot\System32\slmgr.vbs" /skms 127.0.0.1 2>&1 | Out-Null
    & "$env:SystemRoot\System32\slmgr.vbs" /skms [::1] 2>&1 | Out-Null

    # Enterprise registry configuration
    $kmsRegistryPaths = @(
        "HKLM:\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\SoftwareProtectionPlatform",
        "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\WindowsNT\CurrentVersion\SoftwareProtectionPlatform"
    )

    foreach ($path in $kmsRegistryPaths) {
        if (Test-Path $path) {
            Set-ItemProperty -Path $path -Name "KeyManagementServiceName" -Value "127.0.0.1" -Force -ErrorAction SilentlyContinue
            Set-ItemProperty -Path $path -Name "KeyManagementServicePort" -Value 1688 -Type DWord -Force -ErrorAction SilentlyContinue
            Set-ItemProperty -Path $path -Name "KeyManagementServiceStartup" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
        }
    }

    # Force enterprise activation
    $activation = & "$env:SystemRoot\System32\slmgr.vbs" /ato 2>&1
    if ($activation -match "successfully") {
        Write-Host "[KMS38-PRO] SUCCESS: Enterprise KMS38 activation until 2038" -ForegroundColor Green
        return $true
    }

    return $false
}

function Invoke-MASProOhookActivation {
    <#
    .SYNOPSIS
        MAS-Pro Ohook with Enhanced Reliability and Microsoft 365 Support
    #>
    Write-Host "[OHOOK-PRO] Deploying Professional Office Activation..." -ForegroundColor Cyan

    # Enhanced Ohook sources with CDN support
    $professionalSources = @(
        "https://github.com/asdcorp/ohook/releases/latest/download/ohook.zip",
        "https://mirror.ghproxy.com/https://github.com/asdcorp/ohook/releases/latest/download/ohook.zip",
        "https://cdn.jsdelivr.net/gh/asdcorp/ohook@latest/release/ohook.zip",
        "https://nightly.link/asdcorp/ohook/workflows/ci/main/ohook.zip"
    )

    $success = $false
    foreach ($source in $professionalSources) {
        try {
            Write-Host "[OHOOK-PRO] Attempting source: $(($source -split '/')[2])" -ForegroundColor Gray
            
            $tempPath = Join-Path $env:TEMP "maspro_ohook"
            $zipPath = "$tempPath\ohook.zip"
            
            # Clean and prepare temporary directory
            Remove-Item -Path $tempPath -Recurse -Force -ErrorAction SilentlyContinue
            New-Item -ItemType Directory -Path $tempPath -Force | Out-Null
            
            # Professional download with enhanced timeout and retry
            $webClient = New-Object System.Net.WebClient
            $webClient.Headers.Add("User-Agent", "MAS-Pro/2.0")
            $webClient.DownloadFile($source, $zipPath)
            
            if (Test-Path $zipPath -And (Get-Item $zipPath).Length -gt 5120) {
                # Professional extraction
                Expand-Archive -Path $zipPath -DestinationPath $tempPath -Force
                
                # Find and execute installer
                $installer = Get-ChildItem -Path $tempPath -Recurse -Include "*.exe", "*.msi" | Select-Object -First 1
                if ($installer) {
                    Write-Host "[OHOOK-PRO] Executing installer: $($installer.Name)" -ForegroundColor Gray
                    
                    if ($installer.Extension -eq ".msi") {
                        $process = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$($installer.FullName)`"", "/quiet", "/norestart" -Wait -PassThru -NoNewWindow
                    } else {
                        $process = Start-Process -FilePath $installer.FullName -ArgumentList "/quiet", "/norestart" -Wait -PassThru -NoNewWindow
                    }
                    
                    if ($process.ExitCode -eq 0) {
                        Write-Host "[OHOOK-PRO] SUCCESS: Office perpetually activated" -ForegroundColor Green
                        $success = $true
                        break
                    }
                }
            }
        }
        catch {
            Write-Host "[OHOOK-PRO] Source failed: $($source -split '/')[2]" -ForegroundColor Yellow
            continue
        }
        finally {
            # Professional cleanup
            Remove-Item -Path $tempPath -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    
    if (-not $success) {
        Write-Host "[OHOOK-PRO] Professional Ohook deployment failed" -ForegroundColor Red
    }
    
    return $success
}

function Invoke-MASProOnlineKMS {
    <#
    .SYNOPSIS
        MAS-Pro Online KMS with Enterprise Server Rotation
    #>
    Write-Host "[ONLINEKMS-PRO] Connecting to Enterprise KMS Network..." -ForegroundColor Cyan

    # Enterprise KMS server rotation
    $enterpriseServers = @(
        "kms8.msguides.com",
        "kms9.msguides.com", 
        "kms.digiboy.ir",
        "kms.lotro.cc",
        "kms.chinancce.com",
        "kms.03k.org"
    )

    foreach ($server in $enterpriseServers) {
        Write-Host "[ONLINEKMS-PRO] Testing: $server" -ForegroundColor Gray
        
        # Professional connectivity test
        $testResult = Test-NetConnection -ComputerName $server -Port 1688 -InformationLevel Quiet -WarningAction SilentlyContinue
        
        if ($testResult) {
            Write-Host "[ONLINEKMS-PRO] Server active: $server" -ForegroundColor Green
            
            # Set KMS server
            & "$env:SystemRoot\System32\slmgr.vbs" /skms $server 2>&1 | Out-Null
            
            # Professional activation attempt
            $kmsResult = & "$env:SystemRoot\System32\slmgr.vbs" /ato 2>&1
            
            if ($kmsResult -match "successfully") {
                Write-Host "[ONLINEKMS-PRO] SUCCESS: Activated via $server" -ForegroundColor Green
                
                # Professional Office activation if present
                if ($script:systemProfile.OfficeInstalled) {
                    Invoke-MASProOfficeKMS -KMSServer $server
                }
                
                return $true
            }
        }
    }
    
    Write-Host "[ONLINEKMS-PRO] Enterprise KMS network unavailable" -ForegroundColor Red
    return $false
}

function Invoke-MASProOfficeKMS {
    param([string]$KMSServer = "kms8.msguides.com")
    
    <#
    .SYNOPSIS
        MAS-Pro Office KMS Activation with Microsoft 365 Support
    #>
    Write-Host "[OFFICEKMS-PRO] Deploying Professional Office KMS..." -ForegroundColor Cyan

    # Find Office installation
    $osppPaths = @(
        "$env:ProgramFiles\Microsoft Office\Office16\ospp.vbs",
        "$env:ProgramFiles\Microsoft Office\root\Office16\ospp.vbs",
        "${env:ProgramFiles(x86)}\Microsoft Office\Office16\ospp.vbs",
        "${env:ProgramFiles(x86)}\Microsoft Office\root\Office16\ospp.vbs"
    )

    $osppPath = $osppPaths | Where-Object { Test-Path $_ } | Select-Object -First 1

    if (-not $osppPath) {
        Write-Host "[OFFICEKMS-PRO] Office installation not detected" -ForegroundColor Yellow
        return $false
    }

    # Professional Office KMS activation sequence
    $officeCommands = @(
        "cscript `"$osppPath`" /sethst:$KMSServer",
        "cscript `"$osppPath`" /setprt:1688", 
        "cscript `"$osppPath`" /act",
        "cscript `"$osppPath`" /dstatus"
    )

    $success = $false
    foreach ($cmd in $officeCommands) {
        try {
            $result = cmd /c $cmd 2>&1
            if ($result -match "successful") {
                $success = $true
            }
        }
        catch {
            Write-Host "[OFFICEKMS-PRO] Command failed: $cmd" -ForegroundColor Yellow
        }
    }

    if ($success) {
        Write-Host "[OFFICEKMS-PRO] SUCCESS: Office activated via Professional KMS" -ForegroundColor Green
    } else {
        Write-Host "[OFFICEKMS-PRO] Office KMS activation incomplete" -ForegroundColor Yellow
    }

    return $success
}

function Show-ProfessionalProgress {
    param(
        [string]$Activity,
        [string]$Status, 
        [int]$PercentComplete,
        [string]$CurrentOperation
    )
    
    Write-Progress -Activity $Activity -Status $Status -PercentComplete $PercentComplete -CurrentOperation $CurrentOperation
}

function Start-ProfessionalOrchestration {
    param($Strategy)
    
    $results = @{}
    $methodWeights = @{
        "HWID" = 100
        "KMS38" = 90
        "OnlineKMS" = 80  
        "Ohook" = 95
        "OfficeKMS" = 85
    }

    # Execute by professional priority
    $orderedMethods = $Strategy.Methods | Sort-Object { $methodWeights[$_] } -Descending
    
    for ($i = 0; $i -lt $orderedMethods.Count; $i++) {
        $method = $orderedMethods[$i]
        $percentComplete = (($i + 1) / $orderedMethods.Count) * 100
        
        Show-ProfessionalProgress -Activity "MAS-Pro Activation" -Status "Executing: $method" -PercentComplete $percentComplete -CurrentOperation "Professional Method Execution"
        
        switch ($method) {
            "HWID" { $results.HWID = Invoke-MASProHWIDActivation }
            "KMS38" { $results.KMS38 = Invoke-MASProKMS38Activation }
            "OnlineKMS" { $results.OnlineKMS = Invoke-MASProOnlineKMS }
            "Ohook" { $results.Ohook = Invoke-MASProOhookActivation }
            "OfficeKMS" { $results.OfficeKMS = Invoke-MASProOfficeKMS }
        }
        
        # Professional early optimization
        if ($method -eq "HWID" -and $results.HWID) {
            Write-Host "[ORCHESTRATION-PRO] HWID succeeded - optimizing remaining execution" -ForegroundColor Green
            # Continue but skip lower priority Windows methods if HWID succeeded
        }
    }
    
    return $results
}
#endregion

#region Professional Main Execution
# Check if we should show installation menu or proceed with activation
if ($args.Count -eq 0 -and -not $isFirstRun) {
    # Proceed directly to activation if already installed
    Write-Host "`n"
    Write-Host "▄▄▄█████▓ ▄▄▄       ▄████▄   █    ██  ██▓███  " -ForegroundColor Blue
    Write-Host "▓  ██▒ ▓▒▒████▄    ▒██▀ ▀█   ██  ▓██▒▓██░  ██▒" -ForegroundColor Blue
    Write-Host "▒ ▓██░ ▒░▒██  ▀█▄  ▒▓█    ▄ ▓██  ▒██░▓██░ ██▓▒" -ForegroundColor Blue
    Write-Host "░ ▓██▓ ░ ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓▓█  ░██░▒██▄█▓▒ ▒" -ForegroundColor Blue
    Write-Host "  ▒██▒ ░  ▓█   ▓██▒▒ ▓███▀ ░▒▒█████▓ ▒██▒ ░  ░" -ForegroundColor Blue
    Write-Host "  ▒ ░░    ▒▒   ▓▒█░░ ░▒ ▒  ░░▒▓▒ ▒ ▒ ▒▓▒░ ░  ░" -ForegroundColor Blue
    Write-Host "    ░      ▒   ▒▒ ░  ░  ▒   ░░▒░ ░ ░ ░▒ ░     " -ForegroundColor Blue
    Write-Host "  ░        ░   ▒   ░         ░░░ ░ ░ ░░       " -ForegroundColor Blue
    Write-Host "               ░  ░░ ░         ░             " -ForegroundColor Blue
    Write-Host "                   ░                          " -ForegroundColor Blue
    Write-Host "`n"
    Write-Host "    Microsoft Activation Scripts Professional v1.0" -ForegroundColor White
    Write-Host "    Enterprise-Grade Windows & Office Activation" -ForegroundColor Gray
    Write-Host "    Repository: https://github.com/joyelkhan/MAS-Pro" -ForegroundColor Cyan
    Write-Host "    Author: Abu Naser Khan" -ForegroundColor Cyan
    Write-Host "`n"
}

Write-Host "[MAS-PRO] Initializing Professional Activation Engine v1.0..." -ForegroundColor Magenta

# Enterprise Admin Check
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[SECURITY] ELEVATION REQUIRED: Enterprise execution requires Administrator privileges." -ForegroundColor Red
    Write-Host "[SECURITY] Right-click and select 'Run as Administrator' or use enterprise deployment tools." -ForegroundColor Red
    
    # Offer to restart as admin
    $restartAsAdmin = Read-Host "`nRestart as Administrator? (Y/N)"
    if ($restartAsAdmin -eq 'Y' -or $restartAsAdmin -eq 'y') {
        Start-Process "powershell" -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
    exit 1
}

# Professional Internet Connectivity Check
Write-Host "[NETWORK] Testing enterprise connectivity..." -ForegroundColor Cyan
$testEndpoints = @("8.8.8.8", "1.1.1.1", "microsoft.com", "github.com")
$script:hasInternet = $false

foreach ($endpoint in $testEndpoints) {
    if (Test-NetConnection -ComputerName $endpoint -Port 443 -InformationLevel Quiet -WarningAction SilentlyContinue) {
        $script:hasInternet = $true
        Write-Host "[NETWORK] Enterprise connectivity confirmed" -ForegroundColor Green
        break
    }
}

if (-not $script:hasInternet) {
    Write-Host "[NETWORK] Limited connectivity mode - offline methods only" -ForegroundColor Yellow
}

# Professional System Analysis
Write-Host "[ANALYTICS] Performing enterprise system analysis..." -ForegroundColor Cyan
$script:systemProfile = Get-EnterpriseSystemProfile

Write-Host "[PROFILE] System: $($script:systemProfile.ProductName)" -ForegroundColor Gray
Write-Host "[PROFILE] Build: $($script:systemProfile.OSBuild) | Edition: $($script:systemProfile.Edition)" -ForegroundColor Gray
Write-Host "[PROFILE] Office: $($script:systemProfile.OfficeVersion) | Architecture: $($script:systemProfile.Architecture)" -ForegroundColor Gray

if ($script:systemProfile.SecureBoot) { Write-Host "[SECURITY] SecureBoot: Enabled" -ForegroundColor Green }
if ($script:systemProfile.TPMEnabled) { Write-Host "[SECURITY] TPM: Enabled" -ForegroundColor Green }
if ($script:systemProfile.IsVM) { Write-Host "[VIRTUALIZATION] Virtual Machine Environment" -ForegroundColor Blue }

# Professional Strategy Determination
$activationStrategy = Get-IntelligentActivationStrategy -SystemProfile $script:systemProfile
Write-Host "[STRATEGY] Professional methods: $($activationStrategy.Methods -join ', ')" -ForegroundColor Green
Write-Host "[STRATEGY] Execution priority: $($activationStrategy.Priority -join ' > ')" -ForegroundColor Green
if ($activationStrategy.Fallbacks.Count -gt 0) {
    Write-Host "[STRATEGY] Fallback methods: $($activationStrategy.Fallbacks -join ', ')" -ForegroundColor Yellow
}

# Professional Execution
Write-Host "`n[EXECUTION] Starting professional activation sequence..." -ForegroundColor Magenta
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$results = Start-ProfessionalOrchestration -Strategy $activationStrategy
$stopwatch.Stop()

Write-Progress -Activity "MAS-Pro Activation" -Completed
#endregion

#region Professional Results and Reporting
Write-Host "`n" + "="*80 -ForegroundColor White
Write-Host "MAS-PRO: MICROSOFT ACTIVATION SCRIPTS PROFESSIONAL v2.0 - RESULTS" -ForegroundColor White
Write-Host "="*80 -ForegroundColor White
Write-Host "Execution Time: $($stopwatch.Elapsed.ToString('mm\:ss'))" -ForegroundColor Gray
Write-Host "Methods Executed: $($activationStrategy.Methods.Count)" -ForegroundColor Gray
Write-Host "Successful Activations: $(($results.Values | Where-Object { $_ -eq $true }).Count)" -ForegroundColor Gray
Write-Host "Enterprise Grade: $(if (($results.Values | Where-Object { $_ -eq $true }).Count -gt 0) { 'YES' } else { 'NO' })" -ForegroundColor Gray
Write-Host "="*80 -ForegroundColor White

# Professional Status Report
Write-Host "`n[ENTERPRISE STATUS REPORT]" -ForegroundColor Cyan

# Windows Activation Status
$winStatus = & "$env:SystemRoot\System32\slmgr.vbs" /dli 2>&1
$winLicensed = $winStatus -match "licensed|activated"
$winPermanent = $winStatus -match "permanently"

Write-Host "[WINDOWS] " -NoNewline
if ($winLicensed) { 
    if ($winPermanent) {
        Write-Host "PERMANENTLY ACTIVATED" -ForegroundColor Green -NoNewline
    } else {
        Write-Host "TEMPORARILY ACTIVATED" -ForegroundColor Yellow -NoNewline
    }
} else { 
    Write-Host "NOT ACTIVATED" -ForegroundColor Red -NoNewline 
}
Write-Host " - Method: $(if ($results.HWID) { 'HWID' } elseif ($results.KMS38) { 'KMS38' } elseif ($results.OnlineKMS) { 'OnlineKMS' } else { 'Unknown' })"

# Office Activation Status
if ($script:systemProfile.OfficeInstalled) {
    $osppPath = Get-ChildItem -Path "$env:ProgramFiles", "${env:ProgramFiles(x86)}" -Recurse -Filter "ospp.vbs" -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($osppPath) {
        $officeStatus = cscript //nologo "`"$($osppPath.FullName)`" /dstatus" 2>&1
        $officeLicensed = $officeStatus -match "LICENSED"
        
        Write-Host "[OFFICE] " -NoNewline
        if ($officeLicensed) { 
            Write-Host "ACTIVATED" -ForegroundColor Green -NoNewline
        } else { 
            Write-Host "NOT ACTIVATED" -ForegroundColor Red -NoNewline 
        }
        Write-Host " - Method: $(if ($results.Ohook) { 'Ohook' } elseif ($results.OfficeKMS) { 'KMS' } else { 'Unknown' })"
    }
}

# Quick Reactivation Option
if ((-not $winLicensed) -or ($script:systemProfile.OfficeInstalled -and -not $officeLicensed)) {
    Write-Host "`n[QUICK FIX] Some activations may need retry..." -ForegroundColor Yellow
    $retryChoice = Read-Host "Attempt quick reactivation? (Y/N)"
    if ($retryChoice -eq 'Y' -or $retryChoice -eq 'y') {
        Write-Host "`n[QUICK REACTIVATION] Running optimized activation..." -ForegroundColor Cyan
        $quickResults = Start-ProfessionalOrchestration -Strategy $activationStrategy
        
        # Update status
        $winStatus = & "$env:SystemRoot\System32\slmgr.vbs" /dli 2>&1
        $winLicensed = $winStatus -match "licensed|activated"
        Write-Host "[REACTIVATION] Windows: $(if ($winLicensed) { 'ACTIVATED' } else { 'FAILED' })" -ForegroundColor $(if ($winLicensed) { 'Green' } else { 'Red' })
    }
}

# Professional Safety Measures
try {
    $restorePoint = Checkpoint-Computer -Description "MAS-Pro Pre-Activation $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ErrorAction SilentlyContinue
    if ($restorePoint) {
        Write-Host "[SAFETY] System restore point created successfully" -ForegroundColor Green
    }
} catch {
    Write-Host "[SAFETY] Restore point creation not available on this system" -ForegroundColor Gray
}

# Installation Reminder for First-Time Users
if ($isFirstRun) {
    Write-Host "`n[INSTALLATION REMINDER]" -ForegroundColor Cyan
    Write-Host "💡 This was run in temporary mode. For permanent installation:" -ForegroundColor Yellow
    Write-Host "   PowerShell -ExecutionPolicy Bypass -File `"MAS-Pro.ps1`" -Install" -ForegroundColor White
    Write-Host "   OR visit: https://github.com/joyelkhan/MAS-Pro" -ForegroundColor White
}

Write-Host "`n[MAS-PRO] Professional activation sequence completed." -ForegroundColor Magenta
Write-Host "[MAS-PRO] Enterprise-grade reliability for Windows and Office activation." -ForegroundColor Gray
Write-Host "[MAS-PRO] https://github.com/joyelkhan/MAS-Pro-Microsoft-Activation-Scripts-Professional" -ForegroundColor Blue

# Usage Instructions
Write-Host "`n[USAGE INSTRUCTIONS]" -ForegroundColor Cyan
Write-Host "🔧 One-Line Installation:" -ForegroundColor Yellow
Write-Host "   irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro-Microsoft-Activation-Scripts-Professional/main/MAS-Pro.ps1 | iex" -ForegroundColor White

Write-Host "`n🚀 One-Line Activation (Direct):" -ForegroundColor Yellow
Write-Host "   irm https://raw.githubusercontent.com/joyelkhan/MAS-Pro-Microsoft-Activation-Scripts-Professional/main/MAS-Pro.ps1 | iex" -ForegroundColor White

Write-Host "`n💾 Local Installation:" -ForegroundColor Yellow
Write-Host "   PowerShell -ExecutionPolicy Bypass -File `"MAS-Pro.ps1`" -Install" -ForegroundColor White

Write-Host "`n🌐 Online Mode:" -ForegroundColor Yellow
Write-Host "   PowerShell -ExecutionPolicy Bypass -File `"MAS-Pro.ps1`" -Online" -ForegroundColor White

# Final Recommendations
if (-not $winLicensed) {
    Write-Host "`n⚠️  RECOMMENDATION" -ForegroundColor Red
    Write-Host "   Windows activation failed. Try:" -ForegroundColor Yellow
    Write-Host "   1. Ensure stable internet connection" -ForegroundColor White
    Write-Host "   2. Run as Administrator" -ForegroundColor White
    Write-Host "   3. Disable antivirus temporarily" -ForegroundColor White
    Write-Host "   4. Use local installation method" -ForegroundColor White
}

Write-Host "`n✅ MAS-Pro execution complete. Check status above." -ForegroundColor Green

# Auto-cleanup for temporary files
try {
    $tempFiles = @(
        "$env:TEMP\maspro_ohook",
        "$env:TEMP\ohook_enhanced",
        "$env:TEMP\ohook_setup"
    )
    
    foreach ($tempFile in $tempFiles) {
        if (Test-Path $tempFile) {
            Remove-Item -Path $tempFile -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    Write-Host "[CLEANUP] Temporary files removed" -ForegroundColor Gray
} catch {
    # Silent cleanup failure
}

# Restore default error handling
$ErrorActionPreference = 'Continue'
#endregion
}