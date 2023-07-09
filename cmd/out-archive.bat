set WORK_DIR=%1
set COMMIT=%2
set OUT_DIR=%3
set FILE_NAME=%4
powershell -ExecutionPolicy RemoteSigned -File %~dp0out-archive.ps1 -WorkDir %WORK_DIR% -Commit %COMMIT% -OutDir %OUT_DIR% -FileName %FILE_NAME%
