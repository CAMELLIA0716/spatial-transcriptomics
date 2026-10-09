@echo off
chcp 65001 > nul
echo ============================================
echo  Spatial Transcriptomics 系统启动脚本
echo ============================================
echo.

echo [1/3] 检查 MySQL 服务...
sc query MySQL80 | findstr "RUNNING" > nul
if %errorlevel% neq 0 (
    echo [错误] MySQL 服务未启动，请先启动 MySQL 服务
    pause
    exit /b 1
)
echo [OK] MySQL 服务已启动
echo.

echo [2/3] 启动后端服务...
start "Backend" cmd /k "cd /d %~dp0backend && mvn spring-boot:run"
echo [OK] 后端服务启动中，请在弹出的窗口中看到 "Started BackendApplication" 后继续
echo.

echo [3/3] 启动前端服务...
start "Frontend" cmd /k "cd /d %~dp0front && npm run dev"
echo [OK] 前端服务启动中，请在弹出的窗口中看到 "Local:" 后继续
echo.

echo ============================================
echo  启动完成！
echo  - 后端: http://localhost:8080
echo  - 前端: http://localhost:5173 (或 5174)
echo ============================================
echo.
echo 提示: 关闭此窗口不会停止服务，如需停止请关闭对应的命令行窗口
pause
