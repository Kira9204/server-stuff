@setlocal enableextensions enabledelayedexpansion
@echo off
rem This script detets your current internet gateway and gives you the option to change to another one.
rem In this example we have 3 internet gateways on the same LAN, and depending on the load of each gateway
rem We want to move freely between them
rem 
rem if this script does not run as admin, trigger a uac prompt asking to run as admin
rem if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
color 0f
title Snekabel Gateway Switcher
echo Snekabel Gateway Switcher Version 2018-07-30 by Erik Welander (Kira)
set gateway_1=10.0.1.1
set gateway_1_name=4G connection at %gateway_1% ^^(TB - Telenor^^)
set gateway_2=10.0.1.2
set gateway_2_name=4G connection at %gateway_2% ^^(Yvonne - Tele2^^)
set gateway_3=10.0.1.10
set gateway_3_name=ADSL connection at %gateway_3% ^^(Roger - Telia^^)
set ping_addr="1.1.1.1"
:begin
set cg=0
rem Reset the errorcode
cmd /c exit /b 0
route -4 print | find "%gateway_1% " >nul 2>&1
if %errorlevel% equ 0 (set cg=1)
route -4 print | find "%gateway_2% " >nul 2>&1
if %errorlevel% equ 0 (set cg=2)
route -4 print | find "%gateway_3% " >nul 2>&1
if %errorlevel% equ 0 (set cg=3)

if %cg% equ 0 (
echo no gateway found!
)

if %cg% equ 1 (echo You are currently using the %gateway_1_name%)
if %cg% equ 2 (echo You are currently using the %gateway_2_name%)
if %cg% equ 3 (echo You are currently using the %gateway_3_name%)

:selection
echo =================================================
echo 1. Change gateway to %gateway_1_name%.
echo 2. Change gateway to %gateway_2_name%.
echo 3. Change gateway to %gateway_3_name%.
echo 4. Print routing table.
echo 5. Remove gateway routes and renew IP lease.
echo 6. Exit this script.
echo =================================================
set /p choice="What do you want to do: "

if %choice% equ 1 (
echo Changing default gateway to %gateway_1_name%...
route delete 0.0.0.0 mask 0.0.0.0 >nul 2>&1
route add 0.0.0.0 mask 0.0.0.0 %gateway_1% metric 2 >nul 2>&1

echo Testing internet connection...
ping -n 1 %ping_addr% | find "TTL=" >nul
if errorlevel 1 (
    echo No internet connection found, try another gateway!
) else (
    echo OK
)

goto begin
)

if %choice% equ 2 (
echo changing default gateway to %gateway_2_name%...
route delete 0.0.0.0 mask 0.0.0.0 >nul 2>&1
route add 0.0.0.0 mask 0.0.0.0 %gateway_2% metric 2 >nul 2>&1

echo Testing internet connection...
ping -n 1 %ping_addr% | find "TTL=" >nul
if errorlevel 1 (
    echo No internet connection found, try another gateway!
) else (
    echo OK
)

goto begin
)

if %choice% equ 3 (
echo changing default gateway to %gateway_3_name%...
route delete 0.0.0.0 mask 0.0.0.0 >nul 2>&1
route add 0.0.0.0 mask 0.0.0.0 %gateway_3% metric 2 >nul 2>&1

echo Testing internet connection...
ping -n 1 %ping_addr% | find "TTL=" >nul
if errorlevel 1 (
    echo No internet connection found, try another gateway!
) else (
    echo OK
)

goto begin
)

if %choice% equ 4 (
route -4 print
goto begin
)

if %choice% equ 5 (
echo removing gateway routes...
route delete 0.0.0.0 mask 0.0.0.0 >nul 2>&1
echo renewing IP lease...
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
goto begin
)

if %choice% equ 6 (
endlocal
exit
)

cls
echo invalid selection!
goto selection