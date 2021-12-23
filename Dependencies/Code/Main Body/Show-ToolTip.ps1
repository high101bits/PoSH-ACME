function Show-ToolTip {
    param (
        $Title   = 'No Title Specified',
        $Message = 'No Message Specified',
        $Icon    = 'Warning'
    )
    $ToolTip = New-Object System.Windows.Forms.ToolTip
    if ($OptionShowToolTipCheckBox.Checked){
        $ToolTipMessage1   = "`n`n+  ToolTips can be disabled in the Options Tab."
        $ToolTip.SetToolTip($this,$($Message + $ToolTipMessage1))
        $ToolTip.Active         = $true
        $ToolTip.UseAnimation   = $true
        $ToolTip.UseFading      = $true
        $ToolTip.IsBalloon      = $true
        $ToolTip.ToolTipIcon    = $Icon  #Error, Info, Warning, None
        $ToolTip.ToolTipTitle   = $Title
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUwjmiCtzjG7dxRjCsX5AjK0SS
# 5OOgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUO47Z/6b/kiOmBT2QqJPxZMkoqpUwDQYJKoZI
# hvcNAQEBBQAEggEAjy5l/gpJjbeJE/TtpL2KinnxhPuV3jwPBtldNo25BfFL313c
# 3K6rZx0JAQDHAflcmHuAC1dmjwNODPIgaNkh3j0rexmR6L0/Cnknhrh7ILoipKGE
# Irvh3Fv7TB01eNfa55WQOBbkvR/Ake1WCj3+IaT0WbnlYUHdvLk1pFICo1N4ZEbu
# weHvHf0/c17/xEVEzqWFbax5A2JWcS2YRsDQVYArHmuo38Mp7pu6hzxOlHWyXto/
# CS8FE4oQQgdhX4jBEmInNO3Hafyov80wTmjbJADMxIAC9gu2zsHiT9HYt4bWtvjA
# aGZjF8PIliol9jcujdvd7wLXAbvtJE1zXMwdpA==
# SIG # End signature block
