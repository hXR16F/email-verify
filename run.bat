:: Programmed by hXR16F
:: hXR16F.ar@gmail.com | https://github.com/hXR16F

@echo off
title email-verify
setlocal EnableDelayedExpansion
if not "%1" equ "" goto :%1
color 07
call cl.bat & rem https://github.com/hXR16F/cl
echo %fg`cyan%[*] Programmed by hXR16F%`r%
<nul set /p =%fg`yellow%[*] Reading 'emails.txt' file...%`r%
if not exist "emails.txt" (
	echo.
	echo %fg`red%[*] Can't find 'emails.txt' file^^!%`r%
	echo %fg`black%[*] Press any key to exit...%`r%
	pause >nul
	goto :eof
) else (
	set lines=0
	for /f %%i in (emails.txt) do (set /a lines+=1)
	echo %fg`white% !lines! %fg`yellow%entries%`r%
)
start /b %~nx0 2
start /b helper.bat

:1
	set count_1=1
	for /f "tokens=*" %%i in (emails.txt) do (
		set /a dummy=!count_1! %% 2
		if !dummy! equ 0 (
			email-verify %%i | findstr /C:"success: true" >nul && (
				echo %%i:!count_1!:valid:1> "!count_1!.thread"
				if not exist "logs" md "logs"
				echo %%i>> "logs/valid-1.txt"
			) || (
				echo %%i:!count_1!:invalid:1> "!count_1!.thread"
				if not exist "logs" md "logs"
				echo %%i>> "logs/invalid-1.txt"
			)
		)
		set /a count_1+=1
	)
	goto :finished 1

:2
	set count_2=1
	for /f "tokens=*" %%i in (emails.txt) do (
		set /a dummy=!count_2! %% 2
		if !dummy! equ 1 (
			email-verify %%i | findstr /C:"success: true" >nul && (
				echo %%i:!count_2!:valid:2> "!count_2!.thread"
				if not exist "logs" md "logs"
				echo %%i>> "logs/valid-2.txt"
			) || (
				echo %%i:!count_2!:invalid:2> "!count_2!.thread"
				if not exist "logs" md "logs"
				echo %%i>> "logs/invalid-2.txt"
			)
		)
		set /a count_2+=1
	)
	goto :finished 2

:finished %1
	if "%1" equ "" (
		echo %fg`yellow%[1] Thread finished job%`r%
		echo. > "1.dat"
		for /l %%i in (0,0,1) do pause >nul
	) else (
		echo %fg`yellow%[%1] Thread finished job%`r%
		echo. > "2.dat"
		for /l %%i in (0,0,1) do pause >nul
	)
