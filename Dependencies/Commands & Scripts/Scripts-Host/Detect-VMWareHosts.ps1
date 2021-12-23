$VMwareDetected   = $False
$VMNetworkAdapter = $(Get-WmiObject Win32_NetworkAdapter -Filter 'Manufacturer LIKE "%VMware%" OR Name LIKE "%VMware%"')
$VMBios           = $(Get-WmiObject Win32_BIOS -Filter 'SerialNumber LIKE "%VMware%"')
$VMWareService    = $(Get-Service | Where-Object {$_.Name -match "vmware" -and $_.Status -eq 'Running'} | Select-Object -ExpandProperty Name)
$VMWareProcess    = $(Get-Process | Where-Object Name -match "vmware" | Select-Object -ExpandProperty Name)
$VMToolsProcess   = $(Get-Process | Where-Object Name -match "vmtoolsd" | Select-Object -ExpandProperty Name)
if($VMNetworkAdapter -or $VMBios -or $VMToolsProcess) {
    $VMwareDetected = $True
}
[PSCustomObject]@{
    PSComputerName   = $env:COMPUTERNAME
    Name             = 'VMWare Detection'
    VMWareDetected   = $VMwareDetected
    VMNetworkAdapter = $VMNetworkAdapter
    VMBIOS           = $VMBIOS
    VMWareService    = $VMWareService
    VMWareProcess    = $VMWareProcess
    VMToolsProcess   = $VMToolsProcess
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUfCZoZ+9S4D8uOlA9/59NRfjz
# yzigggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUY4rKrnBstirnLneGGtpw9RVfhGowDQYJKoZI
# hvcNAQEBBQAEggEAGPxhgyx76zFyEncmE6vyWmYJQtKUx/X4alXmEEJc1Vybd2JT
# HaPnoaUp9oPCggICY3II3pxiWksxk1XOfT7cD5J/+f+drcxwJX36T7Lnoo8nG8IO
# lTTyo0KdNtVUD8ASTV/90WOcos4ky3pN1jvD/vCnpF2buhSpKXOfJE0hhNCcrKu5
# GFxE8Ea1BhnchGsBF+A3J+NNV+sMF4w2BW/1YMDwO3PG4H5fqokfSpUfg6rIwwpN
# ErwsUHqtF9VWi2G8mRDoVTvzt6To3nrA16/oKbbJUcogjDZGm3qejYXSc8YLOpms
# Ui5JMbLnE0BdajxWbp8SBZBvIlEI8cBhmHaeqw==
# SIG # End signature block
