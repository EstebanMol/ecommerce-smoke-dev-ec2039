@echo off
chcp 65001 > nul
title Smoke Monitoring Ecommerce
cd /d E:\Sistemas\ecommerce-smoke

echo ==================================
echo INICIANDO SMOKE TEST
echo %date% %time%
echo ==================================

:: Limpiar log anterior
echo ================================== > smoke-last.log
echo EJECUCION: %date% %time% >> smoke-last.log
echo ================================== >> smoke-last.log

:: Ejecutar y mostrar en tiempo real, filtrando lineas relevantes
npx playwright test 2>&1 | powershell -Command "$input | ForEach-Object { if ($_ -match '(❌|✅|📋|AR\$|pipe\.store|Página:|inválido|passed|failed|PASSED|FAILED|Timeout|Warning|No se encontr)') { Write-Host $_; $_ | Out-File -FilePath 'smoke-last.log' -Append -Encoding utf8 } }"

:: Appendar al historico
echo. >> smoke-history.log
echo ================================== >> smoke-history.log
echo EJECUCION: %date% %time% >> smoke-history.log
echo ================================== >> smoke-history.log
type smoke-last.log >> smoke-history.log

echo.
echo ==================================
echo SMOKE TEST FINALIZADO
echo %date% %time%
echo ==================================
pause