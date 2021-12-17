$AutoCreateDashboardChartButtonAdd_Click = {
    # https://bytecookie.wordpress.com/2012/04/13/tutorial-powershell-and-microsoft-chart-controls-or-how-to-spice-up-your-reports/
    # https://blogs.msdn.microsoft.com/alexgor/2009/03/27/aligning-multiple-series-with-categorical-values/
    # Auto Charts Select Property Function

    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

    #----------------------------------
    # Auto Create Charts Selection Form
    #----------------------------------
    $AutoChartsSelectionForm = New-Object System.Windows.Forms.Form -Property @{
        Name          = "Dashboard Charts"
        Text          = "Dashboard Charts"
        Size      = @{ Width  = $FormScale * 327
                       Height = $FormScale * 155 }
        StartPosition = "CenterScreen"
        Icon          = [System.Drawing.Icon]::ExtractAssociatedIcon("$script:EasyWinIcon")
        #ControlBox    = $true
        Font          = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
        AutoScroll    = $True
        #FormBorderStyle =  "fixed3d"
        Add_Closing = { $This.dispose() }
    }

    #------------------------------
    # Auto Create Charts Main Label
    #------------------------------
    $AutoChartsMainLabel = New-Object System.Windows.Forms.Label -Property @{
        Text     = "Generates a dashboard with multiple charts "
        Location = @{ X = $FormScale * 10
                      Y = $FormScale * 10 }
        Size     = @{ Width  = $FormScale * 300
                      Height = $FormScale * 25 }
        Font     = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
    }
    $AutoChartsSelectionForm.Controls.Add($AutoChartsMainLabel)


    #----------------------------------
    # Auto Chart Select Chart ComboBox
    #----------------------------------
    $AutoChartSelectChartComboBox = New-Object System.Windows.Forms.ComboBox -Property @{
        Text      = "Select A Chart"
        Location  = @{ X = $FormScale * 10
                     Y = $AutoChartsMainLabel.Location.y + $AutoChartsMainLabel.Size.Height + $($FormScale * 5) }
        Size      = @{ Width  = $FormScale * 292
                       Height = $FormScale * 25 }
        Font      = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
        ForeColor = 'Red'
        AutoCompleteSource = "ListItems"
        AutoCompleteMode   = "SuggestAppend" # Options are: "Suggest", "Append", "SuggestAppend"
    }
    $AutoChartSelectChartComboBox.Add_KeyDown({ if ($_.KeyCode -eq "Enter") { Launch-AutoChartsViewCharts }})
    $AutoChartSelectChartComboBox.Add_Click({
        if ($AutoChartSelectChartComboBox.text -eq 'Select A Chart') { $AutoChartSelectChartComboBox.ForeColor = 'Red' }
        else { $AutoChartSelectChartComboBox.ForeColor = 'Black' }
    })
    $AutoChartsAvailable = @(
        "Dashboard Overview",
        "Active Directory Computers, Users, and Groups",
        "Threat Hunting with Deep Blue"
    )
    ForEach ($Item in $AutoChartsAvailable) { [void] $AutoChartSelectChartComboBox.Items.Add($Item) }
    $AutoChartsSelectionForm.Controls.Add($AutoChartSelectChartComboBox)


    #----------------------------
    # Auto Charts - Progress Bar
    #----------------------------
    $script:AutoChartsProgressBar = New-Object System.Windows.Forms.ProgressBar -Property @{
        Style    = "Continuous"
        #Maximum = 10
        Minimum  = 0
        Location = @{ X = $FormScale * 10
                      Y = $AutoChartSelectChartComboBox.Location.y + $AutoChartSelectChartComboBox.Size.Height + 10 }
        Size     = @{ Width  = $FormScale * 290
                      Height = $FormScale * 10 }
        Value   = 0
    }
    $AutoChartsSelectionForm.Controls.Add($script:AutoChartsProgressBar)


    #-----------------------------------
    # Auto Create Charts Execute Button
    #-----------------------------------
    $AutoChartsExecuteButton = New-Object System.Windows.Forms.Button -Property @{
        Text     = "View Dashboard"
        Location = @{ X = $AutoChartsProgressBar.Location.X
                      Y = $AutoChartsProgressBar.Location.y + $AutoChartsProgressBar.Size.Height + $($FormScale * 5) }
        Size     = @{ Width  = $AutoChartsProgressBar.Size.Width
                      Height = $FormScale * 22 }
    }
    Apply-CommonButtonSettings -Button $AutoChartsExecuteButton
    $AutoChartsExecuteButton.Add_Click({
        if ($AutoChartSelectChartComboBox.text -eq 'Select A Chart') { $AutoChartSelectChartComboBox.ForeColor = 'Red' }
        else { $AutoChartSelectChartComboBox.ForeColor = 'Black' }
        Launch-AutoChartsViewCharts
    })
    function Launch-AutoChartsViewCharts {
        #####################################################################################################################################
        #####################################################################################################################################
        ##
        ## Auto Create Charts Form
        ##
        #####################################################################################################################################
        #####################################################################################################################################
        $AnchorAll = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right -bor
            [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
        $script:AutoChartsForm = New-Object Windows.Forms.Form -Property @{
            Location = @{ X = $FormScale * 5
                          Y = $FormScale * 5 }
            Size     = @{ Width  = $PoShEasyWin.Size.Width    #1241
                          Height = $PoShEasyWin.Size.Height } #638
            StartPosition = "CenterScreen"
            Icon          = [System.Drawing.Icon]::ExtractAssociatedIcon("$script:EasyWinIcon")
            Font = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            Add_Closing = { $This.dispose() }
        }


        #####################################################################################################################################
        ##
        ## Auto Create Charts TabControl
        ##
        #####################################################################################################################################
        # The TabControl controls the tabs within it
        $AutoChartsTabControl = New-Object System.Windows.Forms.TabControl -Property @{
            Name     = "Auto Charts"
            Text     = "Auto Charts"
            Location = @{ X = $FormScale * 5
                          Y = $FormScale * 5 }
            Size     = @{ Width  = $PoShEasyWin.Size.Width - $($FormScale * 25)
                          Height = $PoShEasyWin.Size.Height - $($FormScale * 50) }
            Appearance = [System.Windows.Forms.TabAppearance]::Buttons    
            Hottrack   = $true
            Font       = New-Object System.Drawing.Font("$Font",$($FormScale * 10),1,2,1)
        }
        $AutoChartsTabControl.ShowToolTips  = $True
        $AutoChartsTabControl.SelectedIndex = 0
        $AutoChartsTabControl.Anchor        = $AnchorAll
        $script:AutoChartsForm.Controls.Add($AutoChartsTabControl)



        # Dashboard with multiple charts
        if ($AutoChartSelectChartComboBox.SelectedItem -eq "Dashboard Overview") {
            . "$Dependencies\Code\Charts\DashboardChart_Hunt.ps1"
            . "$Dependencies\Code\Charts\DashboardChart_Processes.ps1"
            # . "$Dependencies\Code\Charts\DashboardChart_Services.ps1"
            # . "$Dependencies\Code\Charts\DashboardChart_NetworkConnections.ps1"
            # . "$Dependencies\Code\Charts\DashboardChart_NetworkInterfaces.ps1"
            # . "$Dependencies\Code\Charts\DashboardChart_LogonActivity.ps1"
            # . "$Dependencies\Code\Charts\DashboardChart_SecurityPatches.ps1"
            # . "$Dependencies\Code\Charts\DashboardChart_SmbShare.ps1"
            # . "$Dependencies\Code\Charts\DashboardChart_Software.ps1"
            # . "$Dependencies\Code\Charts\DashboardChart_Startups.ps1"
            
            [System.Windows.Forms.MessageBox]::Show("These charts are populated with data from previous queries. If some of the charts are outdated or don't contain data, try running the associated queries. There is a command group with all the applicable queries needs for your convienience.","PoSh-EasyWin",'Ok',"Info")
            $script:AutoChartsForm.Add_Shown({$script:AutoChartsForm.Activate()})
            [void]$script:AutoChartsForm.ShowDialog()
        }
        elseif ($AutoChartSelectChartComboBox.SelectedItem -eq "Active Directory Computers, Users, and Groups") {
            . "$Dependencies\Code\Charts\DashboardChart_ActiveDirectoryComputers.ps1"
            . "$Dependencies\Code\Charts\DashboardChart_ActiveDirectoryUserAccounts.ps1"
            . "$Dependencies\Code\Charts\DashboardChart_ActiveDirectoryGroups.ps1"
            
            $script:AutoChartsForm.Add_Shown({$script:AutoChartsForm.Activate()})
            [void]$script:AutoChartsForm.ShowDialog()
        }
        elseif ($AutoChartSelectChartComboBox.SelectedItem -eq "Threat Hunting with Deep Blue") {
            . "$Dependencies\Code\Charts\DashboardChart_DeepBlue.ps1"
            $script:AutoChartsForm.Add_Shown({$script:AutoChartsForm.Activate()})
            [void]$script:AutoChartsForm.ShowDialog()
        }
        # Garbage Collection to free up memory
        [System.GC]::Collect()
    }
    $AutoChartsSelectionForm.Controls.Add($AutoChartsExecuteButton)
    [void] $AutoChartsSelectionForm.ShowDialog()

    Apply-CommonButtonSettings -Button $OpenXmlResultsButton
    Apply-CommonButtonSettings -Button $OpenCsvResultsButton

    Apply-CommonButtonSettings -Button $AutoCreateDashboardChartButton
    Apply-CommonButtonSettings -Button $SendFilesButton
}

$AutoCreateDashboardChartButtonAdd_MouseHover = {
    Show-ToolTip -Title "Dashboard Charts" -Icon "Info" -Message @"
+  Utilizes PowerShell (v3) charts to visualize data.
+  These charts are auto created from pre-selected CSV files and fields.
+  The dashboard consists of multiple charts from the same CSV file and
    are designed for easy analysis of data to identify outliers.
+  Each chart can be modified and an image can be saved.
"@
}



# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUkKzuJoMiiu1JJSjKYFl3EV5w
# 7t+gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQU97dLR06SSlelse/V8tBaxPKzxFAwDQYJKoZI
# hvcNAQEBBQAEggEASGEuscKK/cl0qW6TCZJK4NhPGLEe7khHyrWG7QV5rK43nCQO
# OTa/nADvdrgzNkQANOskTKBFS9+jhfHkS+VbwFbVlNy3kTdvXiuczy26vhEv67Ct
# Uw6Mb/OQGZFoV95AouEYyYkXDjZP/q8R5DWeM8fN3BlpS7xNZK5divfFCmN76nzc
# evLGNT3SBBBXzago/bLHqLK0szI0Zwalqx25Bi8Zmnabrn8E3Cq3AkLFZdh0zGSB
# LW1zHVQTugAusmkucwl3pvQb/SYfYddSkCWTdeNev1/nhVHJwLU1JciOgprQyzvE
# yvQY1LncA0t+GVF1CrKv3ayL9138xzsebs2hzA==
# SIG # End signature block
