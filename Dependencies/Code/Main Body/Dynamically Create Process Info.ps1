$ResourceFiles = Get-ChildItem "$Dependencies\Process Info"

foreach ($File in $ResourceFiles) {
    #-----------------------------
    # Creates Tabs From Each File
    #-----------------------------
    $Section1ProcessesSubTab = New-Object System.Windows.Forms.TabPage -Property @{
        Text                    = "$($File.BaseName)  "
        Font                    = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
        UseVisualStyleBackColor = $True
    }
    $MainLeftProcessesTabControl.Controls.Add($Section1ProcessesSubTab)

    #-----------------------------
    # Imports Data Into Textboxes
    #-----------------------------
    $TabContents = Get-Content -Path $File.FullName -Force | ForEach-Object {$_ + "`r`n"}
    $Section1ProcessesSubTabTextBox = New-Object System.Windows.Forms.TextBox -Property @{
        Name       = "$file"
        Text       = "$TabContents"
        Location = @{ X = -2
                      Y = -2 }
        Size     = @{ Width  = $FormScale * 442
                      Height = $FormScale * 536 }
        Font       = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
        MultiLine  = $True
        ScrollBars = "Vertical"
    }
    $Section1ProcessesSubTab.Controls.Add($Section1ProcessesSubTabTextBox)
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUJxgfjEXsgd5krgmii5q6Jr0+
# Ye+gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUVlLZ+Ak4E1Pmd19GiKWmZeu8S64wDQYJKoZI
# hvcNAQEBBQAEggEAjrJJ0dNGEzgPkS3i8aOXnxGBOi83xMgjPzaeHU32hI3mADnd
# P27J649AQRdqEzIW4goQEDMrNBdv1k9+eHebtiW0gYR3sG2/Lanlvu8L7qvMBGdK
# S8OrawHWU1J7ntRHsqgmpu9Mpwn8SE8tzK2lGsdkj6CQNpBVBQxbV2FGDOtEFFh/
# vGQDWFBIxowBugwzEHnLL2y9gp5IU/IRAprqxPiA1f5eSkkG3jyAJrNnOMoX4xab
# G86HtA2qVf2scari8HEFIxCXHktr9ukapmwP7Fgq5c3iPXhIsN0F6MJtTq9OZR1Z
# +HURDQljyb5z6YNM5YwFAVjcjc+0t33Zy16gTw==
# SIG # End signature block
