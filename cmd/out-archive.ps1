param(
    [string]$WorkDir,
    [string]$Commit,
    [string]$OutDir,
    [string]$FileName
)

$rootDir = [System.IO.Path]::GetDirectoryName($MyInvocation.InvocationName)
$toolDir = [System.IO.Path]::GetDirectoryName($rootDir)
. ([System.IO.Path]::Combine($toolDir, "archive.ps1"))

$WorkDir = [System.IO.Path]::GetFullPath($WorkDir)

if (![System.IO.Directory]::Exists($OutDir)) {
    [System.IO.Directory]::CreateDirectory($OutDir) | Out-Null
}
$OutDir = [System.IO.Path]::GetFullPath($OutDir)

Out-GitArchive -WorkDir $WorkDir -Commit $Commit -OutDir $OutDir -FileName $FileName
