function Get-GitDir {
    param(
        [string]$Path
    )

    $maxCount = $Path.Split([System.IO.Path]::DirectorySeparatorChar).Count
    $tempPath = $Path

    for ($i = 0; $i -lt $maxCount; $i++) {
        if ([System.IO.Directory]::Exists([System.IO.Path]::Combine($tempPath, ".git"))) {
            return $tempPath
        } else {
            $tempPath = [System.IO.Path]::GetDirectoryName($tempPath)
        }
    }
    return $tempPath
}

function Out-GitArchive {
    param(
        [string]$WorkDir,
        [string]$Commit,
        [string]$OutDir,
        [string]$FileName
    )

    $gitDir = Get-GitDir -Path $WorkDir
    $archivePath = [System.IO.Path]::Combine($OutDir, $FileName)
    $format = "zip"

    Set-Location $gitDir
    git archive $Commit -o $archivePath --format=$format
}
