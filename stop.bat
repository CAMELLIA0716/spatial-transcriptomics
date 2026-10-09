@echo off
chcp 65001 > nul
echo ============================================
echo  Spatial Transcriptomics 系统停止脚本
echo ============================================
echo.

echo 正在停止前端和后端服务...
taskkill /f /im java.exe > nul 2>&1
taskkill /f /im node.exe > nul 2>&1

echo.
echo [OK] 所有服务已停止
echo ============================================
pause
