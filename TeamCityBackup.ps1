$date = Get-Date
$dayskept = "-%days_kept%"
$day = (Get-Date).DayOfWeek
$delete_date = $date.AddDays($dayskept)
$path = "%tc_backup_path%"
$backup_path = "%tc_backup_path%\%backup_file%$day.zip"

$backups = @(Get-ChildItem $path)
foreach ($backup in $backups) {
    $backup_date = $backup.LastWriteTime
    if ($backup_date -lt $delete_date) {
        $full_path = $backup.FullName
        Write-Output "Removing old backup $full_path"
        del $full_path
    }
}