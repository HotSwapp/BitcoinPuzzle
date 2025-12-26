@echo off
REM Bitcoin Puzzle Solver - Search ALL Unsolved Puzzles at Once
REM This script searches for multiple puzzle addresses simultaneously

setlocal enabledelayedexpansion

echo ============================================
echo Bitcoin Puzzle Solver - Multi-Address Mode
echo ============================================
echo.

REM Check for VanitySearch
if not exist VanitySearch.exe (
    echo ERROR: VanitySearch.exe not found!
    echo Please build first using: build_windows.bat
    exit /b 1
)

REM Create file with ALL unsolved puzzle addresses
echo Creating target file with all unsolved puzzle addresses...

(
echo # Bitcoin Puzzle Unsolved Addresses
echo # Puzzle 67-69, 71-160 (excluding 70 which was solved in 2024)
echo.
echo # Puzzle 67 - 0.67 BTC
echo 1BY8GQbnueYofwSuFAT3USAhGjPrkxDdW9
echo # Puzzle 68 - 0.68 BTC
echo 1MVDYgVaSN6iKKEsbzRUAYFrYJadLYZvvZ
echo # Puzzle 69 - 0.69 BTC
echo 19vkiEajfhuZ8bs8Zu2jgmC6oqZbWqhxhG
echo # Puzzle 71 - 0.71 BTC
echo 1PWo3JeB9jrGwfHDNpdGK54CRas7fsVzXU
echo # Puzzle 72 - 0.72 BTC
echo 1JTK7s9YVYywfm5XUH7RNhHJH1LshCaRFR
echo # Puzzle 73 - 0.73 BTC
echo 12VVRNPi4SJqUTsp6FmqDqY5ehwLHBGiYj
echo # Puzzle 74 - 0.74 BTC
echo 1FWGcVDK3JGzCC3WtkYetULPszMaK2Jksv
echo # Puzzle 75 - 0.75 BTC
echo 1J36UjUByGroXcCvmj13U6uwaVv9caEeAt
echo # Puzzle 76 - 0.76 BTC
echo 1DJh2eHFYQfACPmrvpyWc8MSTYKh7w9eRF
echo # Puzzle 77 - 0.77 BTC
echo 1Bxk4CQdqL9p22JEtDfdXMsng1XacifUtE
echo # Puzzle 78 - 0.78 BTC
echo 15qF6X51huDjqTmF9BJgxXdt1xcj46Jmhb
echo # Puzzle 79 - 0.79 BTC
echo 1ARk8HWJMn8js8tQmGUJeQHjSE7KRkn2t8
echo # Puzzle 80 - 0.80 BTC
echo 1BCf6rHUW6m3iH2ptsvnjgLruAiPQQepLe
echo # Puzzle 81-160 addresses...
echo 15qsCm78whspNQFydGJQk5rexzxTQopnHZ
echo 13zYrYhhJxp6Ui1VV7pqa5WDhNWM45ARAC
echo 14MdEb4eFcT7MVoVBNbB7Xwf7ufVuDfNLT
echo 1CMq3SvFcVEcpLMuuH8PUcNiqsK1oicG2D
echo 1K3x5L6G57Y494fDqBfrojD28UJv4s5JcK
echo 1PxH3K1Shdjb7gSEoTX7UPDZ6SH4qGPrvq
echo 16AbnZjZZipwHMkYKBSfswGWRZRpHxW7aK
echo 19QciEHbGVNY4hrhfKXmcBBCrJSBZ6TaVt
echo 1L12FHH2FHjvTviyanuiFVfmzCy9XjDdv5
echo 1EzVHtmbN4fs4MiNk3ppEnKKhsmXYJ4s74
echo 1AE8NzzgKE7Yhz7BWtAcAAxiFMbPo82NB5
echo 17Q7tuG2JwFFU9rXVj3uZqRtioH3mx2Jad
echo 1K6xGMUbs6ZTXBnhw1pippqwK6wjBWtMvh
echo 15ANYzzCp5BFHcCnVFzXqyibpzgPLWaD8b
echo 18ywPwj39nGjqBrQJSzZVq2izR12MDpDr8
echo 1CaBVPrwUxbQYYswu32w7Mj4HR4maNoJSX
echo 1JWnE6p6UN7ZJBN7TtcbNDoRcjFtuDWoNL
echo 1CKCVdbDJasYmhswB6HKZHEAnNaDpK7W4n
echo 1PXv28YxmYMaB8zxrKeZBW8dt2HK7RkRPX
echo 1AcAmB6jmtU6AiEcXkmiNE9TNVPsj9DULf
echo 1EQJvpsmhazYCcKX5Au6AZmZKRnzarMVZu
echo 1CMjscKB3QW7SDyQ4c3C3DEUHiHRhiZVib
echo 18KsfuHuzQaBTNLASyj15hy4LuqPUo1FNB
echo 15EJFC5ZTs9nhsdvSUeBXjLAuYq3SWaxTc
echo 1HB1iKUqeffnVsvQsbpC6dNi1XKbyNuqao
echo 1GvgAXVCbA8FBjXfWiAms4ytFeJcKsoyhL
echo 12JzYkkN76xkwvcPT6AWKZtGX6w2LAgsJg
echo 1824ZJQ7nKJ9QFTRBqn7z7dHV5EGpzUpH3
echo 18A7NA9FTsnJxWgkoFfPAFbQzuQxpRpGBX
echo 1NeGn21dUDDeqFQ63xb2SpgUuXuBLA4WT4
echo 174SNxfqpdMGYy5YQcfLbSTK3MRNZEePoy
echo 1NLbHuJebVwUZ1XqDjsAyfTRUPwDQbemfv
echo 1MnJ6hdhvK37VLmqcdEwqC3iFxyWH2PHUV
echo 1KNRfGWw7Q9Rmwsc6NT5zsdvEb9M2Wkj5Z
echo 1PJZPzvGX19a7twf5HyD2VvNiPdHLzm9F6
echo 1GuBBhf61rnvRe4K8zu8vdQB3kHzwFqSy7
echo 17s2b9ksz5y7abUm92cHwG8jEPCzK3dLnT
echo 1GDSuiThEV64c166LUFC9uDcVdGjqkxKyh
echo 1Me3ASYt5JCTAK2XaC32RMeH34PdprrfDx
echo 1CdufMQL892A69KXgv6UNBD17ywWqYpKut
echo 1BkkGsX9ZM6iwL3zbqs7HWBV7SvosR6m8N
echo 1PXAyUB8ZoH3WD8n5zoAthYjN15yN5CVq5
echo 1AWCLZAjKbV1P7AHvaPNCKiB7ZWVDMxFiz
echo 1G6EFyBRU86sThN3SSt3GrHu1sA7w7nzi4
echo 1MZ2L1gFrCtkkn6DnTT2e4PFUTHw9gNwaj
echo 1Hz3uv3nNZzBVMXLGadCucgjiCs5W9vaGz
echo 1Fo65aKq8s8iquKTT2r7HB1RWLGKPpXUo9
echo 16zRPnT8znwq42q7XeMkZUhb1bKqgRogyy
echo 1KrU4dHE5WrW8rhWDsTRjR21r8t3dsrS3R
echo 17uDfp5r4n441xkgLFmhNoSW1KWp6xVLD
echo 13A3JrvXmvg5w9XGvyyR4JEJqiLz8ZySY3
echo 16RGFo6hjq9ym6Pj7N5H7L1NR1rVPJyw2v
echo 1UDHPdovvR985NrWSkdWQDEQ1xuRiTALq
echo 15nf31J46iLuK1ZkTnqHo7WgN5cARFK3RA
echo 1Ab4vzG6wEQBDNQM1B2bvUz4fqXXdFk2WT
echo 1Fz63c775VV9fNyj25d9Xfw3YHE6sKCxbt
echo 1QKBaU6WAeycb3DbKbLBkX7vJiaS8r42Xo
echo 1CD91Vm97mLQvXhrnoMChhJx4TP9MaQkJo
echo 15MnK2jXPqTMURX4xC3h4mAZxyCcaWWEDD
echo 13N66gCzWWHEZBxhVxG18P8wyjEWF9Yoi1
echo 1NevxKDYuDcCh1ZMMi6ftmWwGrZKC6j7Ux
echo 19GpszRNUej5yYqxXoLnbZWKew3KdVLkXg
echo 1M7ipcdYHey2Y5RZM34MBbpugghmjaV89P
echo 18MwwaKdqb9pA5DCNhPmBSfykbu2z9NPPP
echo 1LtnvNT2HFNRB24gfGnSAA9EeVCdXcgCwp
echo 1HiaTjYuRJYoVwpm5XQBi5R8CvHGy7U4nz
echo 12mDGKq63GqWPXqLB1SgVVZ7xXSLDLNfnH
echo 13DZNTsQm4oPL5PoFoS5hGCA4Cd1x3R8bD
echo 1FvaqFLrLu2KGhseMoZMQ4H1wBKMbZWVxH
echo 1Lqn9DqsK28ym8MJjbWfGJTmXVgmBCwnvV
echo 183uKbB8UfDVy4cZF7oKDVLNnoNaj1mas
echo 1NxdNwJwMpLqUGFk9iaxjnTnMqvoYPHdww
echo 1G28T34uKbPZ4BCXG6hTB3JdpfmHo4bvCF
echo 1LhRcMEvVxVcPPSdPMKtgPwqZD2wPBMYjy
echo 1ANqiCXqWYsLiE4FQo3zXhyYtmEMsKsqvH
echo 17bEJKFHBz2Djjwrg5JABxM6oQzMxFQsNU
echo 1J87A8R2jKLgz9vZVrq9BrYj1hy8n9Lj6r
echo 1DhCKNi1vFua2cJS7kigp6u53F6yAGTgH2
echo 1KkfoJn8Jp7zT15FGzXdqWW1Zz3R2AKWaW
echo 1PkJR7Y8gPAzTxHj4DjKLWZ2rBHvdxPvnB
) > all_puzzles.txt

