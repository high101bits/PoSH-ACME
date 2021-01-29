# https://bytecookie.wordpress.com/2012/04/13/tutorial-powershell-and-microsoft-chart-controls-or-how-to-spice-up-your-reports/
# https://blogs.msdn.microsoft.com/alexgor/2009/03/27/aligning-multiple-series-with-categorical-values/

#======================================
# Auto Charts Select Property Function
#======================================
function AutoChartsDashboardCharts {
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

    #----------------------------------
    # Auto Create Charts Selection Form
    #----------------------------------
    $AutoChartsSelectionForm = New-Object System.Windows.Forms.Form -Property @{
        Name          = "Dashboard Charts"
        Text          = "Dashboard Charts"
        Size      = @{ Width  = 327
                       Height = 155 }
        StartPosition = "CenterScreen"
        Icon          = [System.Drawing.Icon]::ExtractAssociatedIcon("$Dependencies\favicon.ico")
        #ControlBox    = $true
        Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
        AutoScroll    = $True
        #FormBorderStyle =  "fixed3d"
    }
    #------------------------------
    # Auto Create Charts Main Label
    #------------------------------
    $AutoChartsMainLabel = New-Object System.Windows.Forms.Label -Property @{
        Text     = "Generate A Dashboard With Multiple Charts "
        Location = @{ X = 10
                      Y = 10 }
        Size     = @{ Width  = 300
                      Height = 25 }
        Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
    }
    $AutoChartsSelectionForm.Controls.Add($AutoChartsMainLabel)


    #----------------------------------
    # Auto Chart Select Chart ComboBox
    #----------------------------------
    $AutoChartSelectChartComboBox = New-Object System.Windows.Forms.ComboBox -Property @{
        Text      = "Select A Chart"
        Location  = @{ X = 10
                     Y = $AutoChartsMainLabel.Location.y + $AutoChartsMainLabel.Size.Height + 5 }
        Size      = @{ Width  = 292
                       Height = 25 }
        Font      = New-Object System.Drawing.Font("$Font",11,0,0,0)
        ForeColor = 'Red'
        AutoCompleteSource = "ListItems"
        AutoCompleteMode   = "SuggestAppend" # Options are: "Suggest", "Append", "SuggestAppend"
    }
    $AutoChartSelectChartComboBox.Add_KeyDown({ if ($_.KeyCode -eq "Enter") { AutoChartsViewCharts }})
    $AutoChartSelectChartComboBox.Add_Click({
        if ($AutoChartSelectChartComboBox.text -eq 'Select A Chart') { $AutoChartSelectChartComboBox.ForeColor = 'Red' }
        else { $AutoChartSelectChartComboBox.ForeColor = 'Black' }
    })
    $AutoChartsAvailable = @(
        "Hunt",
        "Processes",
        "Services"
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
        Location = @{ X = 10
                      Y = $AutoChartSelectChartComboBox.Location.y + $AutoChartSelectChartComboBox.Size.Height + 10 }
        Size     = @{ Width  = 290
                      Height = 10 }
        Value   = 0
    }
    $AutoChartsSelectionForm.Controls.Add($script:AutoChartsProgressBar)


    #-----------------------------------
    # Auto Create Charts Execute Button
    #-----------------------------------
    $AutoChartsExecuteButton = New-Object System.Windows.Forms.Button -Property @{
        Text     = "View Dashboard"
        Location = @{ X = $AutoChartsProgressBar.Location.X
                      Y = $AutoChartsProgressBar.Location.y + $AutoChartsProgressBar.Size.Height + 5 }
        Size     = @{ Width  = $AutoChartsProgressBar.Size.Width
                      Height = 22 }
    }
    $AutoChartsExecuteButton.Add_Click({ 
        if ($AutoChartSelectChartComboBox.text -eq 'Select A Chart') { $AutoChartSelectChartComboBox.ForeColor = 'Red' }
        else { $AutoChartSelectChartComboBox.ForeColor = 'Black' }
        AutoChartsViewCharts
    })
    function AutoChartsViewCharts {
        #####################################################################################################################################
        #####################################################################################################################################
        ##
        ## Auto Create Charts Form 
        ##
        #####################################################################################################################################             
        #####################################################################################################################################
        $AnchorAll = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right -bor
            [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
        $script:AutoChartsForm               = New-Object Windows.Forms.Form -Property @{        
            Location = @{ X = 5
                          Y = 5 }
            Size     = @{ Width  = $PoShACME.Size.Width    #1241
                          Height = $PoShACME.Size.Height } #638    
            StartPosition = "CenterScreen"
            Icon          = [System.Drawing.Icon]::ExtractAssociatedIcon("$Dependencies\favicon.ico")
        }
        $script:AutoChartsForm.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)

        #####################################################################################################################################
        ##
        ## Auto Create Charts TabControl
        ##
        #####################################################################################################################################
        # The TabControl controls the tabs within it
        $AutoChartsTabControl = New-Object System.Windows.Forms.TabControl -Property @{
            Name     = "Auto Charts"
            Text     = "Auto Charts"
            Location = @{ X = 5
                          Y = 5 }
            Size     = @{ Width  = $PoShACME.Size.Width - 25
                          Height = $PoShACME.Size.Height - 50 }        
        }
        $AutoChartsTabControl.ShowToolTips  = $True
        $AutoChartsTabControl.SelectedIndex = 0
        $AutoChartsTabControl.Anchor        = $AnchorAll
        $AutoChartsTabControl.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
        $script:AutoChartsForm.Controls.Add($AutoChartsTabControl)

        # Dashboard with multiple charts
        if ($AutoChartSelectChartComboBox.SelectedItem -eq "Hunt") { 
            # Import code that shows displays the hunt dashboard chart
            . "$ChartCreation\Dashboard Hunt.ps1"

            # Launches the form
            $script:AutoChartsForm.Add_Shown({$script:AutoChartsForm.Activate()})
            [void]$script:AutoChartsForm.ShowDialog()
        }
        elseif ($AutoChartSelectChartComboBox.SelectedItem -eq "Processes") { 
            # Import code that shows displays the hunt dashboard chart
            . "$ChartCreation\Dashboard Processes.ps1"

            # Launches the form
            $script:AutoChartsForm.Add_Shown({$script:AutoChartsForm.Activate()})
            [void]$script:AutoChartsForm.ShowDialog()
        }
        elseif ($AutoChartSelectChartComboBox.SelectedItem -eq "Services") { 
            # Import code that shows displays the hunt dashboard chart
            . "$ChartCreation\Dashboard Services.ps1"

            # Launches the form
            $script:AutoChartsForm.Add_Shown({$script:AutoChartsForm.Activate()})
            [void]$script:AutoChartsForm.ShowDialog()
        }
    }
    $AutoChartsSelectionForm.Controls.Add($AutoChartsExecuteButton)   
    [void] $AutoChartsSelectionForm.ShowDialog()
}