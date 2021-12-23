function Move-TreeViewData {
    param(
        [switch]$Accounts,
        [switch]$Endpoint,
        [switch]$SelectedAccounts,
        [switch]$SelectedEndpoint
    )
    if ($Accounts) {
        # Makes a copy of the checkboxed node name in the new Category
        $script:AccountsTreeNodeToMove = New-Object System.Collections.ArrayList

        if ($SelectedAccounts){
            # Adds (copies) the node to the new Category
            [System.Windows.Forms.TreeNodeCollection]$AllTreeViewNodes = $script:AccountsTreeView.Nodes
            foreach ($root in $AllTreeViewNodes) {
                if ($root.Checked) { $root.Checked = $false }
                foreach ($Category in $root.Nodes) {
                    if ($Category.Checked) { $Category.Checked = $false }
                    foreach ($Entry in $Category.nodes) {
                        if ($Entry.text -eq $script:EntrySelected.text) {
                            Add-TreeViewData -Accounts -RootNode $script:TreeNodeAccountsList -Category $AccountsTreeNodePopupMoveComboBox.SelectedItem -Entry $Entry.text #-ToolTip "No Unique Data Available"
                            $script:AccountsTreeNodeToMove.Add($Entry.text)
                            break
                        }
                    }
                }
            }

            # Removes the original Account that was copied above
            foreach ($i in $script:AccountsTreeNodeToMove) {
                foreach ($root in $AllTreeViewNodes) {
                    foreach ($Category in $root.Nodes) {
                        foreach ($Entry in $Category.nodes) {
                            if (($i -contains $Entry.text) -and ($Entry.text -eq $script:EntrySelected.text)) {
                                $($script:AccountsTreeViewData | Where-Object {$_.Name -eq $Entry.Text}).CanonicalName = $AccountsTreeNodePopupMoveComboBox.SelectedItem
                                $ResultsListBox.Items.Add($Entry.text)
                                $Entry.remove()
                            }
                        }
                    }
                }
            }
        }
        else {
            # Adds (copies) the node to the new Category
            [System.Windows.Forms.TreeNodeCollection]$AllTreeViewNodes = $script:AccountsTreeView.Nodes
            foreach ($root in $AllTreeViewNodes) {
                if ($root.Checked) { $root.Checked = $false }
                foreach ($Category in $root.Nodes) {
                    if ($Category.Checked) { $Category.Checked = $false }
                    foreach ($Entry in $Category.nodes) {
                        if ($Entry.Checked) {
                            Add-TreeViewData -Accounts -RootNode $script:TreeNodeAccountsList -Category $AccountsTreeNodePopupMoveComboBox.SelectedItem -Entry $Entry.text #-ToolTip "No Unique Data Available"
                            $script:AccountsTreeNodeToMove.Add($Entry.text)
                        }
                    }
                }
            }

            $AccountsAndAccountTreeViewTabControl.SelectedTab = $AccountsTreeviewTab
            $script:AccountsTreeNodeComboBox.SelectedItem = 'CanonicalName'

            # Removes the original Account that was copied above
            foreach ($i in $script:AccountsTreeNodeToMove) {
                foreach ($root in $AllTreeViewNodes) {
                    foreach ($Category in $root.Nodes) {
                        foreach ($Entry in $Category.nodes) {
                            if (($i -contains $Entry.text) -and ($Entry.Checked)) {
                                $($script:AccountsTreeViewData | Where-Object {$_.Name -eq $Entry.Text}).CanonicalName = $AccountsTreeNodePopupMoveComboBox.SelectedItem
                                $ResultsListBox.Items.Add($Entry.text)
                                $Entry.remove()
                            }
                        }
                    }
                }
            }
        }

        Remove-TreeViewEmptyCategory -Accounts
        Save-TreeViewData -Accounts
    }
    if ($Endopint) {
        # Makes a copy of the checkboxed node name in the new Category
        $script:ComputerTreeNodeToMove = New-Object System.Collections.ArrayList

        if ($SelectedEndpoint){
            # Adds (copies) the node to the new Category
            [System.Windows.Forms.TreeNodeCollection]$AllTreeViewNodes = $script:ComputerTreeView.Nodes
            foreach ($root in $AllTreeViewNodes) {
                if ($root.Checked) { $root.Checked = $false }
                foreach ($Category in $root.Nodes) {
                    if ($Category.Checked) { $Category.Checked = $false }
                    foreach ($Entry in $Category.nodes) {
                        if ($Entry.text -eq $script:EntrySelected.text) {
                            Add-TreeViewData -Endpoint -RootNode $script:TreeNodeComputerList -Category $ComputerTreeNodePopupMoveComboBox.SelectedItem -Entry $Entry.text #-ToolTip "No Unique Data Available"
                            $script:ComputerTreeNodeToMove.Add($Entry.text)
                            break
                        }
                    }
                }
            }

            # Removes the original hostname/IP that was copied above
            foreach ($i in $script:ComputerTreeNodeToMove) {
                foreach ($root in $AllTreeViewNodes) {
                    foreach ($Category in $root.Nodes) {
                        foreach ($Entry in $Category.nodes) {
                            if (($i -contains $Entry.text) -and ($Entry.text -eq $script:EntrySelected.text)) {
                                $($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Entry.Text}).CanonicalName = $ComputerTreeNodePopupMoveComboBox.SelectedItem
                                $ResultsListBox.Items.Add($Entry.text)
                                $Entry.remove()
                            }
                        }
                    }
                }
            }
        }
        else {
            # Adds (copies) the node to the new Category
            [System.Windows.Forms.TreeNodeCollection]$AllTreeViewNodes = $script:ComputerTreeView.Nodes
            foreach ($root in $AllTreeViewNodes) {
                if ($root.Checked) { $root.Checked = $false }
                foreach ($Category in $root.Nodes) {
                    if ($Category.Checked) { $Category.Checked = $false }
                    foreach ($Entry in $Category.nodes) {
                        if ($Entry.Checked) {
                            Add-TreeViewData -Endpoint -RootNode $script:TreeNodeComputerList -Category $ComputerTreeNodePopupMoveComboBox.SelectedItem -Entry $Entry.text #-ToolTip "No Unique Data Available"
                            $script:ComputerTreeNodeToMove.Add($Entry.text)
                        }
                    }
                }
            }

            $ComputerAndAccountTreeViewTabControl.SelectedTab = $ComputerTreeviewTab
            $script:ComputerTreeNodeComboBox.SelectedItem = 'CanonicalName'

            # Removes the original hostname/IP that was copied above
            foreach ($i in $script:ComputerTreeNodeToMove) {
                foreach ($root in $AllTreeViewNodes) {
                    foreach ($Category in $root.Nodes) {
                        foreach ($Entry in $Category.nodes) {
                            if (($i -contains $Entry.text) -and ($Entry.Checked)) {
                                $($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Entry.Text}).CanonicalName = $ComputerTreeNodePopupMoveComboBox.SelectedItem
                                $ResultsListBox.Items.Add($Entry.text)
                                $Entry.remove()
                            }
                        }
                    }
                }
            }
        }

        Remove-TreeViewEmptyCategory -Endpoint
        Save-TreeViewData -Endpoint
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU94J2Sg1yo/1SheZtw+L15HGV
# F7mgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQU/ktzRMnPCmLvnENbRPJNgD8OfrMwDQYJKoZI
# hvcNAQEBBQAEggEAVj7SnA8sO+D85o46rJDNDShYWfcvuPOV1dU5LaL3XJQz4b5y
# nGRuCFaLv553kXVRqv0IthKTWGxRv2IiviXSqbO6RnTrcpY+j+IQSDB/8pmShIMN
# +qaI1M23vhaDb4iYEjKMWKzzv+Ozlxkc0Okgn508339JczQmlfKCx35AfHJ3Cu/C
# RSBBTJxnc+N0qfVUS2Cz7n/rEzR/KYUKJq5g+VV2BpDHnXFGAXij9F+dogx294Ze
# aqywCVy6vUxu0TQyTXL16WU8tUKAPNCmP+uE/q0oPhY3f04zBgA35SY8751/kFd6
# n8J4lYLGyCGFm8+dHUeknJgUGVz5NuWoqGZ3DQ==
# SIG # End signature block
