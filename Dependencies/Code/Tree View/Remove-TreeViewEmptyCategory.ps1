function Remove-TreeViewEmptyCategory {
    param(
        [switch]$Accounts,
        [switch]$Endpoint
    )
    if ($Accounts) {
        # Checks if the category node is empty, if so the node is removed
        [System.Windows.Forms.TreeNodeCollection]$AllTreeViewNodes = $script:AccountsTreeView.Nodes
        foreach ($root in $AllTreeViewNodes) {
            foreach ($Category in $root.Nodes) {
                [int]$CategoryNodeContentCount = 0
                # Counts the number of computer nodes in each category
                foreach ($Entry in $Category.nodes) {
                    if ($Entry.Test -ne '' -and $Entry.Text -ne $null){
                        $CategoryNodeContentCount += 1
                    }
                }
                # Removes a category node if it is empty
                if ($CategoryNodeContentCount -eq 0 ) {
                    $Category.remove()
                }
            }
        }
    }
    if ($Endpoint) {
        # Checks if the category node is empty, if so the node is removed
        [System.Windows.Forms.TreeNodeCollection]$AllTreeViewNodes = $script:ComputerTreeView.Nodes
        foreach ($root in $AllTreeViewNodes) {
            foreach ($Category in $root.Nodes) {
                [int]$CategoryNodeContentCount = 0
                # Counts the number of computer nodes in each category
                foreach ($Entry in $Category.nodes) {
                    if ($Entry.Test -ne '' -and $Entry.Text -ne $null){
                        $CategoryNodeContentCount += 1
                    }
                }
                # Removes a category node if it is empty
                if ($CategoryNodeContentCount -eq 0 ) {
                    $Category.remove()
                }
            }
        }
    }

    #   $ComputerTreeNodePopup.close()
}

# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUIAPmw7ywmEsUipFtdi0+heAK
# inCgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUlhgs2nSjHDKDhzctKuI8HOs82ggwDQYJKoZI
# hvcNAQEBBQAEggEAE+rExyYRj84fFAau49D2VHMbfOPyzJOfayCHhd+dkH5NhTNV
# 8//Jzf5XSfMW0Y7JbaaBfWom3oRZ8f7HKstuNT4pAjn19MsDpV8yQygVOMnQhnUU
# lJwQ+6zdXwuOOgy+KyHnsd80oJCMojB43fAZjnsZAxITwldmGBEBwdbkY9NS2trx
# 8vWGGe9SRLnO7nWlannP4h4WF2t52x/whS9l7mtc5iL4qMFisSwgMvFtFeDRBExD
# QsmX1sxecyzjiZsRNf8vLh0Ak8aZ0f6USQUKORu9l48Uk6ky5OLFQad0nlzExoWa
# Iqespaj0m7aQG1MWFm5EWRM5cTC0ccwBklzTSQ==
# SIG # End signature block
