$EnumerationResolveDNSNameButtonAdd_Click = {
    if ($($EnumerationComputerListBox.SelectedItems).count -eq 0){
        [system.media.systemsounds]::Exclamation.play()
        $StatusListBox.Items.Clear()
        $StatusListBox.Items.Add("DNS Resolution:  Make at least one selection")
    }
    else {
        if (Verify-Action -Title "Verification: Resolve DNS" -Question "Conduct a DNS Resolution of the following?" -Computer $($EnumerationComputerListBox.SelectedItems -join ', ')) {
            #for($i = 0; $i -lt $EnumerationComputerListBox.Items.Count; $i++) { $EnumerationComputerListBox.SetSelected($i, $true) }

            #$EnumerationComputerListBoxSelected = $EnumerationComputerListBox.SelectedItems
            #$EnumerationComputerListBox.Items.Clear()

            # Resolve DNS Names
            $DNSResolutionList = @()
            foreach ($Selected in $($EnumerationComputerListBox.SelectedItems)) {
                $DNSResolution      = (((Resolve-DnsName $Selected).NameHost).split('.'))[0]
                $DNSResolutionList += $DNSResolution
                $EnumerationComputerListBox.Items.Remove($Selected)
            }
            foreach ($Item in $DNSResolutionList) { $EnumerationComputerListBox.Items.Add($Item) }
        }
        else {
            [system.media.systemsounds]::Exclamation.play()
            $StatusListBox.Items.Clear()
            $StatusListBox.Items.Add("DNS Resolution:  Cancelled")
        }
    }
}



# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUpBy98g4cGSYZaYebv9L/Ybhd
# EkWgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUPBwzq482Xn8a0TPDREyh/x2M/p4wDQYJKoZI
# hvcNAQEBBQAEggEAWqj2X4M4tYvlDVgtBTaXXFWsbyz8OBbQjdaWqxF+6X/ATfNy
# YKdSvcoVjSYWh6Zh7LNdoPxgRSHV3BhxQhUY05bSF0VpVqYcCWRMYk2aOTckz0sT
# +dRNmGy6vt7TbaFDa304mz99ZPlR9d0UrDriRiNbOldJxYBjFG2vIM6q8GH0/xhJ
# 0b27SZaCe/r49fdnCRs245EDQaSIP7wKmjNSCXqpg5xJ39ka54UFFB2Jwi0qTrKG
# 7C86QMzNrbVqLvhx8XQLcEMo2maBAVovH3n4CMHQkoeW/1nXT3+LZ6V5+93rg/8y
# t6Ytc3U6MTWCxuq6TelqTd7ffa6uHuEdINAgbg==
# SIG # End signature block
