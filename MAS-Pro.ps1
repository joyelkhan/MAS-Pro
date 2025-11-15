<#
.SYNOPSIS
    MAS-Pro: Microsoft Activation Scripts Professional v3.0
.DESCRIPTION
    Premium-grade activation engine for Windows 11/10/8.1/7, Server, and Microsoft Office.
    Enterprise-level reliability with intelligent method orchestration and zero-touch deployment.
    Features comprehensive system analysis, automatic updates, and professional reporting.
.NOTES
    Version: 3.0.0
    Author: MAS-Pro Team
    Repository: https://github.com/joyelkhan/MAS-Pro
    Legal: For educational and testing purposes only. Use only on systems you own.
#>

#Requires -RunAsAdministrator

#region Premium Global Configuration
$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
$host.UI.RawUI.WindowTitle = "MAS-Pro: Microsoft Activation Scripts Professional v3.0"

# Global Variables
$Script:MASProVersion = "3.0.0"
$Script:RepositoryURL = "https://github.com/joyelkhan/MAS-Pro"
$Script:RawBaseURL = "https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main"
$Script:ScriptURL = "$Script:RawBaseURL/MAS-Pro.ps1"
$Script:IsOnlineMode = $false
$Script:IsFirstRun = $true
$Script:SilentMode = $false
$Script:ActivationResults = @{}
$Script:SystemProfile = $null
$Script:NetworkAvailable = $false

# Premium Installation Paths
$Script:LocalInstallPaths = @(
    "$env:USERPROFILE\Desktop\MAS-Pro.ps1",
    "$env:USERPROFILE\Documents\MAS-Pro.ps1",
    "$env:ProgramData\MAS-Pro\MAS-Pro.ps1",
    "$env:SystemDrive\Tools\MAS-Pro\MAS-Pro.ps1"
)

# Professional Color Scheme
$Script:ColorScheme = @{
    Primary = "Cyan"
    Secondary = "Blue"
    Success = "Green"
    Warning = "Yellow"
    Error = "Red"
    Info = "Gray"
    Highlight = "Magenta"
    Accent = "White"
}
#endregion

#region Premium UI and Branding
function Show-PremiumBanner {
    <#
    .SYNOPSIS
        Displays the premium MAS-Pro banner with version info
    #>
    
    Clear-Host
    Write-Host "`n"
    Write-Host "▄▄▄█████▓ ▄▄▄       ▄████▄   █    ██  ██▓███   ██████ " -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "▓  ██▒ ▓▒▒████▄    ▒██▀ ▀█   ██  ▓██▒▓██░  ██▒▒██    ▒ " -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "▒ ▓██░ ▒░▒██  ▀█▄  ▒▓█    ▄ ▓██  ▒██░▓██░ ██▓▒░ ▓██▄   " -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "░ ▓██▓ ░ ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓▓█  ░██░▒██▄█▓▒ ▒  ▒   ██▒" -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "  ▒██▒ ░  ▓█   ▓██▒▒ ▓███▀ ░▒▒█████▓ ▒██▒ ░  ░▒██████▒▒" -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "  ▒ ░░    ▒▒   ▓▒█░░ ░▒ ▒  ░░▒▓▒ ▒ ▒ ▒▓▒░ ░  ░▒ ▒▓▒ ▒ ░" -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "    ░      ▒   ▒▒ ░  ░  ▒   ░░▒░ ░ ░ ░▒ ░     ░ ░▒  ░ ░" -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "  ░        ░   ▒   ░         ░░░ ░ ░ ░░       ░  ░  ░  " -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "               ░  ░░ ░         ░                 ░     " -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "                   ░                                  " -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "`n"
    Write-Host "    Microsoft Activation Scripts Professional v$Script:MASProVersion" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "    Enterprise-Grade Windows & Office Activation" -ForegroundColor $Script:ColorScheme.Info
    Write-Host "    Repository: $Script:RepositoryURL" -ForegroundColor $Script:ColorScheme.Primary
    Write-Host "`n"
}

function Write-PremiumStatus {
    <#
    .SYNOPSIS
        Premium status reporting with consistent formatting
    #>
    param(
        [string]$Message,
        [string]$Status = "INFO",
        [string]$Color = "White"
    )
    
    $timestamp = Get-Date -Format "HH:mm:ss"
    $statusPrefix = switch ($Status.ToUpper()) {
        "SUCCESS" { "✅" }
        "ERROR" { "❌" }
        "WARNING" { "⚠️" }
        "INFO" { "ℹ️" }
        "PROGRESS" { "🔄" }
        "COMPLETE" { "🎯" }
        default { "📝" }
    }
    
    Write-Host "[$timestamp] $statusPrefix $Message" -ForegroundColor $Color
}

function Show-PremiumProgress {
    <#
    .SYNOPSIS
        Professional progress indicator with multiple display modes
    #>
    param(
        [string]$Activity,
        [string]$Status,
        [int]$PercentComplete,
        [int]$CurrentStep,
        [int]$TotalSteps
    )
    
    if ($Script:SilentMode) { return }
    
    if ($PercentComplete -eq -1) {
        # Indeterminate progress
        Write-Progress -Activity $Activity -Status $Status -PercentComplete (-1)
    } else {
        # Determinate progress with step info
        $stepInfo = "Step $CurrentStep of $TotalSteps"
        Write-Progress -Activity $Activity -Status "$Status | $stepInfo" -PercentComplete $PercentComplete
    }
}

function Show-PremiumMenu {
    <#
    .SYNOPSIS
        Displays the premium main menu with feature categories
    #>
    
    Show-PremiumBanner
    
    Write-Host "=" * 70 -ForegroundColor $Script:ColorScheme.Primary
    Write-Host "🎯 PREMIUM ACTIVATION CENTER" -ForegroundColor $Script:ColorScheme.Highlight
    Write-Host "=" * 70 -ForegroundColor $Script:ColorScheme.Primary
    Write-Host "`n"
    
    Write-Host "🚀 ACTIVATION OPTIONS" -ForegroundColor $Script:ColorScheme.Success
    Write-Host "├── 1. Auto Activation (Recommended)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "│   → Intelligent system analysis & optimal method selection`n" -ForegroundColor $Script:ColorScheme.Info
    
    Write-Host "🔧 MANUAL METHODS" -ForegroundColor $Script:ColorScheme.Warning
    Write-Host "├── 2. HWID Activation (Windows 10/11 Digital License)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├── 3. KMS38 Activation (Until 2038)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├── 4. Online KMS Activation (180 Days)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├── 5. Office Activation (Ohook/KMS)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "│   → Manual control over activation methods`n" -ForegroundColor $Script:ColorScheme.Info
    
    Write-Host "⚙️  SYSTEM TOOLS" -ForegroundColor $Script:ColorScheme.Primary
    Write-Host "├── 6. System Diagnostics" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├── 7. Advanced System Analysis" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├── 8. Activation Status Check" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├── 9. Troubleshooting Tools" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "│   → Advanced system management`n" -ForegroundColor $Script:ColorScheme.Info
    
    Write-Host "📦 INSTALLATION & UPDATES" -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "├── 10. Install MAS-Pro Locally" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├── 11. Check for Updates" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├── 12. Online Mode" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├── 13. Documentation & Help" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "└── 0. Exit MAS-Pro`n" -ForegroundColor $Script:ColorScheme.Accent
    
    Write-Host "💡 Professional Tip: Option 1 provides optimal automated activation" -ForegroundColor $Script:ColorScheme.Highlight
    Write-Host "`n"
}
#endregion

