function FolderBrowserDialog-UserSpecifiedExecutable {
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

    if (Test-Path "$PewRoot\User Specified Executable And Script") {$ExecAndScriptDir = "$PewRoot\User Specified Executable And Script"}
    else {$ExecAndScriptDir = "$PewRoot"}

    if ($ExeScriptScriptOnlyCheckbox.checked -eq $False) {
        if ($ExeScriptSelectDirRadioButton.checked) {
            $ExeScriptSelectExecutableFolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
                #RootFolder = $PewRoot
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
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU6SXYR+XNS2LTeA9uiYea7pAy
# 9d6gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUtLDPk1HV93U/VuBxtLuThUdPjYowDQYJKoZI
# hvcNAQEBBQAEggEAaKlecYqa8u5iBFaBrhyhTaAaV0L56kWNAwlHDJoMeyYQh48Z
# qSPeZBpzshw/0/dcysnZIboN59gP7Fs+NUQybkhnjNFmvk3zAL4RG7BEHaVN3AJD
# mF6vFvT89ZJU7wYGgRnJK9LSNVI20IGmvcc9+DdY3iYOnlYfQSEfg1VfMFcGKP7+
# QOnoV3diRRihSRIUZTZavGcpw4GXEVUnoUWcKgi62ZDLl0Ofoxczw+RuZXHnbTcx
# w+zgCpN0sx8/j0vOseepuMRwFtmH8886UhxUE5cV6xfNbyAxfpi9ppjd/1ZuYf0o
# LBgmJ4MnSwMlzCdhhb45b9GJ6ARqzV8wklRMOw==
# SIG # End signature block
