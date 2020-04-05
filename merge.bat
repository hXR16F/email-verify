@echo off
cd logs
if exist "invalid-2.txt" (
	for /f "tokens=*" %%i in (invalid-2.txt) do echo %%i>> "invalid-1.txt"
	del /f /q "invalid-2.txt" >nul
)
if exist "valid-2.txt" (
	for /f "tokens=*" %%i in (valid-2.txt) do echo %%i>> "valid-1.txt"
	del /f /q "valid-2.txt" >nul
)
if not exist "invalid.txt" (
	if exist "invalid-1.txt" (
		ren "invalid-1.txt" "invalid.txt"
	)
) else (
	if exist "invalid-1.txt" (
		for /f "tokens=*" %%i in (invalid-1.txt) do echo %%i>> "invalid.txt"
	)
)
if not exist "valid.txt" (
	if exist "valid-1.txt" (
		ren "valid-1.txt" "valid.txt"
	)
) else (
	if exist "valid-1.txt" (
		for /f "tokens=*" %%i in (valid-1.txt) do echo %%i>> "valid.txt"
	)
)
if exist "invalid-1.txt" del /f /q "invalid-1.txt" >nul
if exist "valid-1.txt" del /f /q "valid-1.txt" >nul
cd ..
exit /b