echo.
echo Created all_puzzles.txt with 90 unsolved puzzle addresses
echo (Puzzles 67-69, 71-160)
echo.

REM Count addresses
for /f %%A in ('findstr /r "^1" all_puzzles.txt ^| find /c /v ""') do set COUNT=%%A
echo Total addresses to search: %COUNT%
echo.

echo ============================================
echo Search Mode Options:
echo ============================================
echo.
echo 1. RANDOM SEARCH (recommended for multi-address)
echo    - Searches random keys across full range
echo    - Checks ALL addresses per key generated
echo    - Best when searching multiple addresses
echo.
echo 2. SEQUENTIAL from Puzzle 67 range
echo    - Starts at 2^66 and works upward
echo    - Good for focused puzzle 67 search
echo.
echo 3. SEQUENTIAL from Puzzle 130 range
echo    - Starts at 2^129 for higher puzzles
echo    - Very large keyspace
echo.

set /p MODE="Enter mode (1/2/3, default=1): "
if "%MODE%"=="" set MODE=1

echo.
echo Starting VanitySearch with GPU...
echo Searching for %COUNT% addresses simultaneously
echo Press Ctrl+C to stop
echo.

if "%MODE%"=="1" (
    echo Mode: Random search across all ranges
    VanitySearch.exe -gpu -stop -i all_puzzles.txt -o found_puzzle.txt
) else if "%MODE%"=="2" (
    echo Mode: Sequential from puzzle 67 range (0x40000000000000000)
    VanitySearch.exe -gpu -stop -k 40000000000000000 -i all_puzzles.txt -o found_puzzle.txt
) else if "%MODE%"=="3" (
    echo Mode: Sequential from puzzle 130 range
    VanitySearch.exe -gpu -stop -k 100000000000000000000000000000000 -i all_puzzles.txt -o found_puzzle.txt
) else (
    echo Invalid mode, using random search
    VanitySearch.exe -gpu -stop -i all_puzzles.txt -o found_puzzle.txt
)

echo.
echo ============================================
echo Search complete!
echo Check found_puzzle.txt for any results
echo ============================================

endlocal