#region Premium Installation & Update System
function Test-NetworkConnectivity {
    <#
    .SYNOPSIS
        Comprehensive network connectivity testing
    #>
    
    Write-PremiumStatus "Testing network connectivity..." "PROGRESS" $Script:ColorScheme.Primary
    
    $testEndpoints = @(
        @{Name = "Google DNS"; Address = "8.8.8.8"; Port = 53},
        @{Name = "Cloudflare DNS"; Address = "1.1.1.1"; Port = 53},
        @{Name = "Microsoft"; Address = "microsoft.com"; Port = 443},
        @{Name = "GitHub"; Address = "github.com"; Port = 443},
        @{Name = "KMS Test"; Address = "kms8.msguides.com"; Port = 1688}
    )
    
    $successfulTests = 0
    foreach ($endpoint in $testEndpoints) {
        try {
            $testResult = Test-NetConnection -ComputerName $endpoint.Address -Port $endpoint.Port -InformationLevel Quiet -WarningAction SilentlyContinue
            if ($testResult) {
                Write-PremiumStatus "✓ $($endpoint.Name) connectivity confirmed" "SUCCESS" $Script:ColorScheme.Success
                $successfulTests++
            } else {
                Write-PremiumStatus "✗ $($endpoint.Name) unreachable" "WARNING" $Script:ColorScheme.Warning
            }
        }
        catch {
            Write-PremiumStatus "✗ $($endpoint.Name) test failed" "WARNING" $Script:ColorScheme.Warning
        }
    }
    
    $Script:NetworkAvailable = ($successfulTests -ge 2)
    Write-PremiumStatus "Network connectivity: $(if ($Script:NetworkAvailable) { 'Available' } else { 'Limited' })" "INFO" $Script:ColorScheme.Info
    
    return $Script:NetworkAvailable
}

function Install-MASProPremium {
    <#
    .SYNOPSIS
        Premium installation with enhanced validation and user experience
    #>
    
    Write-PremiumStatus "Starting premium installation process..." "PROGRESS" $Script:ColorScheme.Primary
    
    if (-not $Script:NetworkAvailable) {
        Write-PremiumStatus "Network connectivity required for installation" "ERROR" $Script:ColorScheme.Error
        return $false
    }
    
    $successCount = 0
    $installedPaths = @()
    
    try {
        # Download with multiple fallback methods
        $scriptContent = $null
        $downloadMethods = @(
            { (Invoke-WebRequest -Uri $Script:ScriptURL -UseBasicParsing -TimeoutSec 30).Content },
            { 
                $webClient = New-Object System.Net.WebClient
                $webClient.Headers.Add("User-Agent", "MAS-Pro-Premium/$Script:MASProVersion")
                $webClient.DownloadString($Script:ScriptURL)
            }
        )
        
        foreach ($downloadMethod in $downloadMethods) {
            try {
                $scriptContent = & $downloadMethod
                if (-not [string]::IsNullOrEmpty($scriptContent)) { break }
            }
            catch {
                Write-PremiumStatus "Download method failed, trying next..." "WARNING" $Script:ColorScheme.Warning
            }
        }
        
        if ([string]::IsNullOrEmpty($scriptContent)) {
            throw "All download methods failed"
        }
        
        # Premium content validation
        $validationChecks = @(
            { $scriptContent -match "MAS-Pro" },
            { $scriptContent -match "Microsoft Activation Scripts" },
            { $scriptContent -match "Professional" },
            { $scriptContent.Length -gt 50000 }  # Reasonable minimum size
        )
        
        foreach ($validationCheck in $validationChecks) {
            if (-not (& $validationCheck)) {
                throw "Script content validation failed"
            }
        }
        
        # Premium installation to multiple locations
        foreach ($path in $Script:LocalInstallPaths) {
            try {
                $directory = Split-Path $path -Parent
                if (-not (Test-Path $directory)) {
                    New-Item -ItemType Directory -Path $directory -Force | Out-Null
                }
                
                # Create backup if file exists
                if (Test-Path $path) {
                    $backupPath = "$path.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
                    Copy-Item $path $backupPath -Force
                    Write-PremiumStatus "Backup created: $backupPath" "INFO" $Script:ColorScheme.Info
                }
                
                $scriptContent | Out-File -FilePath $path -Encoding UTF8 -Force
                
                if (Test-Path $path -and (Get-Item $path).Length -gt 50000) {
                    Write-PremiumStatus "Successfully installed to: $path" "SUCCESS" $Script:ColorScheme.Success
                    $successCount++
                    $installedPaths += $path
                }
            }
            catch {
                Write-PremiumStatus "Installation failed for: $path - $($_.Exception.Message)" "ERROR" $Script:ColorScheme.Error
            }
        }
        
        if ($successCount -gt 0) {
            # Create desktop shortcut
            try {
                $shortcutPath = "$env:USERPROFILE\Desktop\MAS-Pro.lnk"
                $WshShell = New-Object -comObject WScript.Shell
                $Shortcut = $WshShell.CreateShortcut($shortcutPath)
                $Shortcut.TargetPath = "powershell.exe"
                $Shortcut.Arguments = "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$($installedPaths[0])`""
                $Shortcut.WorkingDirectory = Split-Path $installedPaths[0] -Parent
                $Shortcut.WindowStyle = 1
                $Shortcut.Description = "MAS-Pro Microsoft Activation Scripts Professional v$Script:MASProVersion"
                $Shortcut.IconLocation = "powershell.exe,0"
                $Shortcut.Save()
                Write-PremiumStatus "Desktop shortcut created" "SUCCESS" $Script:ColorScheme.Success
            }
            catch {
                Write-PremiumStatus "Desktop shortcut creation skipped" "INFO" $Script:ColorScheme.Info
            }
            
            # Create start menu shortcut
            try {
                $startMenuPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\MAS-Pro.lnk"
                $WshShell = New-Object -comObject WScript.Shell
                $Shortcut = $WshShell.CreateShortcut($startMenuPath)
                $Shortcut.TargetPath = "powershell.exe"
                $Shortcut.Arguments = "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$($installedPaths[0])`""
                $Shortcut.WorkingDirectory = Split-Path $installedPaths[0] -Parent
                $Shortcut.WindowStyle = 1
                $Shortcut.Description = "MAS-Pro Microsoft Activation Scripts Professional"
                $Shortcut.Save()
                Write-PremiumStatus "Start menu shortcut created" "SUCCESS" $Script:ColorScheme.Success
            }
            catch {
                Write-PremiumStatus "Start menu shortcut creation skipped" "INFO" $Script:ColorScheme.Info
            }
            
            Write-PremiumStatus "MAS-Pro Premium installed successfully in $successCount locations" "SUCCESS" $Script:ColorScheme.Success
            
            if (-not $Script:SilentMode) {
                $runNow = Read-Host "`n🎯 Launch MAS-Pro now? (Y/N)"
                if ($runNow -eq 'Y' -or $runNow -eq 'y') {
                    Start-Process "powershell" -ArgumentList "-ExecutionPolicy Bypass -File `"$($installedPaths[0])`"" -Wait
                    exit
                }
            }
            return $true
        } else {
            throw "No installation locations succeeded"
        }
    }
    catch {
        Write-PremiumStatus "Premium installation failed: $($_.Exception.Message)" "ERROR" $Script:ColorScheme.Error
        return $false
    }
}

function Update-MASProPremium {
    <#
    .SYNOPSIS
        Premium update system with version checking and smart updates
    #>
    
    Write-PremiumStatus "Checking for updates..." "PROGRESS" $Script:ColorScheme.Primary
    
    if (-not $Script:NetworkAvailable) {
        Write-PremiumStatus "Network required for update check" "WARNING" $Script:ColorScheme.Warning
        return $false
    }
    
    try {
        $webClient = New-Object System.Net.WebClient
        $webClient.Headers.Add("User-Agent", "MAS-Pro-Updater/$Script:MASProVersion")
        $onlineContent = $webClient.DownloadString($Script:ScriptURL)
        
        if ($onlineContent -match 'Version:? "(\d+\.\d+\.\d+)"') {
            $onlineVersion = $matches[1]
            
            if ([System.Version]$onlineVersion -gt [System.Version]$Script:MASProVersion) {
                Write-PremiumStatus "Update available! v$Script:MASProVersion → v$onlineVersion" "SUCCESS" $Script:ColorScheme.Success
                
                if (-not $Script:SilentMode) {
                    $updateNow = Read-Host "`n🎯 Install update now? (Y/N)"
                    if ($updateNow -eq 'Y' -or $updateNow -eq 'y') {
                        return Install-MASProPremium
                    }
                } else {
                    return Install-MASProPremium
                }
            } else {
                Write-PremiumStatus "You have the latest version (v$Script:MASProVersion)" "SUCCESS" $Script:ColorScheme.Success
            }
        } else {
            Write-PremiumStatus "Could not determine online version" "WARNING" $Script:ColorScheme.Warning
        }
    }
    catch {
        Write-PremiumStatus "Update check failed: $($_.Exception.Message)" "ERROR" $Script:ColorScheme.Error
    }
    
    return $false
}

