# MAS-Pro: Microsoft Activation Scripts Professional v1.0

**Author:** Abu Naser Khan (joyelkhan)  
**Repository:** https://github.com/joyelkhan/MAS-Pro

Professional-grade activation engine for Windows 11, Windows 10, Server, and Microsoft Office. Incorporates advanced techniques from leading open-source projects with enterprise-level reliability, intelligent method orchestration, comprehensive system analysis, and zero-touch deployment.

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

## Usage

1. **Run as Administrator:**
   ```powershell
   powershell -ExecutionPolicy Bypass -File "MAS-Pro Microsoft Activation Scripts Pro.ps1"
   ```

2. **Or right-click the script and select "Run as Administrator"** (required for professional execution)

3. The script will:
   - Analyze your system configuration
   - Determine optimal activation methods
   - Execute activation with automatic fallbacks
   - Report detailed status and success metrics

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
