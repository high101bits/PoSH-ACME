Function Message-TreeViewNodeAlreadyExists {
    param(
        [switch]$Accounts,
        [switch]$Endpoint,
        $Message,
        $Account,
        $Computer,
        [Switch]$ResultsListBoxMessage
    )
    if ($Accounts) {
        $InformationTabControl.SelectedTab = $Section3ResultsTab
        [system.media.systemsounds]::Exclamation.play()
        if ($Account){
            $AccountsNameExist = $Account
        }
        elseif ($Account.Name) {
            $AccountsNameExist = $Account.Name
        }

        $StatusListBox.Items.Clear()
        $StatusListBox.Items.Add("$Message")

        if ($ResultsListBoxMessage) {
            $ResultsListBox.Items.Add("The following Account already exists: $AccountsNameExist")
            $ResultsListBox.Items.Add("- OS:    $($($script:AccountsTreeViewData | Where-Object {$_.Name -eq $Account}).OperatingSystem)")
            $ResultsListBox.Items.Add("- OU/CN: $($($script:AccountsTreeViewData | Where-Object {$_.Name -eq $Account}).CanonicalName)")
            $ResultsListBox.Items.Add("")
            $PoShEasyWin.Refresh()
        }
        else {
            Show-MessageBox -Message "The following Account already exists: $AccountsNameExist
- OU/CN:      $($($script:AccountsTreeViewData | Where-Object {$_.Name -eq $Account}).CanonicalName)
- Created:    $($($script:AccountsTreeViewData | Where-Object {$_.Name -eq $Account}).Created)
- LockedOut:  $($($script:AccountsTreeViewData | Where-Object {$_.Name -eq $Account}).LockedOut)" -Title "PoSh-EasyWin" -Options "Ok" -Type "Error" -Sound
        }
        #$ResultsListBox.Items.Add("- IP:    $($($script:AccountsTreeViewData | Where-Object {$_.Name -eq $Account}).IPv4Address)")
        #$ResultsListBox.Items.Add("- MAC:   $($($script:AccountsTreeViewData | Where-Object {$_.Name -eq $Account}).MACAddress)")
    }
    if ($Endpoint) {
        $InformationTabControl.SelectedTab = $Section3ResultsTab
        [system.media.systemsounds]::Exclamation.play()
        if ($Computer){
            $ComputerNameExist = $Computer
        }
        elseif ($Computer.Name) {
            $ComputerNameExist = $Computer.Name
        }

        $StatusListBox.Items.Clear()
        $StatusListBox.Items.Add("$Message")

        if ($ResultsListBoxMessage) {
            $ResultsListBox.Items.Add("The following Endpoint already exists: $ComputerNameExist")
            $ResultsListBox.Items.Add("- OS:    $($($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Computer}).OperatingSystem)")
            $ResultsListBox.Items.Add("- OU/CN: $($($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Computer}).CanonicalName)")
            $ResultsListBox.Items.Add("")
            $PoShEasyWin.Refresh()
        }
        else {
            Show-MessageBox -Message "Info: The following Endpoint already exists: $ComputerNameExist
- OU/CN: $($($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Computer}).CanonicalName)
- OS:    $($($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Computer}).OperatingSystem)" -Title "PoSh-EasyWin" -Options "Ok" -Type "Information" -Sound
        }
        #$ResultsListBox.Items.Add("- IP:    $($($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Computer}).IPv4Address)")
        #$ResultsListBox.Items.Add("- MAC:   $($($script:ComputerTreeViewData | Where-Object {$_.Name -eq $Computer}).MACAddress)")
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU7f9xzIvzrefxBywNBr0LPUb9
# +8KgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUjRwyckIuvCssrdP0c5mQb2vEy0YwDQYJKoZI
# hvcNAQEBBQAEggEAHfamMeMdsicLPNjR0KNAHjH66RGmR8KxRxoaIWyde6+Eyf26
# cggEfrlqsTRziV5gK3RGaq/iQHLCzZKFLoy5OIX9KtiEYx8sKbnvFYgD66WDkLTw
# uin2RGUQlOsyv+946W9YK+BYPuFkSg5s1RHiyrpoBklTBTZTZqP4z+306ghWNTbX
# rQ3git8VPBCKKCYjYKNqt7u/WU14w79SJX8mWvzCiG3b1/oXK5OiiX7SzbP6mAKa
# OvNAqmU4ykzfQAYY5lz1Xuzm0HXRCUjBYs9I6qMD5lhB8RBz+Hmj/f4BCD2l7I8B
# /EmofVwYtK50M2QHOrkAAmZveHE2kEMlLoaU4A==
# SIG # End signature block