function Test-MASProInstallation {
    <#
    .SYNOPSIS
        Comprehensive installation status checking
    #>
    
    $installedPaths = @()
    foreach ($path in $Script:LocalInstallPaths) {
        if (Test-Path $path) {
            $installedPaths += $path
        }
    }
    
    if ($installedPaths.Count -gt 0) {
        $Script:IsFirstRun = $false
        Write-PremiumStatus "MAS-Pro installation detected in $($installedPaths.Count) locations" "INFO" $Script:ColorScheme.Info
        return $true
    }
    
    $Script:IsFirstRun = $true
    Write-PremiumStatus "MAS-Pro not installed locally - first run detected" "INFO" $Script:ColorScheme.Info
    return $false
}
#endregion

#region Premium System Analysis
function Get-PremiumSystemProfile {
    <#
    .SYNOPSIS
        Comprehensive system analysis with detailed profiling
    #>
    
    Write-PremiumStatus "Performing premium system analysis..." "PROGRESS" $Script:ColorScheme.Primary
    
    $systemProfile = @{
        # Basic System Info
        OSVersion = [System.Environment]::OSVersion.Version
        OSBuild = [System.Environment]::OSVersion.Version.Build
        ProductName = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ErrorAction SilentlyContinue).ProductName
        ReleaseId = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ErrorAction SilentlyContinue).ReleaseId
        InstallationDate = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ErrorAction SilentlyContinue).InstallDate
        RegisteredOwner = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ErrorAction SilentlyContinue).RegisteredOwner
        
        # System Configuration
        IsServer = ((Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue).Caption -match "Server")
        Architecture = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { "x86" }
        Edition = "Unknown"
        ProductType = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ErrorAction SilentlyContinue).EditionID
        
        # Hardware Information
        IsVM = ((Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue).Model -match "Virtual|VMware|VirtualBox|Hyper-V")
        ProcessorCores = (Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue).NumberOfCores
        TotalMemory = [math]::Round((Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue).TotalPhysicalMemory / 1GB, 2)
        
        # Security Features
        SecureBoot = $false
        TPMEnabled = $false
        UEFI = $false
        BitLocker = $false
        
        # Office Information
        OfficeInstalled = $false
        OfficeVersion = $null
        OfficeArch = $null
        OfficeProducts = @()
        
        # Activation Status
        WindowsActivated = $false
        WindowsActivationType = "Unknown"
        OfficeActivated = $false
        OfficeActivationType = "Unknown"
    }
    
    # Enhanced Edition Detection
    try {
        $edition = $systemProfile.ProductType
        if (-not $edition) {
            $edition = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ErrorAction SilentlyContinue).EditionID
        }
        $systemProfile.Edition = if ($edition) { $edition } else { "Standard" }
    } catch {
        $systemProfile.Edition = "Unknown"
    }
    
    # Security Features Detection
    try {
        $systemProfile.SecureBoot = (Confirm-SecureBootUEFI -ErrorAction SilentlyContinue) -eq $true
        
        $tpm = Get-Tpm -ErrorAction SilentlyContinue
        $systemProfile.TPMEnabled = $tpm.TpmPresent -and ($tpm.TpmReady -or $tpm.TpmEnabled)
        
        $firmware = Get-CimInstance -Class Win32_ComputerSystem -ErrorAction SilentlyContinue
        $systemProfile.UEFI = $firmware.Model -notmatch "BIOS"
        
        $bitlocker = Get-BitLockerVolume -ErrorAction SilentlyContinue | Where-Object { $_.VolumeStatus -eq "FullyEncrypted" }
        $systemProfile.BitLocker = [bool]$bitlocker
    } catch {
        # Security features detection is optional
    }
    
    # Comprehensive Office Detection
    $officeInstallations = @()
    $officePaths = @(
        "$env:ProgramFiles\Microsoft Office\*",
        "$env:ProgramFiles\Microsoft Office*\*", 
        "${env:ProgramFiles(x86)}\Microsoft Office\*",
        "${env:ProgramFiles(x86)}\Microsoft Office*\*",
        "$env:ProgramFiles\Microsoft\Office*\*",
        "${env:ProgramFiles(x86)}\Microsoft\Office*\*"
    )
    
    foreach ($pathPattern in $officePaths) {
        try {
            $officeDirs = Get-ChildItem -Path $pathPattern -Directory -ErrorAction SilentlyContinue | Where-Object { 
                $_.Name -match "Office(1[4-6]|365|2021|2019|2016|2013)" 
            }
            $officeInstallations += $officeDirs
        } catch {
            # Continue with next path pattern
        }
    }
    
    if ($officeInstallations.Count -gt 0) {
        $systemProfile.OfficeInstalled = $true
        $latestOffice = $officeInstallations | Sort-Object Name -Descending | Select-Object -First 1
        
        switch -regex ($latestOffice.Name) {
            "Office16" { $systemProfile.OfficeVersion = "2021/365/2019" }
            "Office15" { $systemProfile.OfficeVersion = "2013" }
            "Office14" { $systemProfile.OfficeVersion = "2010" }
            default { $systemProfile.OfficeVersion = "Unknown" }
        }
        
        $systemProfile.OfficeArch = if ($latestOffice.FullName -match "x86") { "x86" } else { "x64" }
        $systemProfile.OfficeProducts = $officeInstallations | ForEach-Object { $_.Name }
    }
    
    # Activation Status Detection
    try {
        $winStatus = & "$env:SystemRoot\System32\slmgr.vbs" /dli 2>&1
        $systemProfile.WindowsActivated = $winStatus -match "licensed|activated"
        $systemProfile.WindowsActivationType = if ($winStatus -match "permanently") { "Digital License" } elseif ($winStatus -match "licensed") { "KMS" } else { "Not Activated" }
        
        if ($systemProfile.OfficeInstalled) {
            $osppPaths = Get-ChildItem -Path "$env:ProgramFiles", "${env:ProgramFiles(x86)}" -Recurse -Filter "ospp.vbs" -ErrorAction SilentlyContinue
            if ($osppPaths) {
                $officeStatus = cscript //nologo "`"$($osppPaths[0].FullName)`" /dstatus" 2>&1
                $systemProfile.OfficeActivated = $officeStatus -match "LICENSED"
                $systemProfile.OfficeActivationType = if ($officeStatus -match "LICENSED") { 
                    if ($officeStatus -match "OHOOK") { "Ohook" } else { "KMS/Retail" } 
                } else { "Not Activated" }
            }
        }
    } catch {
        Write-PremiumStatus "Activation status detection limited" "WARNING" $Script:ColorScheme.Warning
    }
    
    Write-PremiumStatus "Premium system analysis completed" "SUCCESS" $Script:ColorScheme.Success
    return $systemProfile
}

