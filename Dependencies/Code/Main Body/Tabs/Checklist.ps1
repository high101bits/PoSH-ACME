#DEPRECATED
# $MainLeftChecklistTab = New-Object System.Windows.Forms.TabPage -Property @{
#     Text                    = "Checklist  "
#     Font                    = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
#     UseVisualStyleBackColor = $True
# }
# if (Test-Path "$Dependencies\Checklists") { $MainLeftTabControl.Controls.Add($MainLeftChecklistTab) }


# $MainLeftChecklistTabControl = New-Object System.Windows.Forms.TabControl -Property @{
#     Name          = "Checklist TabControl"
#     Location  = @{ X = $FormScale * 3
#                    Y = $FormScale * 3 }
#     Size      = @{ Width  = $FormScale * 446
#                    Height = $FormScale * 557 }
#     Appearance = [System.Windows.Forms.TabAppearance]::Buttons
#     Hottrack = $true
#     Font          = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,2,1)
#     ShowToolTips  = $True
#     SelectedIndex = 0
# }
# $MainLeftChecklistTab.Controls.Add($MainLeftChecklistTabControl)


# #-------------------------------------------------------
# # Checklists Auto Create Tabs and Checkboxes from files
# #-------------------------------------------------------
# $ResourceChecklistFiles = Get-ChildItem "$Dependencies\Checklists"

# # Iterates through the files and dynamically creates tabs and imports data
# Update-FormProgress "$Dependencies\Code\Main Body\Dynamically Create Checklists.ps1"
# . "$Dependencies\Code\Main Body\Dynamically Create Checklists.ps1"


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUz7800bPsoX0Ca0McTs9vWeQY
# uKSgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUoIUEKS5fuiPRZJNH2X+wKm+BqFEwDQYJKoZI
# hvcNAQEBBQAEggEAsBo43UaQQWHL/9uutMJ3illNlN9akuQrn6kD0+6Ld0rCZ0Yz
# qP/R66klWOxKmIEY+3hjdHtXy+HTWDgzu50aA95ATRItzQdh71ukNEH+2gX/aD9R
# l/mZrBOQR9RKouShBRqSE2+jq9tu4DWiZmj7YW7uFMriQAQ7Toidt8PAJkqiQ/kR
# 0yVYCuE1mNqxkO9P2Q362tzUnW7DHqMQ9bo7mkCxZLRu0NccDPuK9SDERVi5XSZV
# 7RJnwz49dB47kTq/lTL7TbNTo4sSOFNH3eSMMgkYNtb0WJ899CPX35rItFiUYXfO
# K2gHUMjsnwnG+P1H+JpolAHcfCbiqK2ut0kBhg==
# SIG # End signature block
