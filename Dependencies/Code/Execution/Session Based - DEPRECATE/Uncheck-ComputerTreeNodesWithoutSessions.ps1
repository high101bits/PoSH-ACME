$EndpointsWithNoSessions = @()
Foreach ($Endpoint in $script:ComputerList) {
    if ($Endpoint -notin $PSSession.ComputerName) { $EndpointsWithNoSessions += $Endpoint }
}
if ($EndpointsWithNoSessions.count -gt 0) {
    [system.media.systemsounds]::Exclamation.play()
    $StatusListBox.Items.Clear()
    $StatusListBox.Items.Add("Unchecked $($EndpointsWithNoSessions.Count) Endpoints Without Sessions")
    $PoShEasyWin.Refresh()
    [System.Windows.Forms.TreeNodeCollection]$AllTreeViewNodes = $script:ComputerTreeView.Nodes
    foreach ($root in $AllTreeViewNodes) {
        foreach ($Category in $root.Nodes) {
            $Category.Checked = $False
            $EntryNodeCheckedCount = 0
            foreach ($Entry in $Category.nodes) {
                if ($EndpointsWithNoSessions -icontains $($Entry.Text)) {
                    $Entry.Checked         = $False
                    $Entry.NodeFont        = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                    $Entry.ForeColor       = [System.Drawing.Color]::FromArgb(0,0,0,0)
                }
                if ($Entry.Checked) {
                    $EntryNodeCheckedCount += 1
                }
            }
            if ($EntryNodeCheckedCount -eq 0) {
                $Category.NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,1,1)
                $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,0)
            }
        }
    }
    Start-Sleep -Seconds 3
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQULTW7io66nQsXljC7YYUkpdzo
# jWqgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUwv5PiRlMH1C3Q3uE101xV+BnnhQwDQYJKoZI
# hvcNAQEBBQAEggEAZngxwebhOETGdotcVO3vaRrmP8QnVNhoR6SuxT2IU09t/Nl3
# Rry1vtqguOZ0BxIZeelvK8AgPC+hyGA+OIHPZvQYmIMShnB8JIedaY0DZIUj21eV
# ue+q/DhA7GkF/uV/qARX8+IJpZeQl8m10X47VBPUDBmq/Nohqxvo0cGFfPURE8Xh
# 1QrWJysN/JDotmF+T95qQmigwZ5z1pIQhWIaxSUWlhKkAgxJzhEH3GiFPjSs8HGH
# E75FTRetivTRfj89a908nfUKZEED2107E4poDnjRLGzTzRjHB73W5aW9rksYmkQG
# aNHub84dbowKWhz9N5MtBapHauUHPvHTUeLNtg==
# SIG # End signature block
