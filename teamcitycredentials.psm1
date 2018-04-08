function Set-Credential() {
    param(
        [string] $user,
        [string] $pass
    )

    $secpass = $pass | ConvertTo-SecureString -AsPlainText -Force
    $Credentials = New-Object System.Management.Automation.PSCredential($user, $secpass)
    return $Credentials
}

Export-ModuleMember -Function Set-Credential