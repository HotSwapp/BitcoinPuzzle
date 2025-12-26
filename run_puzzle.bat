@echo off
REM Bitcoin Puzzle Solver - Quick Start Script for Windows
REM This script runs VanitySearch for a specific puzzle number

setlocal enabledelayedexpansion

echo ============================================
echo Bitcoin Puzzle Solver
echo ============================================
echo.

REM Check for VanitySearch
if not exist VanitySearch.exe (
    echo ERROR: VanitySearch.exe not found!
    echo Please build first using: build_windows.bat
    exit /b 1
)

REM Display puzzle information
echo Available unsolved puzzles:
echo   #67  - 0.67 BTC - Range: 2^66 to 2^67-1
echo   #68  - 0.68 BTC - Range: 2^67 to 2^68-1
echo   #69  - 0.69 BTC - Range: 2^68 to 2^69-1
echo   #71  - 0.71 BTC - Range: 2^70 to 2^71-1
echo   #72  - 0.72 BTC - Range: 2^71 to 2^72-1
echo.

REM Get puzzle number from user or argument
if "%1"=="" (
    set /p PUZZLE="Enter puzzle number (e.g., 67): "
) else (
    set PUZZLE=%1
)

REM Calculate start key based on puzzle number
REM For puzzle N, start key is 2^(N-1)
set /a BITS=%PUZZLE%-1

echo.
echo Searching for puzzle #%PUZZLE%
echo Key range: 2^%BITS% to 2^%PUZZLE%-1
echo.

REM Create addresses file for the target puzzle
REM These are the known puzzle addresses
echo Creating target address file...

REM Puzzle #67 address
if "%PUZZLE%"=="67" (
    echo 1BY8GQbnueYofwSuFAT3USAhGjPrkxDdW9> puzzle_target.txt
    set STARTKEY=40000000000000000
)

REM Puzzle #68 address
if "%PUZZLE%"=="68" (
    echo 1MVDYgVaSN6iKKEsbzRUAYFrYJadLYZvvZ> puzzle_target.txt
    set STARTKEY=80000000000000000
)

REM Puzzle #69 address
if "%PUZZLE%"=="69" (
    echo 19vkiEajfhuZ8bs8Zu2jgmC6oqZbWqhxhG> puzzle_target.txt
    set STARTKEY=100000000000000000
)

REM Puzzle #71 address
if "%PUZZLE%"=="71" (
    echo 1PWo3JeB9jrGwfHDNpdGK54CRas7fsVzXU> puzzle_target.txt
    set STARTKEY=400000000000000000
)

REM Puzzle #72 address
if "%PUZZLE%"=="72" (
    echo 1JTK7s9YVYywfm5XUH7RNhHJH1LshCaRFR> puzzle_target.txt
    set STARTKEY=800000000000000000
)

if not defined STARTKEY (
    echo ERROR: Unknown puzzle number: %PUZZLE%
    echo Please use a known puzzle number (67, 68, 69, 71, 72)
    exit /b 1
)

echo Target address file created.
echo Start key: 0x%STARTKEY%
echo.
echo Starting VanitySearch with GPU...
echo Press Ctrl+C to stop
echo.

REM Run VanitySearch
VanitySearch.exe -gpu -stop -k %STARTKEY% -i puzzle_target.txt -o found_%PUZZLE%.txt

echo.
echo Search complete. Check found_%PUZZLE%.txt for results.

endlocal

