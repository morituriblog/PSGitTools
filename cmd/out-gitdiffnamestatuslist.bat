set WORK_DIR=%1
set BEFORE_COMMIT=%2
set AFTER_COMMIT=%3
set OUT_FILE=%4
set ENCODING=%5
powershell -ExecutionPolicy RemoteSigned -File %~dp0out-gitdiffnamestatuslist.ps1 -WorkDir %WORK_DIR% -BeforeCommit %BEFORE_COMMIT% -AfterCommit %AFTER_COMMIT% -OutFile %OUT_FILE% -Encoding %ENCODING%
