@echo off
title email-verify
setlocal EnableDelayedExpansion
call cl.bat
for %%a in (1.dat 2.dat *.thread) do if exist "%%a" del /f /q "%%a" >nul
:loop
	for /f %%a in ('dir /b *.thread 2^>nul') do (
		if exist "%%a" (
			for /f "tokens=1,2,3,4 delims=:" %%i in (%%a) do (
				if "%%k" equ "valid" (
				   echo !fg`black![%%l] !fg`white!%%i !fg`black!^(#%%j^) !fg`white-!is !fg`green!%%k!`r!
				) else if "%%k" equ "invalid" (
					echo !fg`black![%%l] !fg`white!%%i !fg`black!^(#%%j^) !fg`white-!is !fg`red!%%k!`r!
				)
				del /f /q "%%a" >nul
			)
		)
	)
	if exist "1.dat" (
		if exist "2.dat" (
			echo %fg`yellow%[*] Joining logs...%`r%
			call merge.bat
			<nul set /p=%fg`green%[*] Done^^!%`r%
			del /f /q "1.dat" >nul
			del /f /q "2.dat" >nul
			for /l %%i in (0,0,1) do pause >nul
		)
	)
	ping localhost -n 2 >nul
	goto :loop