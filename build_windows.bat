@echo off
REM VanitySearch Windows Build Script (Batch version)
REM For PowerShell version with more options, use build_windows.ps1

echo ============================================
echo VanitySearch Windows Build Script
echo ============================================
echo.

REM Check for CMake
where cmake >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: CMake not found. Please install CMake and add to PATH.
    echo Download from: https://cmake.org/download/
    exit /b 1
)

REM Create build directory
if not exist build mkdir build
cd build

REM Configure with CMake
echo Configuring CMake...
cmake .. -G "Visual Studio 17 2022" -A x64 -DWITH_GPU=ON -DCUDA_ARCH=89
if %errorlevel% neq 0 (
    echo ERROR: CMake configuration failed
    cd ..
    exit /b 1
)

REM Build
echo.
echo Building VanitySearch...
cmake --build . --config Release
if %errorlevel% neq 0 (
    echo ERROR: Build failed
    cd ..
    exit /b 1
)

cd ..

REM Copy executable
if exist build\Release\VanitySearch.exe (
    copy build\Release\VanitySearch.exe VanitySearch.exe
    echo.
    echo ============================================
    echo Build successful!
    echo Executable: VanitySearch.exe
    echo ============================================
) else (
    echo ERROR: Executable not found
    exit /b 1
)

echo.
echo Quick test: VanitySearch.exe -v

