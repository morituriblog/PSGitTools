set WORK_DIR=%1
set COMMIT=%2
set OUT_DIR=%3
powershell -ExecutionPolicy RemoteSigned -File %~dp0out-gitfiles.ps1 -WorkDir %WORK_DIR% -Commit %COMMIT% -OutDir %OUT_DIR%
