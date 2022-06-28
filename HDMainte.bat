@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
color 4f
title Hiolty Digital Media Maintenance
    echo Your running this utility without Admin Priviliges.
	echo.
	echo Admin Privileges are required for you to use this utility.
	echo.
	echo AP is required because the utility requires your permission so the utility can access the OS.
	>nul timeout /t 3
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    
	
	exit /B
	

:gotAdmin
color 2f
echo.
title APP success. Loading HDMUtility
echo Thank you! HDMUtility will load in a second.
>nul timeout /t 1  

   pushd "%CD%"
    CD /D "%~dp0"



color 1f
cls
title HDMUtility
::===========================================================================
setlocal enabledelayedexpansion
setlocal EnableExtensions
pushd "%~dp0"
cd /d "%~dp0"
:MAINMENU
cls
echo	HioltyDigitalMediaMaintenance
echo. =======================================================:
echo.
Echo.     [1] Fix Wi-Fi not working. [ONLY WORKS ON LENOVO IDEAPAD 3 14IIL05]
Echo.
Echo.     [2] Show Serial Number
echo. 
Echo.     [3] Exit
Echo.
echo. =======================================================:
choice /C:123 /N /M "Enter Your Choice [1,2,3] : "
if errorlevel 3 goto :Exit
if errorlevel 2 goto :SerialNotice
if errorlevel 1 goto :Wifi
::===========================================================================

:donemain

cls
echo	Specific actions are now done. Choose an action
echo.
echo. 
echo 	HioltyDigitalMediaMaintenance
echo. =======================================================:
echo.
Echo.     [1] Fix Wi-Fi not working.
Echo.
Echo.     [2] Show Serial Number
echo. 
Echo.     [3] Exit
Echo.
echo. =======================================================:
choice /C:123 /N /M "Enter Your Choice [1,2,3] : "
if errorlevel 3 goto :Exit
if errorlevel 2 goto :SerialNotice
if errorlevel 1 goto :Wifi
::===========================================================================



:Wifi
cls
echo.
echo Preparing the Tool. You may experience blank white screen on desktop [UtilWindow not affected]
>nul timeout /t 2
>nul taskkill /f /im explorer.exe

echo.
echo Restart Wi-Fi Drivers initiated.

>nul pnputil /disable-device "PCI\VEN_8086&DEV_34F0&SUBSYS_02348086&REV_30\3&11583659&1&A3"

echo Please Wait.

>nul timeout /t 5
>nul pnputil /enable-device "PCI\VEN_8086&DEV_34F0&SUBSYS_02348086&REV_30\3&11583659&1&A3"
>nul timeout /t 3
explorer.exe

echo.
echo Done! Please check your internet connection. If problem occurs, open Company Portal then Support.

pause

goto donemain

:exit
cls

echo Thank you for using HDMUtility. Have a great day! HDMUtility will close automatically in 3 seconds.
>nul timeout /t 3


:SerialNotice
cls
echo.

echo This utility shows your serial number.

echo.

echo Do not give your serial number to anyone [except for HDM IT Admins]

echo.

echo "Do you accept this statement?"

choice /C:YN /N /M "Enter Your Choice [Y,N] : "
if errorlevel 2 goto :MAINMENU
if errorlevel 1 goto :Serial

:Serial
cls
echo.

echo Please wait while we get your Serial Number from your BIOS.
echo.
echo This may take 5 seconds.
>nul timeout /t 5
cls
echo.
echo Below is your serial number:

wmic bios get serialnumber

echo.

pause
goto donemain