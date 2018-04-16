param(
    [string] $zipfile,
    [string] $outdir
)

Add-Type -AssemblyName System.IO.Compression.FileSystem
$archive = [System.IO.Compression.ZipFile]::OpenRead($zipfile)
foreach ($entry in $archive.Entries) {
    $entryTargetFilePath = [System.IO.Path]::Combine($outdir, $entry.FullName)
    $entryDir = [System.IO.Path]::GetDirectoryName($entryTargetFilePath)

    if (!(Test-Path $entryDir)) {
        New-Item -ItemType Directory -Path $entryDir | Out-Null
    }

    if (!$entryTargetFilePath.EndsWith("\")) {
        [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $entryTargetFilePath, $true)
    }
}