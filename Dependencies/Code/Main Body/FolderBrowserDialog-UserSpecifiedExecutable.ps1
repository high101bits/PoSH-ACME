function FolderBrowserDialog-UserSpecifiedExecutable {
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

    if (Test-Path "$PoShHome\User Specified Executable And Script") {$ExecAndScriptDir = "$PoShHome\User Specified Executable And Script"}
    else {$ExecAndScriptDir = "$PoShHome"}

    if ($ExeScriptScriptOnlyCheckbox.checked -eq $False) {
        if ($ExeScriptSelectDirRadioButton.checked) {
            $ExeScriptSelectExecutableFolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
                #RootFolder = $PoShHome
                SelectedPath = $ExecAndScriptDir
                ShowNewFolderButton = $false
            }
            $ExeScriptSelectExecutableFolderBrowserDialog.ShowDialog()

            if ($($ExeScriptSelectExecutableFolderBrowserDialog.SelectedPath)) {
                $script:ExeScriptSelectDirOrFilePath = $ExeScriptSelectExecutableFolderBrowserDialog.SelectedPath

                $ExeScriptSelectExecutableTextBox.text = "$(($ExeScriptSelectExecutableFolderBrowserDialog.SelectedPath).split('\')[-1])"
            }
        }
    }
    if ($ExeScriptSelectFileRadioButton.checked) {
        $ExeScriptSelectExecutableOpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog -Property @{
            Title = "Select Executable File"
            Filter = "Executable (*.exe)| *.exe|Windows Installer (*.msi)| *.msi|All files (*.*)|*.*"
            ShowHelp = $true
            InitialDirectory = $ExecAndScriptDir
        }
        $ExeScriptSelectExecutableOpenFileDialog.ShowDialog()

        if ($($ExeScriptSelectExecutableOpenFileDialog.filename)) {
            $script:ExeScriptSelectDirOrFilePath = $ExeScriptSelectExecutableOpenFileDialog.filename

            $ExeScriptSelectExecutableTextBox.text = "$(($ExeScriptSelectExecutableOpenFileDialog.filename).split('\')[-1])"
        }
    }
}



# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU12jfn+w56VZaSYyxHOhhOFL1
# Uy+gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUgsaxujPQzaFp4lc+i0IQFCejFJ0wDQYJKoZI
# hvcNAQEBBQAEggEAAV0QfUdlqMojPrdM8ieWrCd9FCNDQ4Ln7gIDAQihUcrTPnV1
# aJ5aaZocP02KUO9e1JkuQyuKikaPcDQYCTQarRyRhd5rLdSUCt0R2U5UzwP1kEfB
# SJ+EXCjmMI+vpfln93wmE3l7dCiA476iRKR2emiH91/YcRpxvJALcPErmEskUAol
# rn9LoDYOsl9kQkYNsLre/uEHsxcROWzRm+8szG7VF2hXkSg5mlvB2nBYb70DXl8K
# l4cUeD2isqPlsAMKo9NKpP5uXq1058EeeAxXVMK/Os5UQPpSYQGuswWiCIJrxB+t
# o7PxCTZtXJ0G/zxTovDOfxrMLEdhJucwBu/raQ==
# SIG # End signature block
