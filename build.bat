@echo off
chcp 65001 >nul
echo [正在編譯] 使用 Windows 原生 .NET 編譯器構建單一可攜式 HardwareBenchmarker_Portable.exe...
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe /optimize /target:exe /out:"%~dp0HardwareBenchmarker_Portable.exe" "%~dp0HardwareBenchmarker.cs"
if %ERRORLEVEL% EQU 0 (
    copy /y "%~dp0HardwareBenchmarker_Portable.exe" "%~dp0dist\HardwareBenchmarker_Portable.exe" >nul
    echo [成功] 單一可攜式執行檔編譯完成: HardwareBenchmarker_Portable.exe
) else (
    echo [錯誤] 編譯失敗，請檢查系統環境。
)
pause
