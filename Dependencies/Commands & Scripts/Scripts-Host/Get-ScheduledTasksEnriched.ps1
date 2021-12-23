$ScheduledTasks = Get-ScheduledTask `
| Select-Object -Property State, Actions, Author, Date, Description, Documentation, Principal, SecurityDescriptor, Settings, Source, TaskName, TaskPath, Triggers, URI, Version, PSComputerName

foreach ($Task in $ScheduledTasks) {
    $Task | Add-Member -MemberType NoteProperty -Name Settings -Value $($Task.Settings | Out-String).trim(' ').trim("`r`n") -Force -PassThru `
          | Add-Member -MemberType NoteProperty -Name SettingsIdleSettings -Value $($Task.Settings.IdleSettings | Out-String).trim(' ').trim("`r`n") -Force -PassThru `
          | Add-Member -MemberType NoteProperty -Name SettingsNetworkSettings -Value $($Task.Settings.NetworkSettings | Out-String).trim(' ').trim("`r`n") -Force -PassThru `
          | Add-Member -MemberType NoteProperty -Name Principal -Value $($Task.Principal | Out-String).trim(' ').trim("`r`n") -Force -PassThru `
          | Add-Member -MemberType NoteProperty -Name Actions -Value $($Task.Actions | Out-String).trim(' ').trim("`r`n") -Force -PassThru `
          | Add-Member -MemberType NoteProperty -Name TriggersCount -Value $Task.Triggers.Count -Force -PassThru `
          | Add-Member -MemberType NoteProperty -Name Triggers -Value $($Task.Triggers | Out-String).trim(' ').trim("`r`n") -Force -PassThru `
          | Add-Member -MemberType NoteProperty -Name TriggersRepetition -Value $($Task.Triggers.Repetition | Out-String).trim(' ').trim("`r`n") -Force
}

$ScheduledTasks


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUAyz+3WRY6AUM5N3zWy/BF5Tf
# tjegggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUWWBFHphGnWi9cqXrhYr3dyb+OEowDQYJKoZI
# hvcNAQEBBQAEggEAJWA+frTpo5Gt9VHAdROThanYXeZuKNQi/U1kbfaFQ0Oeb/2q
# X14p1lZvlFrsezX0ZeCtq7bbT+fCRRNEWycoDZaM5/lVfrsrW3Sx9JA7C6ibOjFT
# wvdNd/HcSGoekxTsETIvD27cYxVwFG10jmAp13ZOjvy3L1cvjXW8iTQHbb7+ZFFr
# 3DNXJuUDaU8kEe1CMfI8QM+tgVBVyWdRoDJbV9xWhqL11eeVshu0G6u/fn3nR1aE
# f+WnR7IfA4XIc7tzSfYelJdrnKRrFJjYYwM89eAz2O6IHqu/TEu56PFyzu60caSd
# kn5G148RmZkgiZo93PmGldP5/sL7OsJJR/3fQA==
# SIG # End signature block