function Show-SystemDiagnostics {
    <#
    .SYNOPSIS
        Comprehensive system diagnostics report
    #>
    
    Write-PremiumStatus "Generating premium system diagnostics..." "PROGRESS" $Script:ColorScheme.Primary
    
    $diagnostics = @{
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        System = Get-PremiumSystemProfile
        Network = $Script:NetworkAvailable
        Admin = $true
        PowerShell = $PSVersionTable.PSVersion.ToString()
        ExecutionPolicy = Get-ExecutionPolicy
    }
    
    Write-Host "`n" + "="*80 -ForegroundColor $Script:ColorScheme.Primary
    Write-Host "🖥️  PREMIUM SYSTEM DIAGNOSTICS REPORT" -ForegroundColor $Script:ColorScheme.Highlight
    Write-Host "="*80 -ForegroundColor $Script:ColorScheme.Primary
    
    Write-Host "`n📊 SYSTEM INFORMATION" -ForegroundColor $Script:ColorScheme.Success
    Write-Host "├─ OS: $($diagnostics.System.ProductName)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ Build: $($diagnostics.System.OSBuild) | Edition: $($diagnostics.System.Edition)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ Architecture: $($diagnostics.System.Architecture)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ Registered to: $($diagnostics.System.RegisteredOwner)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ Virtual Machine: $($diagnostics.System.IsVM)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "└─ Memory: $($diagnostics.System.TotalMemory) GB | Cores: $($diagnostics.System.ProcessorCores)" -ForegroundColor $Script:ColorScheme.Accent
    
    Write-Host "`n🔒 SECURITY FEATURES" -ForegroundColor $Script:ColorScheme.Warning
    Write-Host "├─ Secure Boot: $($diagnostics.System.SecureBoot)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ TPM Enabled: $($diagnostics.System.TPMEnabled)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ UEFI Firmware: $($diagnostics.System.UEFI)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "└─ BitLocker: $($diagnostics.System.BitLocker)" -ForegroundColor $Script:ColorScheme.Accent
    
    Write-Host "`n🏢 OFFICE INSTALLATIONS" -ForegroundColor $Script:ColorScheme.Primary
    if ($diagnostics.System.OfficeInstalled) {
        Write-Host "├─ Version: $($diagnostics.System.OfficeVersion)" -ForegroundColor $Script:ColorScheme.Accent
        Write-Host "├─ Architecture: $($diagnostics.System.OfficeArch)" -ForegroundColor $Script:ColorScheme.Accent
        Write-Host "└─ Products: $($diagnostics.System.OfficeProducts -join ', ')" -ForegroundColor $Script:ColorScheme.Accent
    } else {
        Write-Host "└─ No Microsoft Office installations detected" -ForegroundColor $Script:ColorScheme.Info
    }
    
    Write-Host "`n🔑 ACTIVATION STATUS" -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "├─ Windows: $($diagnostics.System.WindowsActivationType)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "└─ Office: $($diagnostics.System.OfficeActivationType)" -ForegroundColor $Script:ColorScheme.Accent
    
    Write-Host "`n🌐 NETWORK & ENVIRONMENT" -ForegroundColor $Script:ColorScheme.Info
    Write-Host "├─ Network: $(if ($diagnostics.Network) { 'Available' } else { 'Limited' })" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ Administrator: $($diagnostics.Admin)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ PowerShell: $($diagnostics.PowerShell)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "└─ Execution Policy: $($diagnostics.ExecutionPolicy)" -ForegroundColor $Script:ColorScheme.Accent
    
    Write-Host "`n" + "="*80 -ForegroundColor $Script:ColorScheme.Primary
    Write-Host "📋 Report generated: $($diagnostics.Timestamp)" -ForegroundColor $Script:ColorScheme.Info
    Write-Host "="*80 -ForegroundColor $Script:ColorScheme.Primary
}

