param(
    [string]$WorkDir,
    [string]$BeforeCommit,
    [string]$AfterCommit,
    [string]$OutFile,
    [ValidateSet("utf8", "oem")]
    [string]$Encoding = "utf8"
)

$rootDir = [System.IO.Path]::GetDirectoryName($MyInvocation.InvocationName)
$toolDir = [System.IO.Path]::GetDirectoryName($rootDir)
. ([System.IO.Path]::Combine($toolDir, "diff.ps1"))

$WorkDir = [System.IO.Path]::GetFullPath($WorkDir)

$OutFile = [System.IO.Path]::GetFullPath($OutFile)
$outDir = [System.IO.Path]::GetDirectoryName($OutFile)
if (![System.IO.Directory]::Exists($outDir)) {
    [System.IO.Directory]::CreateDirectory($outDir) | Out-Null
}

$objList = Get-GitDiffNameStatusList -WorkDir $WorkDir -BeforeCommit $BeforeCommit -AfterCommit $AfterCommit
$objList | Out-File -FilePath $OutFile -Encoding $Encoding
