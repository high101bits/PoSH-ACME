function OpenFileDialog-UserSpecifiedScript {
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

    if (Test-Path "$PewRoot\User Specified Executable And Script") {$ExecAndScriptDir = "$PewRoot\User Specified Executable And Script"}
    else {$ExecAndScriptDir = "$PewRoot"}

    $ExeScriptSelectScriptOpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        Title = "Select Script File"
        Filter = "PowerShell Script (*.ps1)| *.ps1|Batch File (*.bat)| *.bat|Text File (*.txt)| *.txt|All files (*.*)|*.*"
        ShowHelp = $true
        InitialDirectory = $ExecAndScriptDir
    }
    $ExeScriptSelectScriptOpenFileDialog.ShowDialog() | Out-Null
    if ($($ExeScriptSelectScriptOpenFileDialog.filename)) {
        $script:ExeScriptSelectScriptPath = $ExeScriptSelectScriptOpenFileDialog.filename

        $ExeScriptSelectScriptTextBox.text = "$(($ExeScriptSelectScriptOpenFileDialog.filename).split('\')[-1])"
        #$Script:ExeScriptSelectScriptName  = $(($ExeScriptSelectScriptOpenFileDialog.filename).split('\')[-1])
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUaz1hCoqQreVRMxz2D6XuPzyG
# VfKgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUfKwMLWNMM71S7MzIrCtrLkAGvCkwDQYJKoZI
# hvcNAQEBBQAEggEACNWjfWZsOkYWe/dZtQp9dKm6QKG9n6g8jRcjbZhbMIDi4NI+
# K6Qzver9AYUOPXzluofD8vgXNVgHls3wckW8nuk/nYXc53huQ+ovU0e5Jl/Wt/yS
# LPehXuIvMVdYHT7VPOIvXfFhWs9GgoIDAQI0v3bI7fv1gkLlZNdBMWCqPt5hBT29
# 0b6VvSJL7+f1Fo53CtxgxUdEFvdJdb21Gnjq1Rnt465N+8YGJAj+MxQZQRphKX58
# LwjaLdrO5jn0BfWs/cng9qdf2qJB4nQJFqIhz5lVug94a6FMOqwjfgyTOokKPOeV
# AvrERLG07c27ZhefmAWOVshNF8QA8xlmK2oaBQ==
# SIG # End signature block
