@echo off
setlocal

set APP_ID=me.aap.fermata.av1298
set APP_NAME=Fermata AV1298
set APP_ID_SFX=.av1298

echo Building Fermata AV1298 debug APK...
call gradlew.bat assembleAutoDebug -PAPP_ID=%APP_ID% -PAPP_NAME="%APP_NAME%" -PAPP_ID_SFX=%APP_ID_SFX%

if errorlevel 1 (
  echo.
  echo Build FAILED.
  exit /b 1
)

echo.
echo Build complete. Searching APK...
for /r %%f in (*.apk) do echo %%f

endlocal
