<#
.SYNOPSIS
    MAS-Pro: Microsoft Activation Scripts Professional v1.0
    Shorter alias for main script
.NOTES
    Author: Abu Naser Khan (joyelkhan)
    Repository: https://github.com/joyelkhan/MAS-Pro
    
    This is a convenience wrapper that loads the full MAS-Pro script.
    For the complete implementation, see: MAS-Pro Microsoft Activation Scripts Pro.ps1
#>

# Load and execute the main MAS-Pro script
$mainScript = Join-Path $PSScriptRoot "MAS-Pro Microsoft Activation Scripts Pro.ps1"

if (Test-Path $mainScript) {
    & $mainScript @args
} else {
    Write-Host "[ERROR] Main MAS-Pro script not found!" -ForegroundColor Red
    Write-Host "Expected location: $mainScript" -ForegroundColor Yellow
    Write-Host "`nTrying to download from GitHub..." -ForegroundColor Cyan
    
    try {
        $scriptUrl = "https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro.ps1"
        Invoke-Expression (Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing).Content
    }
    catch {
        Write-Host "[ERROR] Failed to download: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Please visit: https://github.com/joyelkhan/MAS-Pro" -ForegroundColor Yellow
    }
}
