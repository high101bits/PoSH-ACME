function Generate-ComputerList {
    # Generate list of endpoints to query

    #$StatusListBox.Items.Clear()
    #$StatusListBox.Items.Add("Multiple Host Collection")
    $script:ComputerList = @()
    $script:ComputerListAll = @()

    # If the root computerlist checkbox is checked, All Endpoints will be queried
    [System.Windows.Forms.TreeNodeCollection]$AllTreeViewNodes = $script:ComputerTreeView.Nodes
    if ($script:ComputerListUseDNSCheckbox.checked) {
        if ($script:ComputerListSearch.Checked) {
            foreach ($root in $AllTreeViewNodes) {
                if ($root.text -imatch "Search Results") {
                    foreach ($Category in $root.Nodes) {
                        foreach ($Entry in $Category.nodes) {
                            $script:ComputerList += $Entry.text
                        }
                    }
                }
            }
        }
        if ($script:TreeNodeComputerList.Checked) {
            foreach ($root in $AllTreeViewNodes) {
                if ($root.text -imatch "All Endpoints") {
                    foreach ($Category in $root.Nodes) {
                        foreach ($Entry in $Category.nodes) {
                            $script:ComputerList += $Entry.text
                        }
                    }
                }
            }
        }
        foreach ($root in $AllTreeViewNodes) {
            # This loop will select All Endpoints in a Category
            foreach ($Category in $root.Nodes) {
                if ($Category.Checked) {
                    foreach ($Entry in $Category.Nodes) {
                        $script:ComputerList += $Entry.text
                    }
                }
            }
            # This loop will check for entries that are checked
            foreach ($Category in $root.Nodes) {
                foreach ($Entry in $Category.nodes) {
                    $script:ComputerListAll += $Entry.Text
                    if ($Entry.Checked) { $script:ComputerList += $Entry.text }
                }
            }
        }
        # This will dedup the ComputerList, though there is unlikely multiple computers of the same name
        $script:ComputerList = $script:ComputerList | Sort-Object -Unique
        $script:ComputerListAll = $script:ComputerListAll | Sort-Object -Unique
    }
    else {
        if ($script:ComputerListSearch.Checked) {
            foreach ($root in $AllTreeViewNodes) {
                if ($root.text -imatch "Search Results") {
                    foreach ($Category in $root.Nodes) {
                        foreach ($Entry in $Category.nodes) {
                            foreach ($Metadata in $Entry.nodes) {
                                if ($Metadata.Name -eq 'IPv4Address') {
                                    $script:ComputerList += $Metadata.text
                                }
                            }
                        }
                    }
                }
            }
        }
        if ($script:TreeNodeComputerList.Checked) {
            foreach ($root in $AllTreeViewNodes) {
                if ($root.text -imatch "All Endpoints") {
                    foreach ($Category in $root.Nodes) {
                        foreach ($Entry in $Category.nodes) {
                            foreach ($Metadata in $Entry.nodes) {
                                if ($Metadata.Name -eq 'IPv4Address') {
                                    $script:ComputerList += $Metadata.text
                                }
                            }
                        }
                    }
                }
            }
        }
        foreach ($root in $AllTreeViewNodes) {
            # This loop will select All Endpoints in a Category
            foreach ($Category in $root.Nodes) {
                if ($Category.Checked) {
                    foreach ($Entry in $Category.Nodes) {
                        foreach ($Metadata in $Entry.nodes) {
                            if ($Metadata.Name -eq 'IPv4Address') {
                                $script:ComputerList += $Metadata.text
                            }
                        }
                    }
                }
            }
            # This loop will check for entries that are checked
            foreach ($Category in $root.Nodes) {
                foreach ($Entry in $Category.nodes) {
                    if ($Entry.Checked) {
                        foreach ($Metadata in $Entry.nodes) {
                            if ($Metadata.Name -eq 'IPv4Address') {
                                $script:ComputerList += $Metadata.text
                            }
                        }
                    }
                }
            }
        }
        # This will dedup the ComputerList, though there is unlikely multiple computers of the same name
        $script:ComputerList = $script:ComputerList | Sort-Object -Unique
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU7qQHTz2L2G3/LkU16//NamLy
# 6g6gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUFyAZ5VHj/+HgfxsBBHWXg8R3tiIwDQYJKoZI
# hvcNAQEBBQAEggEAii9EfadchrxHrHgZ77gtjlITTzGQZiaowYnYYAwAy6aLYLdA
# UkAoC1u9G1v8iDJq5ty2OSakrbvFH3FvlJFRiORfptAykjX2Nu4UNnEUIavNvUXp
# q6etxV18HNIHdGng8vlc/rCtjJIR0zi+kCMPcgYQxq6j+2v6V1+k+SjIUZg6yTZX
# 273r/JlRtlyi+HFgGt4hIwhM9I5DJQ/OkVVG/uXcoicwzHeWkdse0s47AjmkOVuX
# BBILWeeKapVBOT4HyFsHa/NyGqv4qbxfn97h1chT6wisJF9+FTe2uw2VtYStutkc
# U5uhjCaWGQa0E/Bz13jdEgEQ5W6pklEP5lsTLw==
# SIG # End signature block
