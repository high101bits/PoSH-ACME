function Compile-CsvFiles {
    param (
        [string]$LocationOfCSVsToCompile,
        [string]$LocationToSaveCompiledCSV
    )
    Remove-Item -Path "$LocationToSaveCompiledCSV" -Force
    Start-Sleep -Milliseconds 250

    $CompiledCSVs = @()
    Get-ChildItem "$LocationOfCSVsToCompile" | ForEach-Object {
        if ((Get-Content $_).Length -eq 0) {
            # Removes any files that don't contain data
            Remove-Item $_
        }
        else {
            $CompiledCSVs += Import-Csv -Path $_
        }
    }
    $CompiledCSVs | Select-Object -Property * -Unique | Export-Csv $LocationToSaveCompiledCSV -NoTypeInformation -Force

    # # BUG: When the box is unchecked, the results don't compile correctly
    # if ($OptionKeepResultsByEndpointsFilesCheckBox.checked -eq $false) {
    #     if (Test-Path "$($script:CollectionSavedDirectoryTextBox.Text)\*\*.csv") {
    #         Remove-Item -Path "$($script:CollectionSavedDirectoryTextBox.Text)\*\*.csv" -Recurse -Force
    #     }
    # }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUVBRA13jaqHdl4p2aTlTeQJzR
# aJugggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUDF+80IJ33hIMQWlj+BJP8CWnLoMwDQYJKoZI
# hvcNAQEBBQAEggEAG2Wq5QxLDVVVOFXEZbCOqRUthFJkwwhaMa4iYLJPwZySNTZd
# s+wWeVEFPbeI8AG1GbaP+buATGBwG3UrI1xq9ZpUs3UupNpYD4H6M+mcvmwu40Wz
# MfkXlVxA/Iv9S8uubQvn4Ph/+hsnmAJJ7GuB9cUdrNLr4SQLsctQ2P3G69z+Ve22
# FJt+UjKBzKn7585jK6n0Nqk2AQaXJ2KTAxKo4KheKxlr67OPZV/Xx3lntL18U3gt
# /5Tv6ESH2eo1Z9N2LOiVQtNqwAyxVlWS4Xt9FWd+klXOqHAq5SZ2cFPi7Xs4eJox
# m+HzaWi4CpeegMlKDAg66Iw2Jm0d254kGl2faA==
# SIG # End signature block
