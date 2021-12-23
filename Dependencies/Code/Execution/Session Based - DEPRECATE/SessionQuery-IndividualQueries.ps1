<#
    .Description
    This iterates though the commands selected and determines how to exactly execute them
    based off their labeled protocol and command type.
#>
Foreach ($Command in $script:CommandsCheckedBoxesSelected) {
    $script:ProgressBarEndpointsProgressBar.Value = 0
    $ProgressBarEndpointsCommandLine = 0

    $ExecutionStartTime = Get-Date
    $CollectionName = $Command.Name
    $StatusListBox.Items.Clear()
    $StatusListBox.Items.Add("Executing: $CollectionName")
    $ResultsListBox.Items.Insert(0,"$(($ExecutionStartTime).ToString('yyyy/MM/dd HH:mm:ss'))  $CollectionName")
    $PoShEasyWin.Refresh()

    if ($Command.Type -eq "(WinRM) Script") {
        $CommandString = "$($Command.Command)"
        $script:OutputFileFileType = "csv"
    }
    elseif ($Command.Type -eq "(WinRM) PoSh") {
        $CommandString = "$($Command.Command) | Select-Object -Property $($Command.Properties)"
        $script:OutputFileFileType = "csv"
    }
    elseif ($Command.Type -eq "(WinRM) WMI") {
        $CommandString = "$($Command.Command) | Select-Object -Property $($Command.Properties)"
        $script:OutputFileFileType = "csv"
    }
    #elseif ($Command.Type -eq "(WinRM) CMD") {
    #    $CommandString = "$($Command.Command)"
    #    $script:OutputFileFileType = "txt"
    #}


    #elseif ($Command.Type -eq "(RPC) PoSh") {
    #    $CommandString = "$($Command.Command) | Select-Object -Property @{n='PSComputerName';e={`$TargetComputer}}, $($Command.Properties)"
    #    $script:OutputFileFileType = "csv"
    #}
    elseif (($Command.Type -eq "(RPC) WMI") -and ($Command.Command -match "Get-WmiObject")) {
        $CommandString = "$($Command.Command) | Select-Object -Property $($Command.Properties)"
        $script:OutputFileFileType = "csv"
    }
    #elseif ($Command.Type -eq "(RPC) CMD") {
    #    $CommandString = "$($Command.Command)"
    #    $script:OutputFileFileType = "txt"
    #}




    elseif ($Command.Type -eq "(SMB) PoSh") {
        $CommandString = "$($Command.Command) | Select-Object -Property $($Command.Properties)"
        $script:OutputFileFileType = "txt"
    }
    elseif ($Command.Type -eq "(SMB) WMI") {
        $CommandString = "$($Command.Command) | Select-Object -Property $($Command.Properties)"
        $script:OutputFileFileType = "txt"
    }
    elseif ($Command.Type -eq "(SMB) CMD") {
        $CommandString = "$($Command.Command)"
        $script:OutputFileFileType = "txt"
    }


    $CommandName = $Command.Name
    $CommandType = $Command.Type


    # Checks for the file output type, removes previous results with a file, then executes the commands
    if ( $Command.Type -eq "(WinRM) Script" ) {
        $OutputFilePath = "$script:CollectedDataTimeStampDirectory\$((($CommandName) -split ' -- ')[1]) - $CommandType"
        Remove-Item -Path "$OutputFilePath.csv" -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "$OutputFilePath.xml" -Force -ErrorAction SilentlyContinue

        #The following string replacements edits the command to be compatible with session based queries witj -filepath
        $CommandString = $CommandString.replace('Invoke-Command -FilePath ','').replace("'","").replace('"','')
        Invoke-Command -FilePath $CommandString -Session $PSSession | Select-Object -Property PSComputerName, * -ExcludeProperty "__*",RunspaceID `
        | Set-Variable SessionData
        $SessionData | Export-Csv -Path "$OutputFilePath.csv" -NoTypeInformation -Force
        $SessionData | Export-Clixml -Path "$OutputFilePath.xml"
        Remove-Variable -Name SessionData
    }
    elseif ( $script:OutputFileFileType -eq "csv" ) {
        $OutputFilePath = "$script:CollectedDataTimeStampDirectory\$((($CommandName) -split ' -- ')[1]) - $CommandType"
        Remove-Item -Path "$OutputFilePath.csv" -Force -ErrorAction SilentlyContinue
        Invoke-Command -ScriptBlock { param($CommandString); Invoke-Expression -Command $CommandString } -argumentlist $CommandString -Session $PSSession `
        | Set-Variable SessionData
        $SessionData | Export-Csv -Path "$OutputFilePath.csv" -NoTypeInformation -Force
        $SessionData | Export-Clixml -Path "$OutputFilePath.xml" -Force
        Remove-Variable -Name SessionData -Force
    }
    elseif ( $script:OutputFileFileType -eq "txt" ) {
        $OutputFilePath = "$script:CollectedDataTimeStampDirectory\$((($CommandName) -split ' -- ')[1]) - $CommandType - $($TargetComputer)"
        Remove-Item -Path "$OutputFilePath.txt" -Force -ErrorAction SilentlyContinue
        Invoke-Command -ScriptBlock { param($CommandString); Invoke-Expression -Command $CommandString } -argumentlist $CommandString -Session $PSSession `
        | Set-Variable SessionData
        $SessionData | Out-File -Path "$OutputFilePath.txt" -Force
        $SessionData | Export-Clixml -Path "$OutputFilePath.xml" -Force
        Remove-Variable -Name SessionData -Force
    }


    $ResultsListBox.Items.RemoveAt(0)
    $ResultsListBox.Items.Insert(0,"$(($ExecutionStartTime).ToString('yyyy/MM/dd HH:mm:ss'))  [$(New-TimeSpan -Start $ExecutionStartTime -End (Get-Date))]  $CollectionName")
    $PoShEasyWin.Refresh()


    Create-LogEntry -LogFile $LogFile -NoTargetComputer -Message "[+] Invoke-Command -ScriptBlock { param($CommandString); Invoke-Expression -Command $CommandString } -argumentlist $CommandString -Session `$PSSession"


    $script:ProgressBarQueriesProgressBar.Value   += 1
    $script:ProgressBarEndpointsProgressBar.Value = ($PSSession.ComputerName).Count
    $PoShEasyWin.Refresh()
    Start-Sleep -match 500
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUPvDUTtvNMx2yfTuFGJq1WUNc
# yFWgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUXq/SlegGUQWYKIvOi2OwOoW7aIwwDQYJKoZI
# hvcNAQEBBQAEggEAUQEPUW1hpTHPoIjJexVfvPXQCb7VzxmywBEohQfuxCh26xsS
# 7vOkw4G2L7M6hYkLCYMY3AU4MLoVfFL4GLO7R/Jd18m+BV/LAafLdkGd9VED5ueZ
# SXcSN8DSs921ubxRQGn3aruaxXGrZ78tMpeq6HNFWWcbYso8TyZYyePKHSnKSenJ
# AMYQ9bS42VwDw/BGP3TTsaofQEmAZnAEdzBUURCvqD6N/NEOQJdz+2ZORSM3TnyS
# DByFb9At6Af0rBJhvAfv+hH98NvwJiX6RDI2eK0roAiKKgK0qvg9sPiKVCa3sHNr
# 5MGn3VEcAWtmMUZgitwpPEFvB0Cgbs/yi7oQ2A==
# SIG # End signature block
