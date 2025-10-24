@echo off
REM gradlew.bat - minimal placeholder
if exist "%~dp0\gradle\wrapper\gradle-wrapper.jar" (
  java -jar "%~dp0\gradle\wrapper\gradle-wrapper.jar" %*
) else (
  echo Gradle wrapper jar missing. Please install Gradle or add gradle-wrapper.jar to gradle\wrapper.
  exit /b 1
)
