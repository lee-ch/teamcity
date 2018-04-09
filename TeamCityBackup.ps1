$date = Get-Date
$dayskept = "-%days_kept%"
$dayskept_xml = "-%days_kept_xml%"
$day = (Get-Date).DayOfWeek
$delete_date = $date.AddDays($dayskept)
$path = "%tc_backup_path%"
$tc_conf_path = "%tc_conf_path%"
$backup_path = "%tc_backup_path%\%backup_file%$day.zip"
$server_xml = "$tc_conf_path\%server_settings_xml%"
$timestamp = "{0:MMddyy_HHmmss}" -f (Get-Date)
$xml_timestamp = "{0:MMddyy}" -f (Get-Date)
$old_xml_timestamp = "{0:MMddyy}" -f (Get-Date).AddDays($dayskept_xml)
$server_xml_backup = "$server_xml.$xml_timestamp"

$backups = @(Get-ChildItem $path)
foreach ($backup in $backups) {
    $backup_date = $backup.LastWriteTime
    if ($backup_date -lt $delete_date) {
        $full_path = $backup.FullName
        Write-Output "Removing old backup $full_path"
        del $full_path
    }
}

$old_server_xml = "$server_xml.$old_xml_timestamp"
if (Test-Path $old_server_xml) {
    Write-Output "Removing old $tc_conf_path\$server_xml.$old_xml_timestamp"
    del $old_server_xml
}
Write-Output "Backing up $server_xml to $server_xml_backup"
Copy-Item -Path $server_xml -Destination $server_xml_backup
$fileName = "%backup_file%$day"
.\tc_backup.ps1 -user %tc_user% -pass %tc_pass% -fileName $fileName -addTimestamp $true