function Update-TreeViewState {
    param(
        [switch]$Accounts,
        [switch]$Endpoint,
    	[switch]$NoMessage
    )
    if ($Accounts) {
        $script:AccountsTreeView.Nodes.Add($script:TreeNodeComputerList)
        $script:AccountsTreeView.ExpandAll()

        if ($script:AccountsTreeViewSelected.count -gt 0) {
            ##if (-not $NoMessage) {
            ##    #Removed For Testing#$ResultsListBox.Items.Clear()
            ##    $ResultsListBox.Items.Add("Categories that were checked will not remained checked.")
            ##    $ResultsListBox.Items.Add("")
            ##    $ResultsListBox.Items.Add("The following hostname/IP selections are still selected in the new treeview:")
            ##}
            foreach ($root in $AllTreeViewNodes) {
                foreach ($Category in $root.Nodes) {
                    foreach ($Entry in $Category.nodes) {
                        $Entry.Collapse()
                        if ($script:AccountsTreeViewSelected -contains $Entry.text -and $root.text -notmatch 'Custom Group Commands') {
                            $Entry.Checked      = $true
                            $Entry.NodeFont     = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                            $Entry.ForeColor    = [System.Drawing.Color]::FromArgb(0,0,0,224)
                            $Category.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                            $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                           ## $ResultsListBox.Items.Add(" - $($Entry.Text)")
                        }
                        foreach ($Metadata in $Entry.Nodes){
                            $Metadata.Drawing = $False
                        }
                    }
                }
            }
        }
        else {
            foreach ($root in $AllTreeViewNodes) {
                foreach ($Category in $root.Nodes) {
                    foreach ($Entry in $Category.Nodes) {
                        $Entry.Collapse()
                        foreach ($Metadata in $Entry.Nodes){
                            $Metadata.Drawing = $false
                        }
                    }
                }
            }
        }
    }
    if ($Endpoint) {
        $script:ComputerTreeView.Nodes.Add($script:TreeNodeComputerList)
        $script:ComputerTreeView.ExpandAll()

        if ($script:ComputerTreeViewSelected.count -gt 0) {
            ##if (-not $NoMessage) {
            ##    #Removed For Testing#$ResultsListBox.Items.Clear()
            ##    $ResultsListBox.Items.Add("Categories that were checked will not remained checked.")
            ##    $ResultsListBox.Items.Add("")
            ##    $ResultsListBox.Items.Add("The following hostname/IP selections are still selected in the new treeview:")
            ##}
            foreach ($root in $AllTreeViewNodes) {
                foreach ($Category in $root.Nodes) {
                    foreach ($Entry in $Category.nodes) {
                        $Entry.Collapse()
                        if ($script:ComputerTreeViewSelected -contains $Entry.text -and $root.text -notmatch 'Custom Group Commands') {
                            $Entry.Checked      = $true
                            $Entry.NodeFont     = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                            $Entry.ForeColor    = [System.Drawing.Color]::FromArgb(0,0,0,224)
                            $Category.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                            $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                           ## $ResultsListBox.Items.Add(" - $($Entry.Text)")
                        }
                        foreach ($Metadata in $Entry.Nodes){
                            $Metadata.Drawing = $False
                        }
                    }
                }
            }
        }
        else {
            foreach ($root in $AllTreeViewNodes) {
                foreach ($Category in $root.Nodes) {
                    foreach ($Entry in $Category.Nodes) {
                        $Entry.Collapse()
                        foreach ($Metadata in $Entry.Nodes){
                            $Metadata.Drawing = $false
                        }
                    }
                }
            }
        }
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUkbFAd4lH265nYB/MHaF3esPs
# Ip2gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUzvL5t+3HTP0UodztaKcquhjbqaswDQYJKoZI
# hvcNAQEBBQAEggEAqELgHEznlYS4i9shfWovD4SfJ0jJpAz9SDe1ZFS6dRHQqvDv
# j8tJgmMIrJSbvh4jlSwKTfN3HTnmHWL4cC/HDR/DTEUYSphubDzElXdulN+9d3H5
# TAOjDXSQIz/u3zZART21aN4fRlYYQOKYY81KCLOEds63YwVEvj7pCtnaL9nPTmww
# Ewq8VfjD/qo+rajFs6JjQiSubIMalVMgih3rp6z/RMw1ZH5Xs1JRFMDM0Y/PiDd7
# D2C1ObE/YGVtYZG2MnKDzuCe7PIJ9Kd1a8Bkx0BkRB33ig88Ubhql2F64U8q9u9d
# QqJCh6BGvndcZkY8JcwrTuAn2ZN9h3PmP+jpgA==
# SIG # End signature block
