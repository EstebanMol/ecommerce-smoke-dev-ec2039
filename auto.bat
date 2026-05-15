@echo off

cd /d E:\Sistemas\ecommerce-smoke

npx playwright test >> smoke-log.txt 2>&1