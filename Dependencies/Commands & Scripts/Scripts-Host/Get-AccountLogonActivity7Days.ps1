Param (
    [datetime]$StartTime = $((Get-Date).AddDays(-7)),
    [datetime]$EndTime = $(Get-Date)
)
function LogonTypes {
    param($number)
    switch ($number) {
        0  { 'LocalSystem' }
        2  { 'Interactive' }
        3  { 'Network' }
        4  { 'Batch' }
        5  { 'Service' }
        7  { 'Unlock' }
        8  { 'NetworkClearText' }
        9  { 'NewCredentials' }
        10 { 'RemoteInteractive' }
        11 { 'CachedInteractive' }
        12 { 'CachedRemoteInteractive' }
        13 { 'CachedUnlock' }
    }
}

function LogonInterpretation {
    param($number)
    switch ($number) {
        0  { 'Local System' }
        2  { 'Logon Via Console' }
        3  { 'Network Remote Logon' }
        4  { 'Scheduled Task Logon' }
        5  { 'Windows Service Account Logon' }
        7  { 'Screen Unlock' }
        8  { 'Clear Text Network Logon' }
        9  { 'Alt Credentials Other Than Logon' }
        10 { 'RDP TS RemoteAssistance' }
        11 { 'Cached Local Credentials' }
        12 { 'Cached RDP TS RemoteAssistance' }
        13 { 'Cached Screen Unlock' }
    }
}

$FilterHashTable = @{
    LogName   = 'Security'
    ID        = 4624,4625,4634,4647,4648
}
if ($PSBoundParameters.ContainsKey('StartTime')){
    $FilterHashTable['StartTime'] = $StartTime
}
if ($PSBoundParameters.ContainsKey('EndTime')){
    $FilterHashTable['EndTime'] = $EndTime
}

Get-WinEvent -FilterHashtable $FilterHashTable `
| Set-Variable GetAccountActivity -Force

$ObtainedAccountActivity = $GetAccountActivity | ForEach-Object {
    [pscustomobject]@{
        TimeStamp            = $_.TimeCreated
        UserAccount          = $_.Properties.Value[5]
        UserDomain           = $_.Properties.Value[6]
        Type                 = $_.Properties.Value[8]
        LogonType            = "$(LogonTypes -number $($_.Properties.Value[8]))"
        LogonInterpretation  = "$(LogonInterpretation -number $($_.Properties.Value[8]))"
        WorkstationName      = $_.Properties.Value[11]
        SourceNetworkAddress = $_.Properties.Value[18]
        SourceNetworkPort    = $_.Properties.Value[19]
    }
}
$ObtainedAccountActivity | Sort-Object TimeStamp


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUEufPeBnixVCHHZm38wLV4Bt8
# /kugggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
# AQUFADAzMTEwLwYDVQQDDChQb1NoLUVhc3lXaW4gQnkgRGFuIEtvbW5pY2sgKGhp
# Z2gxMDFicm8pMB4XDTIxMTIxNDA1MDIwMFoXDTMxMTIxNDA1MTIwMFowMzExMC8G
# A1UEAwwoUG9TaC1FYXN5V2luIEJ5IERhbiBLb21uaWNrIChoaWdoMTAxYnJvKTCC
# ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALvIxUDFEVGB/G0FXPryoNlF
# dA65j5jPEFM2R4468rjlTVsNYUOR+XvhjmhpggSQa6SzvXtklUJIJ6LgVUpt/0C1
# zlr1pRwTvsd3svI7FHTbJahijICjCv8u+bFcAR2hH3oHFZTqvzWD1yG9FGCw2pq3
# h4ahxtYBd1+/n+jOtPUoMzcKIOXCUe4Cay+xP8k0/OLIVvKYRlMY4B9hvTW2CK7N
# fPnvFpNFeGgZKPRLESlaWncbtEBkexmnWuferJsRtjqC75uNYuTimLDSXvNps3dJ
# wkIvKS1NcxfTqQArX3Sg5qKX+ZR21uugKXLUyMqXmVo2VEyYJLAAAITEBDM8ngUC
# AwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0G
# A1UdDgQWBBSDJIlo6BcZ7KJAW5hoB/aaTLxFzTANBgkqhkiG9w0BAQUFAAOCAQEA
# ouCzal7zPn9vc/C9uq7IDNb1oNbWbVlGJELLQQYdfBE9NWmXi7RfYNd8mdCLt9kF
# CBP/ZjHKianHeZiYay1Tj+4H541iUN9bPZ/EaEIup8nTzPbJcmDbaAGaFt2PFG4U
# 3YwiiFgxFlyGzrp//sVnOdtEtiOsS7uK9NexZ3eEQfb/Cd9HRikeUG8ZR5VoQ/kH
# 2t2+tYoCP4HsyOkEeSQbnxlO9s1jlSNvqv4aygv0L6l7zufiKcuG7q4xv/5OvZ+d
# TcY0W3MVlrrNp1T2wxzl3Q6DgI+zuaaA1w4ZGHyxP8PLr6lMi6hIugI1BSYVfk8h
# 7KAaul5m+zUTDBUyNd91ojGCAegwggHkAgEBMEcwMzExMC8GA1UEAwwoUG9TaC1F
# YXN5V2luIEJ5IERhbiBLb21uaWNrIChoaWdoMTAxYnJvKQIQeugH5LewQKBKT6dP
# XhQ7sDAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkq
# hkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGC
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUSI4UEClVZSdbO9LJyXsVa5K9a1AwDQYJKoZI
# hvcNAQEBBQAEggEAr/HlxN7PEz12YVHM+dEkGPP4lseKKU9Gi9K8JuNrKrx2LIoM
# S5lKegjf/IMvUf2dteGa71KsuVghtNdieykSdJ1x7rn7bub8OAPHOvnh4Mjo8Xue
# eF+ddX/fTpJfyl559+JjVxbqjRIejrw7tx5Gs0iRKT1ldeS1eJosWgVi9pd270Se
# NFaQsDWifGtw1GGoIVXsmdPsz7QhO9G23TrHlTXWfx5aBhyoXMq/8Q1XO0vxLPy6
# jnu0eHQVtLJWJHeFS1FRcXUiFnQbYFxs2KiC+B58o4GkMeO6x9C2fsSuAogycK5r
# 91CxwLmleRfm0y8oaqZaESj7i3x23IyHJg1gqQ==
# SIG # End signature block

