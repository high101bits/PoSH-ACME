function OpenFileDialog-SysinternalsSysmonXmlConfig {
    Add-Type -AssemblyName System.Windows.Forms
        #[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

    $SysinternalsSysmonOpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        Title = "Select Sysmon Configuration XML File"
        Filter = "XML Files (*.xml)| *.xml|All files (*.*)|*.*"
        ShowHelp = $true
        InitialDirectory = "$Dependencies\Executables\Sysmon Config Files"
    }
    $SysinternalsSysmonOpenFileDialog.ShowDialog() | Out-Null
    if ($($SysinternalsSysmonOpenFileDialog.filename)) {
        $script:SysmonXMLPath = $SysinternalsSysmonOpenFileDialog.filename

        $SysinternalsSysmonConfigTextBox.text = "Config: $(($SysinternalsSysmonOpenFileDialog.filename).split('\')[-1])"
        $Script:SysmonXMLName = $(($SysinternalsSysmonOpenFileDialog.filename).split('\')[-1])
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU+XBH08eMo3Bf7SQLwm4T8mZ7
# Nu6gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUEjr+Fh53VzdgKPidLcdXRyII92AwDQYJKoZI
# hvcNAQEBBQAEggEAmrTY1ktufHnbc3lKm3h33OPEMBjarpivakH1LgKYjd9yXxyo
# 0yzhawHhA34WIpKLEKBSCV9fdS5+8xzoEwzCFR5Z28tpmc5sU5Y/2io4ZGY9so+M
# 7muP5nPJnkox8j+OlhRVl/nCVDoIp4Ra6kZHvy6SCr+W9YYH1cYj284GmkpGuCWA
# Hl0VVBUKpiSUKqGBLhuJ4pW4ppNXW3zmPtz/Dcj8nvZjKAT9dxuuQGy+khJTa8pN
# vTxEw5/JrIKn3+ewEkBbVJuo+LJ98sMhSxl9A33PTK02KRalnaJEx1iTF2WMC37N
# Ae5sngL6w6DW83Cbn6OnSZANtEk6nbdMc4TTaw==
# SIG # End signature block
