function Compile-XmlFiles {
    param (
        [string]$LocationOfXMLsToCompile,
        [string]$LocationToSaveCompiledXML
    )
    Remove-Item -Path "$LocationToSaveCompiledXML" -Force
    Start-Sleep -Milliseconds 250

    $XmlFiles = Get-ChildItem "$LocationOfXMLsToCompile"
    $XmlFiles | Where-Object { (Get-Content $PSItem).Length -eq 0 } | Remove-Item -Force

    Import-CliXml $XmlFiles | Export-CliXml $LocationToSaveCompiledXML

    # # BUG: When the box is unchecked, the results don't compile correctly
    # if ($OptionKeepResultsByEndpointsFilesCheckBox.checked -eq $false) {
    #     if (Test-Path "$($script:CollectionSavedDirectoryTextBox.Text)\*\*.xml") {
    #         Remove-Item -Path "$($script:CollectionSavedDirectoryTextBox.Text)\*" -Recurse -Force
    #     }
    # }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUouY8YtKY5EfcSwv6oe1f7FQU
# wvGgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUIamayCtfqSo4LZf20ZU/FQ5I6TIwDQYJKoZI
# hvcNAQEBBQAEggEAYKar+tEgjO429ykReOUX1OCQ7KaM57xbmsZld6Ippnjp+yOk
# lN/xVk8V7CwJ1esxnsNq1pULLrnibya9AryPY3EXq8obYQSaT5x7Wqc5fDqKOTLw
# R4wZJ+PNBGqQEXRRZcgmCHyn+mN87ZzUHYAdacgk6D9+V6vrw4yy1O9cmfH002QP
# Rb+ZVrA5PSXGz7JjfFgcBo5EddKpjcUQN3EwGjWijQMHnfaHk/You3qMheLdNLmV
# AEWLoleROH4VSIB/v+HOCwjXQHh6ghjtga9funihfh0PPuKj1XFSUM8Ih9M0v+6U
# T/ixDJZdVttsxjDM1qEQ5QKEHaaPNVkt8CzwNQ==
# SIG # End signature block
