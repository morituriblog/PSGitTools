function Get-GitOutputList {
    param(
        [ScriptBlock]$GitCmd
    )

    $enc = [System.Console]::OutputEncoding
    try {
        [System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
        $outText = $GitCmd.Invoke()
        if ([string]::IsNullOrEmpty($outText)) {
            return ""
        }
        return $outText.Split("`r`n")
    } finally {
        [System.Console]::OutputEncoding = $enc
    }
}

function ConvertFrom-GitDiffNameStatusLines {
    process {
        $line = ($_ | Out-String)

        $cols = $line.Split("`t")

        $hash = @{
            Status = $cols[0];
            Before = $cols[1];
            After = $cols[1];
        }
    
        if ($hash.Status.StartsWith("A")) {
            $hash.Before = ""
        } elseif ($hash.Status.StartsWith("D")) {
            $hash.After = ""
        }
    
        if ($cols.Count -gt 2) { $hash.After = $cols[2] }
    
        return [PSCustomObject]$hash
    }
}

function Get-GitDiffNameStatusList {
    param(
        [string]$WorkDir,
        [string]$BeforeCommit,
        [string]$AfterCommit
    )

    Set-Location -Path $WorkDir
    $outLines = Get-GitOutputList -GitCmd { git diff --name-status $BeforeCommit $AfterCommit }
    return ($outLines | ConvertFrom-GitDiffNameStatusLines)
}
