@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-claude46.ps1" %*
exit /b %ERRORLEVEL%