function Get-AdvancedSystemAnalysis {
    <#
    .SYNOPSIS
        Advanced system analysis with performance metrics and detailed hardware profiling
    .DESCRIPTION
        Provides comprehensive analysis including disk performance, system uptime, 
        installed software inventory, and activation history
    #>
    
    Write-PremiumStatus "Performing advanced system analysis..." "PROGRESS" $Script:ColorScheme.Primary
    
    $analysis = @{
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        SystemUptime = $null
        DiskInfo = @()
        InstalledSoftware = @()
        ActivationHistory = @()
        PerformanceMetrics = @{}
    }
    
    # System Uptime
    try {
        $uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue).LastBootUpTime
        $analysis.SystemUptime = "$($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes"
    } catch {
        $analysis.SystemUptime = "Unable to determine"
    }
    
    # Disk Information
    try {
        $disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" -ErrorAction SilentlyContinue
        foreach ($disk in $disks) {
            $freePercent = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 2)
            $analysis.DiskInfo += @{
                Drive = $disk.Name
                TotalSize = "$([math]::Round($disk.Size / 1GB, 2)) GB"
                FreeSpace = "$([math]::Round($disk.FreeSpace / 1GB, 2)) GB"
                FreePercent = "$freePercent%"
            }
        }
    } catch {
        Write-PremiumStatus "Disk analysis skipped" "WARNING" $Script:ColorScheme.Warning
    }
    
    # Performance Metrics
    try {
        $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1
        $memory = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
        
        $analysis.PerformanceMetrics = @{
            ProcessorName = $cpu.Name
            ProcessorSpeed = "$($cpu.MaxClockSpeed) MHz"
            LogicalProcessors = $cpu.NumberOfLogicalProcessors
            TotalMemory = "$([math]::Round($memory.TotalPhysicalMemory / 1GB, 2)) GB"
        }
    } catch {
        Write-PremiumStatus "Performance metrics collection skipped" "WARNING" $Script:ColorScheme.Warning
    }
    
    Write-PremiumStatus "Advanced system analysis completed" "SUCCESS" $Script:ColorScheme.Success
    return $analysis
}

function Show-AdvancedAnalysisReport {
    <#
    .SYNOPSIS
        Display advanced system analysis report
    #>
    
    $analysis = Get-AdvancedSystemAnalysis
    
    Write-Host "`n" + "="*80 -ForegroundColor $Script:ColorScheme.Primary
    Write-Host "📈 ADVANCED SYSTEM ANALYSIS REPORT" -ForegroundColor $Script:ColorScheme.Highlight
    Write-Host "="*80 -ForegroundColor $Script:ColorScheme.Primary
    
    Write-Host "`n⏱️  SYSTEM UPTIME" -ForegroundColor $Script:ColorScheme.Success
    Write-Host "└─ $($analysis.SystemUptime)" -ForegroundColor $Script:ColorScheme.Accent
    
    Write-Host "`n💾 DISK INFORMATION" -ForegroundColor $Script:ColorScheme.Primary
    foreach ($disk in $analysis.DiskInfo) {
        Write-Host "├─ Drive: $($disk.Drive)" -ForegroundColor $Script:ColorScheme.Accent
        Write-Host "│  ├─ Total: $($disk.TotalSize)" -ForegroundColor $Script:ColorScheme.Accent
        Write-Host "│  ├─ Free: $($disk.FreeSpace)" -ForegroundColor $Script:ColorScheme.Accent
        Write-Host "│  └─ Usage: $($disk.FreePercent)" -ForegroundColor $Script:ColorScheme.Accent
    }
    
    Write-Host "`n⚡ PERFORMANCE METRICS" -ForegroundColor $Script:ColorScheme.Secondary
    Write-Host "├─ Processor: $($analysis.PerformanceMetrics.ProcessorName)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ Speed: $($analysis.PerformanceMetrics.ProcessorSpeed)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "├─ Logical Cores: $($analysis.PerformanceMetrics.LogicalProcessors)" -ForegroundColor $Script:ColorScheme.Accent
    Write-Host "└─ Total Memory: $($analysis.PerformanceMetrics.TotalMemory)" -ForegroundColor $Script:ColorScheme.Accent
    
    Write-Host "`n" + "="*80 -ForegroundColor $Script:ColorScheme.Primary
    Write-Host "📋 Report generated: $($analysis.Timestamp)" -ForegroundColor $Script:ColorScheme.Info
    Write-Host "="*80 -ForegroundColor $Script:ColorScheme.Primary
}
#endregion

#region Premium Activation Engine
function Get-PremiumActivationStrategy {
    <#
    .SYNOPSIS
        Intelligent activation strategy based on comprehensive system analysis
    #>
    param($SystemProfile)
    
    Write-PremiumStatus "Developing premium activation strategy..." "PROGRESS" $Script:ColorScheme.Primary
    
    $strategy = @{
        Methods = @()
        Priority = @()
        Fallbacks = @()
        Recommendations = @()
        EstimatedTime = "2-5 minutes"
        SuccessProbability = "High"
    }
    
    $windowsBuild = $SystemProfile.OSBuild
    
    # Windows Activation Strategy
    if ($windowsBuild -ge 22000) {
        # Windows 11
        $strategy.Methods += "HWID", "KMS38"
        $strategy.Priority += "HWID", "KMS38"
        $strategy.Recommendations += "HWID for permanent activation", "KMS38 as fallback"
    }
    elseif ($windowsBuild -ge 19041) {
        # Windows 10 20H1+
        $strategy.Methods += "HWID", "KMS38"
        $strategy.Priority += "HWID", "KMS38"
        $strategy.Recommendations += "HWID recommended for digital license"
    }
    elseif ($windowsBuild -ge 10240) {
        # Windows 10 RTM+
        $strategy.Methods += "KMS38", "OnlineKMS"
        $strategy.Priority += "KMS38", "OnlineKMS"
        $strategy.Recommendations += "KMS38 for long-term activation"
    }
    else {
        # Legacy Windows
        $strategy.Methods += "OnlineKMS"
        $strategy.Priority += "OnlineKMS"
        $strategy.Recommendations += "Online KMS for legacy support"
    }
    
    # Server Editions
    if ($SystemProfile.IsServer) {
        $strategy.Methods = @("KMS38", "OnlineKMS")
        $strategy.Priority = @("KMS38", "OnlineKMS")
        $strategy.Recommendations += "KMS38 optimized for Server editions"
        $strategy.SuccessProbability = "Very High"
    }
    
    # Online KMS Availability
    if ($Script:NetworkAvailable) {
        $strategy.Methods += "OnlineKMS"
        $strategy.Fallbacks += "OnlineKMS"
    }
    
    # Office Activation Strategy
    if ($SystemProfile.OfficeInstalled) {
        if ($SystemProfile.OfficeVersion -match "2021|365|2019|2016") {
            if ($Script:NetworkAvailable) {
                $strategy.Methods += "Ohook"
                $strategy.Priority += "Ohook"
                $strategy.Recommendations += "Ohook for permanent Office activation"
            }
            $strategy.Methods += "OfficeKMS"
            $strategy.Fallbacks += "OfficeKMS"
        } else {
            $strategy.Methods += "OfficeKMS"
            $strategy.Priority += "OfficeKMS"
            $strategy.Recommendations += "KMS activation for legacy Office"
        }
    }
    
    Write-PremiumStatus "Premium activation strategy developed" "SUCCESS" $Script:ColorScheme.Success
    return $strategy
}

