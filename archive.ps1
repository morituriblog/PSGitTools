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
        [string]$ArchiveName,
        [string[]]$Files
    )

    $gitDir = Get-GitDir -Path $WorkDir
    $archivePath = [System.IO.Path]::Combine($OutDir, $ArchiveName)
    $format = "zip"

    Set-Location $gitDir
    git archive $Commit -o $archivePath --format=$format $Files
}

function Start-ExtractZip {
    param(
        [string]$ZipFile,
        [string]$ExtractDir
    )

    Add-Type -AssemblyName System.IO.Compression.FileSystem

    [System.IO.Compression.ZipFile]::ExtractToDirectory($ZipFile, $ExtractDir)
}

function Out-GitFiles {
    param(
        [string]$WorkDir,
        [string]$Commit,
        [string]$OutDir,
        [string[]]$Files,
        [switch]$DeleteArchive
    )

    $zipName = "temp.zip"
    Out-GitArchive -WorkDir $WorkDir -Commit $Commit -OutDir $OutDir -ArchiveName $zipName -Files $Files

    $archivePath = [System.IO.Path]::Combine($OutDir, $zipName)
    Start-ExtractZip -ZipFile $archivePath -ExtractDir $OutDir

    if ($DeleteArchive) { Remove-Item -Path $archivePath }
}
