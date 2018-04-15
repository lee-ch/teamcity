Add-Type -AssemblyName System.IO.Compression.FileSystem

param(
    [string] $filename,
    [string] $path
)
function Unzip
{
    [System.IO.Compression.ZipFile]::ExtractToDirectory($filename, $path)
}