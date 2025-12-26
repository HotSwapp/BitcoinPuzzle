# VanitySearch Windows Build Script
# Requires: Visual Studio 2022, CUDA Toolkit 12.x

param(
    [switch]$NoCuda,
    [string]$CudaArch = "89",  # Default for RTX 40xx, use "100" for RTX 5090
    [switch]$Clean,
    [switch]$Help
)

$ErrorActionPreference = "Stop"

function Show-Help {
    Write-Host @"
VanitySearch Windows Build Script

Usage: .\build_windows.ps1 [options]

Options:
    -NoCuda         Build CPU-only version (no GPU support)
    -CudaArch <n>   CUDA architecture (default: 89)
                    Common values:
                      100 - RTX 5090 (Blackwell)
                      89  - RTX 4090/4080 (Ada)
                      86  - RTX 3090/3080 (Ampere)
                      75  - RTX 2080/2070 (Turing)
                      61  - GTX 1080/1070 (Pascal)
    -Clean          Clean build directory before building
    -Help           Show this help message

Examples:
    .\build_windows.ps1                    # Build with GPU for RTX 4090
    .\build_windows.ps1 -CudaArch 100      # Build for RTX 5090
    .\build_windows.ps1 -NoCuda            # Build CPU-only
    .\build_windows.ps1 -Clean             # Clean and rebuild
"@
    exit 0
}

if ($Help) { Show-Help }

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "VanitySearch Windows Build Script" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check for CMake
if (-not (Get-Command cmake -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: CMake not found. Please install CMake and add to PATH." -ForegroundColor Red
    Write-Host "Download from: https://cmake.org/download/" -ForegroundColor Yellow
    exit 1
}

# Check for CUDA (unless building CPU-only)
if (-not $NoCuda) {
    $cudaPath = $env:CUDA_PATH
    if (-not $cudaPath -or -not (Test-Path $cudaPath)) {
        Write-Host "WARNING: CUDA_PATH not found. Attempting to locate CUDA..." -ForegroundColor Yellow
        $cudaPath = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.3"
        if (-not (Test-Path $cudaPath)) {
            $cudaPath = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.6"
        }
        if (-not (Test-Path $cudaPath)) {
            Write-Host "ERROR: CUDA Toolkit not found. Please install CUDA Toolkit 12.x" -ForegroundColor Red
            Write-Host "Download from: https://developer.nvidia.com/cuda-downloads" -ForegroundColor Yellow
            Write-Host "Or use -NoCuda flag for CPU-only build" -ForegroundColor Yellow
            exit 1
        }
    }
    Write-Host "Found CUDA at: $cudaPath" -ForegroundColor Green
}

# Create build directory
$buildDir = "build"
if ($Clean -and (Test-Path $buildDir)) {
    Write-Host "Cleaning build directory..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $buildDir
}

if (-not (Test-Path $buildDir)) {
    New-Item -ItemType Directory -Path $buildDir | Out-Null
}

Set-Location $buildDir

# Configure CMake
Write-Host ""
Write-Host "Configuring CMake..." -ForegroundColor Cyan

$cmakeArgs = @(
    "..",
    "-G", "Visual Studio 17 2022",
    "-A", "x64"
)

if ($NoCuda) {
    $cmakeArgs += "-DWITH_GPU=OFF"
    Write-Host "  GPU Support: DISABLED" -ForegroundColor Yellow
} else {
    $cmakeArgs += "-DWITH_GPU=ON"
    $cmakeArgs += "-DCUDA_ARCH=$CudaArch"
    Write-Host "  GPU Support: ENABLED" -ForegroundColor Green
    Write-Host "  CUDA Architecture: $CudaArch" -ForegroundColor Green
}

& cmake $cmakeArgs
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: CMake configuration failed" -ForegroundColor Red
    Set-Location ..
    exit 1
}

# Build
Write-Host ""
Write-Host "Building VanitySearch..." -ForegroundColor Cyan
& cmake --build . --config Release
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Build failed" -ForegroundColor Red
    Set-Location ..
    exit 1
}

Set-Location ..

# Copy executable
$exePath = "build\Release\VanitySearch.exe"
if (Test-Path $exePath) {
    Copy-Item $exePath "VanitySearch.exe" -Force
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Green
    Write-Host "Build successful!" -ForegroundColor Green
    Write-Host "Executable: VanitySearch.exe" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Green
} else {
    Write-Host "ERROR: Executable not found at expected path" -ForegroundColor Red
    exit 1
}

# Show usage hint
Write-Host ""
Write-Host "Quick test:" -ForegroundColor Cyan
Write-Host "  .\VanitySearch.exe -v" -ForegroundColor White
Write-Host ""
Write-Host "Bitcoin Puzzle mode (example for puzzle #67):" -ForegroundColor Cyan
Write-Host "  .\VanitySearch.exe -gpu -stop -k 40000000000000000 -i addresses.txt -o found.txt" -ForegroundColor White

