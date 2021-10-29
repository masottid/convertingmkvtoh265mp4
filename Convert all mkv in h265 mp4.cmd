@echo off
cls
color 0C
echo ---------------------------------
echo WARNING!! YOU NEED TO HAVE FFMPEG IN ORDER TO CONVERT FILES
echo You can install it with option 1
echo ----------------------------------
pause
color 0F
echo ----------------------------------
echo Do you want to install chocolatey and ffmpeg ?
echo 1. Install
echo 2. Convert with NVIDIA NVENC
echo 3. Convert with automatic hw acceleration
echo ----------------------------------
set /p a=

::Install Chocolatey and FFMPEG

IF %a%==1 (@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install ffmpeg -y)

::Convert options in ffmpeg

IF %a%==2 (for %%a in ("*.mkv") do ffmpeg -hwaccel auto -i "%%a" -c:v hevc_nvenc -preset fast -b:v 1100K -c:a copy "%%a".mp4)

IF %a%==3 (for %%a in ("*.mkv") do ffmpeg -hwaccel auto -i "%%a" -c:v libx265 -preset fast -b:v 1100K -c:a copy "%%a".mp4)

timeout /t 5
pause
