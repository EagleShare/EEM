
set /p APIURL=Please Enter EEM API URL: 
echo %APIURL%

set filepath=%cd%\Absence_ui\static\js
for %%F in ("%filepath%\*.js") do (set filename=%%~nxF)
cscript replace.vbs "%filepath%\%filename%" "LABS_EEM_API_URL_" "%APIURL%"