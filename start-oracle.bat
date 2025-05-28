@echo off
echo Starting Oracle Database for Liquibase Development...
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not running. Please start Docker Desktop.
    pause
    exit /b 1
)

echo Pulling Oracle Database image (this may take a while on first run)...
docker-compose pull oracle-db

echo.
echo Starting Oracle Database container...
docker-compose up -d oracle-db

echo.
echo Waiting for Oracle Database to initialize...
echo This may take 2-3 minutes on first startup...
echo.

:wait_loop
docker-compose logs oracle-db | findstr "DATABASE IS READY TO USE" >nul 2>&1
if %errorlevel% equ 0 (
    goto database_ready
)

echo Still waiting for Oracle Database...
timeout /t 10 /nobreak >nul
goto wait_loop

:database_ready
echo.
echo ================================================
echo Oracle Database is ready!
echo ================================================
echo Connection Details:
echo   Host: localhost
echo   Port: 1521
echo   SID: XE
echo   Username: admin
echo   Password: admin_password
echo   JDBC URL: jdbc:oracle:thin:@localhost:1521:XE
echo.
echo Management Tools:
echo   Adminer: http://localhost:8080
echo   Oracle EM: https://localhost:5500/em
echo.
echo You can now run Liquibase commands:
echo   liquibase --defaults-file=liquibase-dev.properties status
echo   liquibase --defaults-file=liquibase-dev.properties update
echo.
pause