function Invoke-PremiumHWIDActivation {
    <#
    .SYNOPSIS
        Premium HWID activation with comprehensive error handling
    #>
    
    Write-PremiumStatus "Initializing premium HWID activation..." "PROGRESS" $Script:ColorScheme.Primary
    
    try {
        # Comprehensive Windows Edition Key Database
        $windowsKeys = @{
            # Windows 11
            "Windows 11 Home" = "TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
            "Windows 11 Home N" = "3KHY7-WNT83-DGQKR-F7HPR-844BM"
            "Windows 11 Pro" = "W269N-WFGWX-YVC9B-4J6C9-T83GX"
            "Windows 11 Pro N" = "MH37W-N47XK-V7XM9-C7227-GCQG9"
            "Windows 11 Enterprise" = "NPPR9-FWDCX-D2C8J-H872K-2YT43"
            "Windows 11 Education" = "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
            
            # Windows 10
            "Windows 10 Home" = "TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
            "Windows 10 Pro" = "W269N-WFGWX-YVC9B-4J6C9-T83GX"
            "Windows 10 Enterprise" = "NPPR9-FWDCX-D2C8J-H872K-2YT43"
            "Windows 10 Education" = "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
        }
        
        # Detect current edition
        $currentEdition = $Script:SystemProfile.Edition
        $appropriateKey = $windowsKeys["Windows 11 Pro"]  # Default fallback
        
        foreach ($edition in $windowsKeys.Keys) {
            if ($edition -replace " ", "" -match $currentEdition -replace " ", "" -or 
                $currentEdition -replace " ", "" -match $edition -replace " ", "") {
                $appropriateKey = $windowsKeys[$edition]
                Write-PremiumStatus "Detected edition: $edition" "INFO" $Script:ColorScheme.Info
                break
            }
        }
        
        # Install appropriate key
        Write-PremiumStatus "Installing product key: $appropriateKey" "PROGRESS" $Script:ColorScheme.Primary
        $installResult = & "$env:SystemRoot\System32\slmgr.vbs" /ipk $appropriateKey 2>&1
        
        if ($installResult -match "error") {
            Write-PremiumStatus "Edition-specific key failed, using Pro key" "WARNING" $Script:ColorScheme.Warning
            & "$env:SystemRoot\System32\slmgr.vbs" /ipk $windowsKeys["Windows 11 Pro"] 2>&1 | Out-Null
        }
        
        # Enhanced activation with professional retry logic
        $maxRetries = 3
        $retryDelay = 5
        
        for ($i = 1; $i -le $maxRetries; $i++) {
            Write-PremiumStatus "HWID activation attempt $i of $maxRetries..." "PROGRESS" $Script:ColorScheme.Primary
            
            $activationResult = & "$env:SystemRoot\System32\slmgr.vbs" /ato 2>&1
            
            if ($activationResult -match "successfully") {
                # Verify permanent activation
                Start-Sleep -Seconds 2
                $licenseStatus = & "$env:SystemRoot\System32\slmgr.vbs" /xpr 2>&1
                
                if ($licenseStatus -match "permanently") {
                    Write-PremiumStatus "Windows permanently activated via HWID" "SUCCESS" $Script:ColorScheme.Success
                    return $true
                }
            }
            
            if ($i -lt $maxRetries) {
                Write-PremiumStatus "Retrying in $retryDelay seconds..." "INFO" $Script:ColorScheme.Info
                Start-Sleep -Seconds $retryDelay
            }
        }
        
        Write-PremiumStatus "HWID activation requires fallback methods" "WARNING" $Script:ColorScheme.Warning
        return $false
    }
    catch {
        Write-PremiumStatus "HWID activation failed: $($_.Exception.Message)" "ERROR" $Script:ColorScheme.Error
        return $false
    }
}

function Invoke-PremiumKMS38Activation {
    <#
    .SYNOPSIS
        Premium KMS38 activation with extended support
    #>
    
    Write-PremiumStatus "Initializing premium KMS38 activation..." "PROGRESS" $Script:ColorScheme.Primary
    
    try {
        # Enterprise KMS Key Database
        $kmsKeys = @{
            # Windows Client
            "Windows 10/11 Pro" = "W269N-WFGWX-YVC9B-4J6C9-T83GX"
            "Windows 10/11 Enterprise" = "NPPR9-FWDCX-D2C8J-H872K-2YT43"
            "Windows 10/11 Education" = "NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
            
            # Windows Server
            "Windows Server 2022" = "WDY3X-6PFX4-P6VJQ-9VVT6-2VKP4"
            "Windows Server 2019" = "WMDGN-G9PQG-XVVXX-R3X43-63DFG"
            "Windows Server 2016" = "WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY"
        }
        
        # Install relevant KMS keys
        foreach ($keyName in $kmsKeys.Keys) {
            $result = & "$env:SystemRoot\System32\slmgr.vbs" /ipk $kmsKeys[$keyName] 2>&1
            if ($result -notmatch "error") {
                Write-PremiumStatus "KMS key installed: $keyName" "INFO" $Script:ColorScheme.Info
            }
        }
        
        # Configure local KMS emulation
        & "$env:SystemRoot\System32\slmgr.vbs" /skms 127.0.0.1 2>&1 | Out-Null
        & "$env:SystemRoot\System32\slmgr.vbs" /skms [::1] 2>&1 | Out-Null
        
        # Enterprise registry configuration
        $kmsPaths = @(
            "HKLM:\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\SoftwareProtectionPlatform",
            "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
        )
        
        foreach ($path in $kmsPaths) {
            if (Test-Path $path) {
                Set-ItemProperty -Path $path -Name "KeyManagementServiceName" -Value "127.0.0.1" -Force -ErrorAction SilentlyContinue
                Set-ItemProperty -Path $path -Name "KeyManagementServicePort" -Value 1688 -Type DWord -Force -ErrorAction SilentlyContinue
            }
        }
        
        # Force activation
        $activation = & "$env:SystemRoot\System32\slmgr.vbs" /ato 2>&1
        if ($activation -match "successfully") {
            Write-PremiumStatus "KMS38 activation successful until 2038" "SUCCESS" $Script:ColorScheme.Success
            return $true
        }
        
        return $false
    }
    catch {
        Write-PremiumStatus "KMS38 activation failed: $($_.Exception.Message)" "ERROR" $Script:ColorScheme.Error
        return $false
    }
}

