@echo off
color 0A
for /f %%a in ('powershell -c "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"') do set RAM=%%a
if not defined RAM set RAM=0
if %RAM% GEQ 64 (set T=72b) else if %RAM% GEQ 32 (set T=32b) else if %RAM% GEQ 16 (set T=12b) else if %RAM% GEQ 8 (set T=7b) else if %RAM% GEQ 6 (set T=3b) else if %RAM% GEQ 4 (set T=1.5b) else (set T=0.5b)
cls
echo  Searching the internet for the best model for your PC...
echo.
del "%TEMP%\model.txt" 2>nul
powershell -noprofile -executionpolicy bypass -command "$t='%T%';$o='%TEMP%\model.txt';for($i=0;$i -lt 3;$i++){try{$r=Invoke-RestMethod ('https://huggingface.co/api/models?search='+$t+'&filter=gguf&sort=downloads&direction=-1&limit=20');$m=$r|Where-Object{$_.id -match '(?i)(^|[^a-z0-9])'+$t+'([^a-z0-9]|$)'}|Select-Object -First 1;if($m){$f=Invoke-RestMethod ('https://huggingface.co/api/models/'+$m.id+'/tree/main?recursive=true');$g=$f|Where-Object{$_.path -like '*Q4_K_M.gguf' -and $_.path -notlike '*Q2_K*' -and $_.path -notlike '*Q3_K*'}|Select-Object -First 1;if(-not $g){$g=$f|Where-Object{$_.path -like '*.gguf'}|Select-Object -First 1};if($g){'MODEL='+$m.id|Out-File $o -Encoding ascii;'LINK=https://huggingface.co/'+$m.id+'/resolve/main/'+$g.path|Out-File $o -Append -Encoding ascii;exit 0}}}catch{};Start-Sleep -Seconds 2}"
for /f "tokens=1,* delims==" %%a in ('findstr /b "MODEL=" "%TEMP%\model.txt" 2^>nul') do set "M=%%b"
for /f "tokens=1,* delims==" %%a in ('findstr /b "LINK=" "%TEMP%\model.txt" 2^>nul') do set "L=%%b"
if "%M%"=="" (
  if %RAM% GEQ 64 (set M=Qwen2.5-72B-Instruct-Q4_K_M.gguf& set L=https://huggingface.co/bartowski/Qwen2.5-72B-Instruct-GGUF/resolve/main/Qwen2.5-72B-Instruct-Q4_K_M.gguf) else if %RAM% GEQ 32 (set M=Qwen2.5-32B-Instruct-Q4_K_M.gguf& set L=https://huggingface.co/bartowski/Qwen2.5-32B-Instruct-GGUF/resolve/main/Qwen2.5-32B-Instruct-Q4_K_M.gguf) else if %RAM% GEQ 16 (set M=Mistral-Nemo-Instruct-2407-Q4_K_M.gguf& set L=https://huggingface.co/bartowski/Mistral-Nemo-Instruct-2407-GGUF/resolve/main/Mistral-Nemo-Instruct-2407-Q4_K_M.gguf) else if %RAM% GEQ 8 (set M=Qwen2.5-7B-Instruct-Q4_K_M.gguf& set L=https://huggingface.co/bartowski/Qwen2.5-7B-Instruct-GGUF/resolve/main/Qwen2.5-7B-Instruct-Q4_K_M.gguf) else if %RAM% GEQ 6 (set M=qwen2.5-3b-instruct-q4_k_m.gguf& set L=https://huggingface.co/Qwen/Qwen2.5-3B-Instruct-GGUF/resolve/main/qwen2.5-3b-instruct-q4_k_m.gguf) else if %RAM% GEQ 4 (set M=qwen2.5-1.5b-instruct-q4_k_m.gguf& set L=https://huggingface.co/Qwen/Qwen2.5-1.5B-Instruct-GGUF/resolve/main/qwen2.5-1.5b-instruct-q4_k_m.gguf) else (set M=qwen2.5-0.5b-instruct-q4_k_m.gguf& set L=https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf)
  echo  No internet found - using the proven fallback model.
)
cls
echo.
echo  ================================================
echo   Download this model for your PC:
echo.
echo     %M%
echo.
echo   Direct download link:
echo.
echo     %L%
echo  ================================================
echo.
echo   Copy the .gguf file to this pendrive, then run run-ai.bat
pause
