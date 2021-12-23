function Execute-TextToSpeach {
    if ($OptionTextToSpeachCheckBox.Checked -eq $true) {
        Add-Type -AssemblyName System.speech
        $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
        Start-Sleep -Seconds 1

        # TTS for Query Count
        if ($QueryCount -eq 1) {$TTSQuerySingularPlural = "query"}
        else {$TTSQuerySingularPlural = "queries"}

        # TTS for TargetComputer Count
        if ($script:ComputerList.Count -eq 1) {$TTSTargetComputerSingularPlural = "host"}
        else {$TTSTargetComputerSingularPlural = "hosts"}

        # Say Message
        if (($QueryCount -eq 0) -and ($script:ComputerList.Count -eq 0)) {$speak.Speak("You need to select at least one query and target host.")}
        else {
            if ($QueryCount -eq 0) {$speak.Speak("You need to select at least one query.")}
            if ($script:ComputerList.Count -eq 0) {$speak.Speak("You need to select at least one target host.")}
            else {$speak.Speak("PoSh-EasyWin has completed $($QueryCount) $($TTSQuerySingularPlural) against $($script:ComputerList.Count) $($TTSTargetComputerSingularPlural).")}
        }
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU4/Xo9SiL5dt3O5xe5Fq8XDmi
# DmugggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQULxEqdg5Bu135H2piT70Qtam92U4wDQYJKoZI
# hvcNAQEBBQAEggEAATXWMug1WKMXUH7ujbQrA4zBLdm7KMG6aL7QjftuHnZFUzIk
# puhDqW6AQ67BTZ/M72qPEuZ+kN6G27gvOi/dV26wUTJv+9DFd66xciOqAVeiSWxS
# jOVX2joaw+/9h1v7XldZO+4VMvGj9tXdDOwTjQmiykaNiOFdNrTLtxazsPoHTGfj
# KTlwVSplepw0rrmLSS4auhNeCCzfD0AE3L8Ug5ptIuKQQ67dKJGC8+184oNU1LIc
# UI8vE7RlZUPzUo13n3CSDZx3AtJrytiVeI8c5yhUq3KkleqKvv/N2mAVqZuGBxu+
# s+on6ku90SxiLAvQ5m2UzaYGrl5jw3LW3j5ZXw==
# SIG # End signature block