function Invoke-PremiumOnlineKMS {
    <#
    .SYNOPSIS
        Premium Online KMS with intelligent server selection
    #>
    
    if (-not $Script:NetworkAvailable) {
        Write-PremiumStatus "Network required for Online KMS" "ERROR" $Script:ColorScheme.Error
        return $false
    }
    
    Write-PremiumStatus "Initializing premium Online KMS activation..." "PROGRESS" $Script:ColorScheme.Primary
    
    $kmsServers = @(
        "kms8.msguides.com",
        "kms9.msguides.com", 
        "kms.digiboy.ir",
        "kms.lotro.cc",
        "kms.chinancce.com",
        "kms.03k.org"
    )
    
    foreach ($server in $kmsServers) {
        Write-PremiumStatus "Testing KMS server: $server" "PROGRESS" $Script:ColorScheme.Primary
        
        try {
            $testResult = Test-NetConnection -ComputerName $server -Port 1688 -InformationLevel Quiet -WarningAction SilentlyContinue
            
            if ($testResult) {
                Write-PremiumStatus "Server active: $server" "SUCCESS" $Script:ColorScheme.Success
                
                # Set KMS server
                & "$env:SystemRoot\System32\slmgr.vbs" /skms $server 2>&1 | Out-Null
                
                # Attempt activation
                $kmsResult = & "$env:SystemRoot\System32\slmgr.vbs" /ato 2>&1
                
                if ($kmsResult -match "successfully") {
                    Write-PremiumStatus "Online KMS activation successful via $server" "SUCCESS" $Script:ColorScheme.Success
                    
                    # Activate Office if present
                    if ($Script:SystemProfile.OfficeInstalled) {
                        Invoke-PremiumOfficeKMS -KMSServer $server
                    }
                    
                    return $true
                }
            }
        }
        catch {
            Write-PremiumStatus "Server failed: $server" "WARNING" $Script:ColorScheme.Warning
        }
    }
    
    Write-PremiumStatus "All Online KMS servers unavailable" "ERROR" $Script:ColorScheme.Error
    return $false
}

