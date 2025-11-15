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

# Check if running via irm | iex (online mode)
if ([string]::IsNullOrEmpty($PSScriptRoot)) {
    # Running online - download full script directly
    Write-Host "[MAS-PRO] Running in online mode..." -ForegroundColor Cyan
    try {
        # Add cache-busting parameter with timestamp
        $timestamp = [System.DateTime]::UtcNow.Ticks
        $scriptUrl = "https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro%20Microsoft%20Activation%20Scripts%20Pro.ps1?t=$timestamp"
        $scriptContent = (Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing).Content
        Invoke-Expression $scriptContent
    }
    catch {
        Write-Host "[ERROR] Failed to download full script: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Please visit: https://github.com/joyelkhan/MAS-Pro" -ForegroundColor Yellow
    }
} else {
    # Running locally - load from same directory
    $mainScript = Join-Path $PSScriptRoot "MAS-Pro Microsoft Activation Scripts Pro.ps1"
    
    if (Test-Path $mainScript) {
        & $mainScript @args
    } else {
        Write-Host "[ERROR] Main MAS-Pro script not found!" -ForegroundColor Red
        Write-Host "Expected location: $mainScript" -ForegroundColor Yellow
        Write-Host "`nTrying to download from GitHub..." -ForegroundColor Cyan
        
        try {
            # Add cache-busting parameter with timestamp
            $timestamp = [System.DateTime]::UtcNow.Ticks
            $scriptUrl = "https://raw.githubusercontent.com/joyelkhan/MAS-Pro/main/MAS-Pro%20Microsoft%20Activation%20Scripts%20Pro.ps1?t=$timestamp"
            $scriptContent = (Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing).Content
            Invoke-Expression $scriptContent
        }
        catch {
            Write-Host "[ERROR] Failed to download: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host "Please visit: https://github.com/joyelkhan/MAS-Pro" -ForegroundColor Yellow
        }
    }
}
