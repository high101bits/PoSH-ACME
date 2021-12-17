$NetworkLiveSearchRemotePortSelectionButtonAdd_Click = {
    Import-Csv "$Dependencies\Ports, Protocols, and Services.csv" | Out-GridView -Title 'PoSh-EasyWin: Port Selection' -OutputMode Multiple | Select-Object -Property Port | Set-Variable -Name PortManualEntrySelectionContents
    $PortsColumn = $PortManualEntrySelectionContents | Select-Object -ExpandProperty Port
    $PortsToBeScan = ""
    Foreach ($Port in $PortsColumn) {
        $PortsToBeScan += "$Port`r`n"
    }
    if ($NetworkLiveSearchRemotePortRichTextbox.Lines -eq "Enter Remote Ports; One Per Line") { $NetworkLiveSearchRemotePortRichTextbox.Text = "" }
    $NetworkLiveSearchRemotePortRichTextbox.Text += $("`r`n" + $PortsToBeScan)
    $NetworkLiveSearchRemotePortRichTextbox.Text  = $NetworkLiveSearchRemotePortRichTextbox.Text.Trim("")
}



# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUEbj5FPSIZAPDvKj5VJAFRiJr
# LkOgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUIDtsOY5rrorcqod8KWekZ3DtpX0wDQYJKoZI
# hvcNAQEBBQAEggEALKqW/ByiwJgBrBRtBFsjMKeqQrkrj370cNfu6wtyF3lYqYkc
# frZ3eIuVC82ANZc+jS57LzpQtZjBqFoQSEnPmN8QWjzWR3abnJx9huL7A3zW+fim
# xa0otQOq63CXhLwGbaUd1jvN9qpWbQEyjy3e7EpXeGAuUFTbyqO37g9uJQyG3Co9
# wnMoJ4waCDNdd1W3ve+SxKMi6HlbGqVh1onyWIxY1Ow5SDGtQmujhEb+MOUfmIOl
# 6tbKfdIe9JIw/V5vV6VOtyR9sWnLkFkDlF7629U5PctFi1kkZyWxcujSOiIM+f2l
# rM+a6L3N9JIEeumshIryVGRlPBtmgC8FWw3H6g==
# SIG # End signature block