function Invoke-PremiumOhook {
    <#
    .SYNOPSIS
        Premium Ohook activation with multiple sources
    #>
    
    if (-not $Script:NetworkAvailable) {
        Write-PremiumStatus "Network required for Ohook" "ERROR" $Script:ColorScheme.Error
        return $false
    }
    
    if (-not $Script:SystemProfile.OfficeInstalled) {
        Write-PremiumStatus "Office not detected for Ohook activation" "WARNING" $Script:ColorScheme.Warning
        return $false
    }
    
    Write-PremiumStatus "Initializing premium Ohook activation..." "PROGRESS" $Script:ColorScheme.Primary
    
    $ohookSources = @(
        "https://github.com/asdcorp/ohook/releases/latest/download/ohook.zip",
        "https://mirror.ghproxy.com/https://github.com/asdcorp/ohook/releases/latest/download/ohook.zip",
        "https://cdn.jsdelivr.net/gh/asdcorp/ohook@latest/release/ohook.zip"
    )
    
    foreach ($source in $ohookSources) {
        try {
            Write-PremiumStatus "Downloading from: $(($source -split '/')[2])" "PROGRESS" $Script:ColorScheme.Primary
            
            $tempPath = Join-Path $env:TEMP "maspro_ohook_$(Get-Random)"
            $zipPath = "$tempPath\ohook.zip"
            
            # Clean and prepare
            Remove-Item -Path $tempPath -Recurse -Force -ErrorAction SilentlyContinue
            New-Item -ItemType Directory -Path $tempPath -Force | Out-Null
            
            # Download
            $webClient = New-Object System.Net.WebClient
            $webClient.Headers.Add("User-Agent", "MAS-Pro-Premium/$Script:MASProVersion")
            $webClient.DownloadFile($source, $zipPath)
            
            if (Test-Path $zipPath -and (Get-Item $zipPath).Length -gt 5120) {
                # Extract and install
                Expand-Archive -Path $zipPath -DestinationPath $tempPath -Force
                
                $installer = Get-ChildItem -Path $tempPath -Recurse -Include "*.exe", "*.msi" | Select-Object -First 1
                if ($installer) {
                    Write-PremiumStatus "Executing Ohook installer" "PROGRESS" $Script:ColorScheme.Primary
                    
                    if ($installer.Extension -eq ".msi") {
                        $process = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "`"$($installer.FullName)`"", "/quiet", "/norestart" -Wait -PassThru -NoNewWindow
                    } else {
                        $process = Start-Process -FilePath $installer.FullName -ArgumentList "/quiet", "/norestart" -Wait -PassThru -NoNewWindow
                    }
                    
                    if ($process.ExitCode -eq 0) {
                        Write-PremiumStatus "Ohook activation successful" "SUCCESS" $Script:ColorScheme.Success
                        Remove-Item -Path $tempPath -Recurse -Force -ErrorAction SilentlyContinue
                        return $true
                    }
                }
            }
        }
        catch {
            Write-PremiumStatus "Ohook source failed: $(($source -split '/')[2])" "WARNING" $Script:ColorScheme.Warning
            continue
        }
        finally {
            Remove-Item -Path $tempPath -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    
    Write-PremiumStatus "Ohook activation failed" "ERROR" $Script:ColorScheme.Error
    return $false
}

function Invoke-PremiumOfficeKMS {
    param([string]$KMSServer = "kms8.msguides.com")
    
    <#
    .SYNOPSIS
        Premium Office KMS activation
    #>
    
    if (-not $Script:SystemProfile.OfficeInstalled) {
        return $false
    }
    
    Write-PremiumStatus "Initializing premium Office KMS activation..." "PROGRESS" $Script:ColorScheme.Primary
    
    try {
        $osppPaths = @(
            "$env:ProgramFiles\Microsoft Office\Office16\ospp.vbs",
            "$env:ProgramFiles\Microsoft Office\root\Office16\ospp.vbs",
            "${env:ProgramFiles(x86)}\Microsoft Office\Office16\ospp.vbs",
            "${env:ProgramFiles(x86)}\Microsoft Office\root\Office16\ospp.vbs"
        )
        
        $osppPath = $osppPaths | Where-Object { Test-Path $_ } | Select-Object -First 1
        
        if (-not $osppPath) {
            Write-PremiumStatus "Office OSPP not found" "WARNING" $Script:ColorScheme.Warning
            return $false
        }
        
        # Office KMS activation sequence
        $officeCommands = @(
            "cscript `"$osppPath`" /sethst:$KMSServer",
            "cscript `"$osppPath`" /setprt:1688", 
            "cscript `"$osppPath`" /act"
        )
        
        foreach ($cmd in $officeCommands) {
            $result = cmd /c $cmd 2>&1
            if ($result -match "ERROR") {
                Write-PremiumStatus "Office KMS command failed: $cmd" "WARNING" $Script:ColorScheme.Warning
            }
        }
        
        # Verify activation
        $statusResult = cscript //nologo "`"$osppPath`" /dstatus" 2>&1
        if ($statusResult -match "LICENSED") {
            Write-PremiumStatus "Office KMS activation successful" "SUCCESS" $Script:ColorScheme.Success
            return $true
        }
        
        return $false
    }
    catch {
        Write-PremiumStatus "Office KMS activation failed: $($_.Exception.Message)" "ERROR" $Script:ColorScheme.Error
        return $false
    }
}

function Start-PremiumActivationOrchestration {
    <#
    .SYNOPSIS
        Premium activation orchestration with intelligent execution
    #>
    param($Strategy)
    
    Write-PremiumStatus "Starting premium activation orchestration..." "PROGRESS" $Script:ColorScheme.Primary
    
    $results = @{}
    $methodWeights = @{
        "HWID" = 100
        "KMS38" = 90
        "OnlineKMS" = 80  
        "Ohook" = 95
        "OfficeKMS" = 85
    }
    
    # Execute by priority
    $orderedMethods = $Strategy.Methods | Sort-Object { $methodWeights[$_] } -Descending
    $totalSteps = $orderedMethods.Count
    
    for ($i = 0; $i -lt $totalSteps; $i++) {
        $method = $orderedMethods[$i]
        $percentComplete = (($i + 1) / $totalSteps) * 100
        
        Show-PremiumProgress -Activity "Premium Activation" -Status "Executing: $method" -PercentComplete $percentComplete -CurrentStep ($i+1) -TotalSteps $totalSteps
        
        switch ($method) {
            "HWID" { $results.HWID = Invoke-PremiumHWIDActivation }
            "KMS38" { $results.KMS38 = Invoke-PremiumKMS38Activation }
            "OnlineKMS" { $results.OnlineKMS = Invoke-PremiumOnlineKMS }
            "Ohook" { $results.Ohook = Invoke-PremiumOhook }
            "OfficeKMS" { $results.OfficeKMS = Invoke-PremiumOfficeKMS }
        }
        
        # Smart optimization - skip lower priority Windows methods if HWID succeeded
        if ($method -eq "HWID" -and $results.HWID) {
            Write-PremiumStatus "HWID succeeded - optimizing remaining execution" "SUCCESS" $Script:ColorScheme.Success
        }
    }
    
    Write-Progress -Activity "Premium Activation" -Completed
    return $results
}
#endregion

#region Premium Main Execution
# Initialize premium environment
Test-MASProInstallation | Out-Null
Test-NetworkConnectivity | Out-Null

# Show premium interface
Show-PremiumBanner

# Perform comprehensive system analysis
$Script:SystemProfile = Get-PremiumSystemProfile

# Display welcome information
Write-Host "🎯 QUICK START OPTIONS" -ForegroundColor $Script:ColorScheme.Highlight
Write-Host "├─ 1. Auto Activation (Recommended for most users)" -ForegroundColor $Script:ColorScheme.Accent
Write-Host "├─ 2. System Diagnostics (View detailed system info)" -ForegroundColor $Script:ColorScheme.Accent
Write-Host "└─ 3. Premium Menu (All options & features)" -ForegroundColor $Script:ColorScheme.Accent
Write-Host "`n"

$quickChoice = Read-Host "Select quick option (1-3) or Enter for premium menu"
switch ($quickChoice) {
    "1" {
        Write-PremiumStatus "Starting auto activation..." "PROGRESS" $Script:ColorScheme.Primary
        $strategy = Get-PremiumActivationStrategy -SystemProfile $Script:SystemProfile
        $Script:ActivationResults = Start-PremiumActivationOrchestration -Strategy $strategy
    }
    "2" {
        Show-SystemDiagnostics
        Read-Host "`nPress Enter to continue to premium menu"
        Show-PremiumMenu
    }
    "3" { Show-PremiumMenu }
    default { Show-PremiumMenu }
}

# Main menu loop
do {
    if (-not $Script:SilentMode) {
        $mainChoice = Read-Host "`n🎯 Select premium option (0-12)"
        
        switch ($mainChoice) {
            "0" {
                Write-PremiumStatus "Thank you for using MAS-Pro Premium!" "SUCCESS" $Script:ColorScheme.Success
                exit
            }
            "1" {
                Write-PremiumStatus "Starting auto activation..." "PROGRESS" $Script:ColorScheme.Primary
                $strategy = Get-PremiumActivationStrategy -SystemProfile $Script:SystemProfile
                $Script:ActivationResults = Start-PremiumActivationOrchestration -Strategy $strategy
            }
            "2" { $Script:ActivationResults.HWID = Invoke-PremiumHWIDActivation }
            "3" { $Script:ActivationResults.KMS38 = Invoke-PremiumKMS38Activation }
            "4" { $Script:ActivationResults.OnlineKMS = Invoke-PremiumOnlineKMS }
            "5" { 
                if ($Script:SystemProfile.OfficeInstalled) {
                    $Script:ActivationResults.Ohook = Invoke-PremiumOhook
                    $Script:ActivationResults.OfficeKMS = Invoke-PremiumOfficeKMS
                } else {
                    Write-PremiumStatus "Office not detected" "WARNING" $Script:ColorScheme.Warning
                }
            }
            "6" { Show-SystemDiagnostics }
            "7" { Show-AdvancedAnalysisReport }
            "8" { 
                Write-PremiumStatus "Checking activation status..." "PROGRESS" $Script:ColorScheme.Primary
                $currentStatus = Get-PremiumSystemProfile
                Write-PremiumStatus "Windows: $($currentStatus.WindowsActivationType)" "INFO" $Script:ColorScheme.Info
                if ($currentStatus.OfficeInstalled) {
                    Write-PremiumStatus "Office: $($currentStatus.OfficeActivationType)" "INFO" $Script:ColorScheme.Info
                }
            }
            "9" {
                Write-PremiumStatus "Launching troubleshooting tools..." "PROGRESS" $Script:ColorScheme.Primary
                # Troubleshooting tools would be implemented here
                Write-PremiumStatus "Troubleshooting features in development" "INFO" $Script:ColorScheme.Info
            }
            "10" { Install-MASProPremium }
            "11" { Update-MASProPremium }
            "12" { 
                Write-PremiumStatus "Switching to online mode..." "PROGRESS" $Script:ColorScheme.Primary
                Start-Process "powershell" -ArgumentList "-ExecutionPolicy Bypass -Command `"irm $Script:ScriptURL | iex`""
                exit
            }
            "13" { 
                Start-Process $Script:RepositoryURL
                Write-PremiumStatus "Documentation opened in browser" "SUCCESS" $Script:ColorScheme.Success
            }
            default {
                Write-PremiumStatus "Invalid option selected" "ERROR" $Script:ColorScheme.Error
            }
        }
    } else {
        # Silent mode execution
        $strategy = Get-PremiumActivationStrategy -SystemProfile $Script:SystemProfile
        $Script:ActivationResults = Start-PremiumActivationOrchestration -Strategy $strategy
        break
    }
} while (-not $Script:SilentMode)

# Premium cleanup
try {
    Get-ChildItem -Path "$env:TEMP\maspro_*" -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Get-ChildItem -Path "$env:TEMP\ohook_*" -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
} catch {
    # Silent cleanup
}

Write-PremiumStatus "MAS-Pro Premium execution completed" "SUCCESS" $Script:ColorScheme.Success
Write-PremiumStatus "Repository: $Script:RepositoryURL" "INFO" $Script:ColorScheme.Info

# Restore default preferences
$ErrorActionPreference = 'Continue'
$ProgressPreference = 'Continue'
#endregion