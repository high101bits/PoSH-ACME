Function Import-ActiveDirectoryScripts {
    Foreach ($script in (Get-ChildItem -Path "$CommandsAndScripts\Scripts-AD" | Where-Object {$_.Extension -eq '.ps1'})) {
        $CollectionName = $script.basename
        $script:AllActiveDirectoryCommands += [PSCustomObject]@{
            Name                 = $CollectionName
            Type                 = "script"
            Command_WinRM_Script = "Invoke-Command -FilePath '$($script.FullName)'"
            #Properties_PoSh      = 'PSComputerName, *'
            #Properties_WMI       = 'PSComputerName, *'
            Description          = "$(Get-Help $($script.FullName) | Select-Object -ExpandProperty Description)".TrimStart('@{Text=').TrimEnd('}')
            ScriptPath           = "$($script.FullName)"
        }
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQURt+0Twis2y7M6/ov1JWOSHuA
# CFugggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUgHU8te0V9ex1wI+tW8vcLQKNpaQwDQYJKoZI
# hvcNAQEBBQAEggEAAssuPMqG6lbQ0D2LUgdm36mwfsymkgp6IKrhXxf/awmn9MCJ
# uE8hJdaMsudknGHdyUgNefIkQeWPjsVntu75ohW/gzkeHpbZUnS5fsAfb7Yb9BmX
# XlhBqYPrquzDW8PwZ8qL2y04pIcoFgkvvDJkZoZ4nOPWSEtP6QamBQubY2JuQAkK
# rCx21Nf8QZCfjov1KRYap4TQMFuLI/ob+rSvayzvXovL1f86aLaXuDk+1MzXfKNH
# VhCfqUMnUO2Pkhz3UiQPAlarmf3mNeZwxh3eqtuE9BWgfTlAiBfh5sTp4+LLYFoh
# vTYjw86VtkzLcert+qS9XUelfIJCUWJOw22rtg==
# SIG # End signature block
