param(
    [string] $user,
    [string] $pass,
    [string] $server                 = "localhost",
    [string] $addTimestamp           = $true,
    [string] $includeConfigs         = $true,
    [string] $includeDatabase        = $false,
    [string] $includeBuildLogs       = $false,
    [string] $includePersonalChanges = $false,
    [string] $fileName               = "TeamCity_Backup_"
)

if ((!$user) -or (!$pass)) {
    Write-Error "You must specify a username and/or password"
    Exit 1
}

Import-Module -Name .\teamcitycredentials.psm1
$cred = Set-Credential -user $user -pass $pass

$RunBackupUrl = [System.String]::Format("{0}/httpAuth/app/rest/server/backup?addTimestamp={1}&includeConfigs={2}&includeDatabase{3}&includeBuildLogs={4}&includePersonalChanges={5}&fileName={6}",
                                        $server,
                                        $addTimestamp,
                                        $includeConfigs,
                                        $includeDatabase,
                                        $includeBuildLogs,
                                        $includePersonalChanges,
                                        $fileName);

$BackupStatusUrl = [System.String]::Format("{0}/httpAuth/app/rest/server/backup",
                                        $server);

$file = (Invoke-WebRequest -Uri $RunBackupUrl -Method POST -Credential $cred -UseBasicParsing).Content
Write-Host "Creating backup $file"