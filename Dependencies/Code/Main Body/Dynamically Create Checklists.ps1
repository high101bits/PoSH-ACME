$ChecklistDownPosition      = 10
$ChecklistDownPositionShift = 30

foreach ($File in $ResourceChecklistFiles) {
    #-------------------------
    # Creates Tabs From Files
    #-------------------------
    $Section1ChecklistSubTab = New-Object System.Windows.Forms.TabPage -Property @{
        Text                    = "$($File.BaseName)  "
        AutoScroll              = $True
        UseVisualStyleBackColor = $True
        Font                    = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
    }
    $MainLeftChecklistTabControl.Controls.Add($Section1ChecklistSubTab)

    #-------------------------------------
    # Imports Data and Creates Checkboxes
    #-------------------------------------
    $TabContents = Get-Content -Path $File.FullName -Force | foreach {$_ + "`r`n"}
    foreach ($line in $TabContents) {
        $Checklist = New-Object System.Windows.Forms.CheckBox -Property @{
            Text     = "$line"
            Location = @{ X = $FormScale * 5
                          Y = $FormScale * $ChecklistDownPosition }
            Size     = @{ Width  = $FormScale * 410
                          Height = $FormScale * 30 }
            Font     = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
        }
        if ($Checklist.Check -eq $True) { $Checklist.ForeColor = "Blue" }
        $Section1ChecklistSubTab.Controls.Add($Checklist)

        $ChecklistDownPosition += $ChecklistDownPositionShift
    }
    $ChecklistDownPosition = $FormScale * 10
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUXNC0NQNg0AjLCZq53tWb0c/g
# S++gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUyovsiBwi0UFoc9A5XLywA20ZajEwDQYJKoZI
# hvcNAQEBBQAEggEAHp6ECHsEe9pz01rxP+Hh60e/qL0K/naQuqIggevh9jL7QHn8
# WLeQyGMpJ0SX1OgniguiEBvxUuCJKlwLWw0tmUhJC9N8A0xpCCH9aS5Rzrh42oFj
# XTO5U5sual4cTM9WqlA/F52q92HTEsyO9AvSfr2v7jlK6ak2i3CWNpkZ2UVQjgk2
# 79rlH05XgSgZf0KDd7PYMxaUWTioF8xxmqLvIi0iiPRYtu+uB0yXFOpqI/+wlYjG
# LvQ0bEPVab4/b0kzUUzTPcwI7SUFamoznXFoR2LVthvVXwyHuqoCKg01hYJfWeCA
# Y7dC1nkHOcjDb2S59RQhKrKKrcj0Mnmf0vZnug==
# SIG # End signature block
