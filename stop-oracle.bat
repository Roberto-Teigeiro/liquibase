@echo off
echo Stopping Oracle Database...

docker-compose down

echo.
echo Oracle Database stopped.
echo.
echo To remove all data and start fresh, run:
echo   docker-compose down -v
echo.
pause
