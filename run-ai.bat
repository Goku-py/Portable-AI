@echo off
color 0A
set MODEL=Qwen2.5-7B-Instruct-Q4_K_M.gguf
cls
echo.
echo  ================================================
echo   PORTABLE AI - YOUR OWN CHATBOT
echo  ================================================
echo.
echo   [1/3] Checking files...
if not exist .\llamafile-0.10.5.exe (echo   ERROR: llamafile-0.10.5.exe is missing from this pendrive. & pause & exit /b 1)
if not exist .\%MODEL% (echo   ERROR: %MODEL% is missing - copy it to this pendrive first. & pause & exit /b 1)
echo   OK - everything is here.
echo.
echo   [2/3] Loading the model... this takes a few minutes.
start /b .\llamafile-0.10.5.exe --server --model %MODEL% -ngl 0
set /a TRIES=0
:wait
set /a TRIES+=1
if %TRIES% GTR 150 goto failed
curl -s http://127.0.0.1:8080/health | findstr "ok" >nul && goto loaded
ping -n 6 127.0.0.1 >nul
goto wait
:loaded
echo   [3/3] Model loaded! Opening your browser...
start "" http://127.0.0.1:8080/
echo.
echo  ================================================
echo   Chat here:  http://127.0.0.1:8080/
echo  ================================================
echo   The AI is running. Close this window to stop it.
pause
exit /b 0
:failed
echo   ERROR: the model could not be loaded.
echo   Check that %MODEL% is fully copied to this pendrive.
pause