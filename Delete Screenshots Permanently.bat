@echo off

if exist "%USERPROFILE%\Pictures\Screenshots\" (
	del /Q "%USERPROFILE%\Pictures\Screenshots\*"
	echo All screenshots have been deleted.
) else (
	echo Screenshots directory does not exist. 
)
pause