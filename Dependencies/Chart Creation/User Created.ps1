    # Open File
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    $ViewChartOpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $ViewChartOpenFileDialog.Title = "Open File To View As A Chart"
    $ViewChartOpenFileDialog.InitialDirectory = "$CollectedDataDirectory"
    $ViewChartOpenFileDialog.Filter = "CSV (*.csv)| *.csv|Excel (*.xlsx)| *.xlsx|Excel (*.xls)| *.xls|All files (*.*)|*.*"
    $ViewChartOpenFileDialog.ShowDialog() | Out-Null
    $ViewChartOpenFileDialog.ShowHelp = $true

    #====================================
    # Custom View Chart Command Function
    #====================================
    function ViewChartCommand {
        #https://bytecookie.wordpress.com/2012/04/13/tutorial-powershell-and-microsoft-chart-controls-or-how-to-spice-up-your-reports/
        # PowerShell v3+ OR PowerShell v2 with Microsoft Chart Controls for Microsoft .NET Framework 3.5 Installed
        #-----------------------------------------
        # Custom View Chart - Obtains source data
        #-----------------------------------------
            $DataSource = $ViewChartFile | Select-Object -Property $Script:ViewChartChoice[0], $Script:ViewChartChoice[1]

        #--------------------------
        # Custom View Chart Object
        #--------------------------
            $Chart = New-object System.Windows.Forms.DataVisualization.Charting.Chart
            $Chart.Width           = 700
            $Chart.Height          = 400
            $Chart.Left            = 10
            $Chart.Top             = 10
            $Chart.BackColor       = [System.Drawing.Color]::White
            $Chart.BorderColor     = 'Black'
            $Chart.BorderDashStyle = 'Solid'
            $Chart.Font            = New-Object System.Drawing.Font @('Microsoft Sans Serif','18', [System.Drawing.FontStyle]::Bold)
        #-------------------------
        # Custom View Chart Title 
        #-------------------------
            $ChartTitle = New-Object System.Windows.Forms.DataVisualization.Charting.Title
            $ChartTitle.text      = ($ViewChartOpenFileDialog.FileName.split('\'))[-1] -replace '.csv',''
            $ChartTitle.Font      = New-Object System.Drawing.Font @('Microsoft Sans Serif','18', [System.Drawing.FontStyle]::Bold)
            $ChartTitle.ForeColor = "black"
            $ChartTitle.Alignment = "topcenter" #"topLeft"
            $Chart.Titles.Add($ChartTitle)
        #------------------------
        # Custom View Chart Area
        #------------------------
            $ChartArea                = New-Object System.Windows.Forms.DataVisualization.Charting.ChartArea
            $ChartArea.Name           = "Chart Area"
            $ChartArea.AxisX.Title    = $Script:ViewChartChoice[0]
            if ($Script:ViewChartChoice[1] -eq "PSComputername") {$ChartArea.AxisY.Title = "Hosts"}
            else {$ChartArea.AxisY.Title    = $Script:ViewChartChoice[1]}
            $ChartArea.AxisX.Interval = 1
            #$ChartArea.AxisY.Interval = 1
            $ChartArea.AxisY.IntervalAutoMode = $true

            # Option to enable 3D Charts
            if ($Script:ViewChartChoice[7] -eq $true) {
                $ChartArea.Area3DStyle.Enable3D=$True
                $ChartArea.Area3DStyle.Inclination = 50
            }
            $Chart.ChartAreas.Add($ChartArea)
        #--------------------------
        # Custom View Chart Legend 
        #--------------------------
            $Legend = New-Object system.Windows.Forms.DataVisualization.Charting.Legend
            $Legend.Enabled = $Script:ViewChartChoice[6]
            $Legend.Name = "Legend"
            $Legend.Title = $Script:ViewChartChoice[1]
            $Legend.TitleAlignment = "topleft"
            $Legend.TitleFont = New-Object System.Drawing.Font @('Microsoft Sans Serif','11', [System.Drawing.FontStyle]::Bold)
            $Legend.IsEquallySpacedItems = $True
            $Legend.BorderColor = 'Black'
            $Chart.Legends.Add($Legend)
        #---------------------------------
        # Custom View Chart Data Series 1
        #---------------------------------
            $Series01Name = $Script:ViewChartChoice[1]
            $Chart.Series.Add("$Series01Name")
            $Chart.Series["$Series01Name"].ChartType = $Script:ViewChartChoice[2]
            $Chart.Series["$Series01Name"].BorderWidth  = 1
            $Chart.Series["$Series01Name"].IsVisibleInLegend = $true
            $Chart.Series["$Series01Name"].Chartarea = "Chart Area"
            $Chart.Series["$Series01Name"].Legend = "Legend"
            $Chart.Series["$Series01Name"].Color = "#62B5CC"
            $Chart.Series["$Series01Name"].Font = New-Object System.Drawing.Font @('Microsoft Sans Serif','9', [System.Drawing.FontStyle]::Normal)
            # Pie Charts - Moves text off pie
            $Chart.Series["$Series01Name"]['PieLabelStyle'] = 'Outside'
            $Chart.Series["$Series01Name"]['PieLineColor'] = 'Black'
            $Chart.Series["$Series01Name"]['PieDrawingStyle'] = 'Concave'

        #-----------------------------------------------------------
        # Custom View Chart - Code that counts computers that match
        #-----------------------------------------------------------
            # If the Second field/Y Axis equals PSComputername, it counts it
            if ($Script:ViewChartChoice[1] -eq "PSComputerName") {
                $Script:ViewChartChoice0 = "Name"
                $Script:ViewChartChoice1 = "PSComputerName"                

                $UniqueDataFields = $DataSource | Select-Object -Property $Script:ViewChartChoice0 | Sort-Object -Property $Script:ViewChartChoice0 -Unique                
                $ComputerWithDataResults = @()
                foreach ($DataField in $UniqueDataFields) {
                    $Count = 0
                    $Computers = @()
                    foreach ( $Line in $DataSource ) { 
                        if ( $Line.Name -eq $DataField.Name ) {
                            $Count += 1
                            if ( $Computers -notcontains $Line.PSComputerName ) { $Computers += $Line.PSComputerName }
                        }
                    }
                    $UniqueCount = $Computers.Count
                    $ComputersWithData =  New-Object PSObject -Property @{
                        DataField    = $DataField
                        TotalCount   = $Count
                        UniqueCount  = $UniqueCount
                        ComputerHits = $Computers 
                    }
                    $ComputerWithDataResults += $ComputersWithData
                }
                if ($Script:ViewChartChoice[5]) {
                    $ComputerWithDataResults `
                        | Sort-Object -Property UniqueCount -Descending `
                        | Select-Object -First $Script:ViewChartChoice[3] `
                        | ForEach-Object {$Chart.Series["$Series01Name"].Points.AddXY($_.DataField.Name,$_.UniqueCount)}
                }
                else {
                    $ComputerWithDataResults `
                        | Sort-Object -Property UniqueCount `
                        | Select-Object -First $Script:ViewChartChoice[3] `
                        | ForEach-Object {$Chart.Series["$Series01Name"].Points.AddXY($_.DataField.Name,$_.UniqueCount)}
                }
            }
            # If the Second field/Y Axis DOES NOT equal PSComputername, Data is generated from the DataSource fields Selected
            else {
                Convert-CSVNumberStringsToIntergers $DataSource
                $DataSourceX = '$_.($Script:ViewChartXChoice)'
                $DataSourceY = '$_.($Script:ViewChartYChoice)'
                if ($Script:ViewChartChoice[5]) {
                    $DataSource `
                    | Sort-Object -Property $Script:ViewChartChoice[1] -Descending `
                    | Select-Object -First $Script:ViewChartChoice[3] `
                    | ForEach-Object {$Chart.Series["$Series01Name"].Points.AddXY( $(iex $DataSourceX), $(iex $DataSourceY) )}  
                }
                else {
                    $DataSource `
                    | Sort-Object -Property $Script:ViewChartChoice[1] `
                    | Select-Object -First $Script:ViewChartChoice[3] `
                    | ForEach-Object {$Chart.Series["$Series01Name"].Points.AddXY( $(iex $DataSourceX), $(iex $DataSourceY) )}  
                }
            }        
        #------------------------
        # Custom View Chart Form 
        #------------------------
            $AnchorAll = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right -bor
                [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
            $ViewChartForm               = New-Object Windows.Forms.Form
            $ViewChartForm.Icon          = [System.Drawing.Icon]::ExtractAssociatedIcon("$Dependencies\favicon.ico")
            $ViewChartForm.Width         = 740
            $ViewChartForm.Height        = 490
            $ViewChartForm.StartPosition = "CenterScreen"
            $ViewChartForm.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
            $ViewChartForm.controls.Add($Chart)
            $Chart.Anchor = $AnchorAll
        #-------------------------------
        # Custom View Chart Save Button
        #-------------------------------
            $SaveButton        = New-Object Windows.Forms.Button
            $SaveButton.Text   = "Save Image"
            $SaveButton.Top    = 420
            $SaveButton.Left   = 600
            $SaveButton.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right
             [enum]::GetNames('System.Windows.Forms.DataVisualization.Charting.ChartImageFormat')
            $SaveButton.Add_Click({
                $Result = Invoke-SaveChartAsImage
                If ($Result) { $Chart.SaveImage($Result.FileName, $Result.Extension) }
            })
            $SaveButton.Font   = New-Object System.Drawing.Font("$Font",11,0,0,0)
        $ViewChartForm.controls.Add($SaveButton)
        $ViewChartForm.Add_Shown({$ViewChartForm.Activate()})
        $ViewChartForm.ShowDialog()

        #---------------------------------------
        # Custom View Chart - Autosave an Image
        #---------------------------------------
        # Autosaves the chart if checked
        $FileName           = ($ViewChartOpenFileDialog.FileName.split('\'))[-1] -replace '.csv',''
        $FileDate           = ($ViewChartOpenFileDialog.FileName.split('\'))[-2] -replace '.csv',''
        if ($OptionsAutoSaveChartsAsImages.checked) { $Chart.SaveImage("$AutosavedChartsDirectory\$FileDate-$FileName.png", 'png') }    }

    #=================================================
    # Custom View Chart Select Property Form Function
    #=================================================
    # This following 'if statement' is used for when canceling out of a window
    if ($ViewChartOpenFileDialog.FileName) {
        # Imports the file chosen
        $ViewChartFile = Import-Csv $ViewChartOpenFileDialog.FileName
        [array]$ViewChartArrayItems = $ViewChartFile | Get-Member -MemberType NoteProperty | Select-Object -Property Name -ExpandProperty Name
        [array]$ViewChartArray = $ViewChartArrayItems | Sort-Object

        function ViewChartSelectProperty{
            [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
            [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

            #------------------------------------
            # Custom View Chart Execute Function
            #------------------------------------
            # This Function Returns the Selected Value from the Drop Down and then Closes the Form
            function ViewChartExecute {
                if ($ViewChartXComboBox.SelectedItem -eq $null){
                    $ViewChartXComboBox.SelectedItem = "Name"
                    $Script:ViewChartXChoice = $ViewChartXComboBox.SelectedItem.ToString()
                }
                if ($ViewChartYComboBox.SelectedItem -eq $null){
                    $ViewChartYComboBox.SelectedItem = "PSComputerName"
                    $Script:ViewChartYChoice = $ViewChartYComboBox.SelectedItem.ToString()
                }
                if ($ViewChartChartTypesComboBox.SelectedItem -eq $null){
                    $ViewChartChartTypesComboBox.SelectedItem = "Column"
                    $Script:ViewChartChartTypesChoice = $ViewChartChartTypesComboBox.SelectedItem.ToString()
                }
                else{
                    $Script:ViewChartXChoice = $ViewChartXComboBox.SelectedItem.ToString()
                    $Script:ViewChartYChoice = $ViewChartYComboBox.SelectedItem.ToString()
                    $Script:ViewChartChartTypesChoice = $ViewChartChartTypesComboBox.SelectedItem.ToString()
                    ViewChartCommand
                }
                # This array outputs the multiple results and is later used in the charts
                $Script:ViewChartChoice = @($Script:ViewChartXChoice, $Script:ViewChartYChoice, $Script:ViewChartChartTypesChoice, $ViewChartLimitResultsTextBox.Text, $ViewChartAscendingRadioButton.Checked, $ViewChartDescendingRadioButton.Checked, $ViewChartLegendCheckBox.Checked, $ViewChart3DChartCheckBox.Checked)
                return $Script:ViewChartChoice
            }

            #----------------------------------
            # Custom View Chart Selection Form
            #----------------------------------
            $ViewChartSelectionForm        = New-Object System.Windows.Forms.Form 
            $ViewChartSelectionForm.width  = 327
            $ViewChartSelectionForm.height = 287 
            $ViewChartSelectionForm.StartPosition = "CenterScreen"
            $ViewChartSelectionForm.Text   = ”View Chart - Select Fields ”
            $ViewChartSelectionForm.Icon   = [System.Drawing.Icon]::ExtractAssociatedIcon("$Dependencies\favicon.ico")
            $ViewChartSelectionForm.ControlBox = $true
            #$ViewChartSelectionForm.Add_Shown({$ViewChartSelectionForm.Activate()})

            #------------------------------
            # Custom View Chart Main Label
            #------------------------------
            $ViewChartMainLabel          = New-Object System.Windows.Forms.Label
            $ViewChartMainLabel.Location = New-Object System.Drawing.Point(10,10) 
            $ViewChartMainLabel.size     = New-Object System.Drawing.Size(290,25) 
            $ViewChartMainLabel.Text     = "Fill out the bellow to view a chart of a csv file:`nNote: Currently some limitations with compiled results files."
            $ViewChartMainLabel.Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
            $ViewChartSelectionForm.Controls.Add($ViewChartMainLabel)

            #------------------------------
            # Custom View Chart X ComboBox
            #------------------------------
            $ViewChartXComboBox          = New-Object System.Windows.Forms.ComboBox
            $ViewChartXComboBox.Location = New-Object System.Drawing.Point(10,($ViewChartMainLabel.Location.y + $ViewChartMainLabel.Size.Height + 5))
            $ViewChartXComboBox.Size     = New-Object System.Drawing.Size(185,25)
            $ViewChartXComboBox.Text     = "Field 1 - X Axis"
            $ViewChartXComboBox.AutoCompleteSource = "ListItems"
            $ViewChartXComboBox.AutoCompleteMode   = "SuggestAppend" # Options are: "Suggest", "Append", "SuggestAppend"
            $ViewChartXComboBox.Add_KeyDown({ if ($_.KeyCode -eq "Enter") {ViewChartExecute} })
            ForEach ($Item in $ViewChartArray) { $ViewChartXComboBox.Items.Add($Item) }
            $ViewChartXComboBox.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
            $ViewChartSelectionForm.Controls.Add($ViewChartXComboBox)

            #------------------------------
            # Custom View Chart Y ComboBox
            #------------------------------
            $ViewChartYComboBox          = New-Object System.Windows.Forms.ComboBox
            $ViewChartYComboBox.Location = New-Object System.Drawing.Point(10,($ViewChartXComboBox.Location.y + $ViewChartXComboBox.Size.Height + 5))
            $ViewChartYComboBox.Size     = New-Object System.Drawing.Size(185,25)
            $ViewChartYComboBox.Text     = "Field 2 - Y Axis"
            $ViewChartYComboBox.AutoCompleteSource = "ListItems"
            $ViewChartYComboBox.AutoCompleteMode   = "SuggestAppend" # Options are: "Suggest", "Append", "SuggestAppend"
            $ViewChartYComboBox.Add_KeyDown({ if ($_.KeyCode -eq "Enter") {ViewChartExecute} })
            ForEach ($Item in $ViewChartArray) { $ViewChartYComboBox.Items.Add($Item) }
            $ViewChartYComboBox.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
            $ViewChartSelectionForm.Controls.Add($ViewChartYComboBox)

            #----------------------------------
            # Custom View Chart Types ComboBox
            #----------------------------------
            $ViewChartChartTypesComboBox          = New-Object System.Windows.Forms.ComboBox
            $ViewChartChartTypesComboBox.Location = New-Object System.Drawing.Point(10,($ViewChartYComboBox.Location.y + $ViewChartYComboBox.Size.Height + 5))
            $ViewChartChartTypesComboBox.Size     = New-Object System.Drawing.Size(185,25)
            $ViewChartChartTypesComboBox.Text     = "Chart Types"
            $ViewChartChartTypesComboBox.AutoCompleteSource = "ListItems"
            $ViewChartChartTypesComboBox.AutoCompleteMode   = "SuggestAppend" # Options are: "Suggest", "Append", "SuggestAppend"
            $ViewChartChartTypesComboBox.Add_KeyDown({ if ($_.KeyCode -eq "Enter") {ViewChartExecute} })
            $ChartTypesAvailable = @('Pie','Column','Line','Bar','Doughnut','Area','--- Less Commonly Used Below ---','BoxPlot','Bubble','CandleStick','ErrorBar','Fastline','FastPoint','Funnel','Kagi','Point','PointAndFigure','Polar','Pyramid','Radar','Range','Rangebar','RangeColumn','Renko','Spline','SplineArea','SplineRange','StackedArea','StackedBar','StackedColumn','StepLine','Stock','ThreeLineBreak')
            ForEach ($Item in $ChartTypesAvailable) {
             [void] $ViewChartChartTypesComboBox.Items.Add($Item)
            }
            $ViewChartChartTypesComboBox.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
            $ViewChartSelectionForm.Controls.Add($ViewChartChartTypesComboBox) 

            #---------------------------------------
            # Custom View Chart Limit Results Label
            #---------------------------------------
            $ViewChartLimitResultsLabel          = New-Object System.Windows.Forms.Label
            $ViewChartLimitResultsLabel.Location = New-Object System.Drawing.Point(10,($ViewChartChartTypesComboBox.Location.y + $ViewChartChartTypesComboBox.Size.Height + 8)) 
            $ViewChartLimitResultsLabel.size     = New-Object System.Drawing.Size(120,25) 
            $ViewChartLimitResultsLabel.Text     = "Limit Results to:"
            $ViewChartLimitResultsLabel.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
            $ViewChartSelectionForm.Controls.Add($ViewChartLimitResultsLabel)

            #-----------------------------------------
            # Custom View Chart Limit Results Textbox
            #-----------------------------------------
            $ViewChartLimitResultsTextBox          = New-Object System.Windows.Forms.TextBox
            $ViewChartLimitResultsTextBox.Text     = 10
            $ViewChartLimitResultsTextBox.Location = New-Object System.Drawing.Point(135,($ViewChartChartTypesComboBox.Location.y + $ViewChartChartTypesComboBox.Size.Height + 5))
            $ViewChartLimitResultsTextBox.Size     = New-Object System.Drawing.Size(60,25)
            $ViewChartLimitResultsTextBox.Add_KeyDown({ if ($_.KeyCode -eq "Enter") {ViewChartExecute} })
            $ViewChartLimitResultsTextBox.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
            $ViewChartSelectionForm.Controls.Add($ViewChartLimitResultsTextBox)

            #---------------------------------------
            # Custom View Chart Sort Order GroupBox
            #---------------------------------------
            # Create a group that will contain your radio buttons
            $ViewChartSortOrderGroupBox          = New-Object System.Windows.Forms.GroupBox
            $ViewChartSortOrderGroupBox.Location = New-Object System.Drawing.Point(10,($ViewChartLimitResultsTextBox.Location.y + $ViewChartLimitResultsTextBox.Size.Height + 7))
            $ViewChartSortOrderGroupBox.size     = '290,65'
            $ViewChartSortOrderGroupBox.text     = "Select how to Sort Data:"

                ### Ascending Radio Button
                $ViewChartAscendingRadioButton          = New-Object System.Windows.Forms.RadioButton
                $ViewChartAscendingRadioButton.Location = New-Object System.Drawing.Point(20,15)
                $ViewChartAscendingRadioButton.size     = '250,25'
                $ViewChartAscendingRadioButton.Checked  = $false
                $ViewChartAscendingRadioButton.Text     = "Ascending / Lowest to Highest"
                $ViewChartAscendingRadioButton.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
                
                ### Descending Radio Button
                $ViewChartDescendingRadioButton          = New-Object System.Windows.Forms.RadioButton
                $ViewChartDescendingRadioButton.Location = New-Object System.Drawing.Point(20,38)
                $ViewChartDescendingRadioButton.size     = '250,25'
                $ViewChartDescendingRadioButton.Checked  = $true
                $ViewChartDescendingRadioButton.Text     = "Descending / Highest to Lowest"
                $ViewChartDescendingRadioButton.Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
                
                $ViewChartSortOrderGroupBox.Controls.AddRange(@($ViewChartAscendingRadioButton,$ViewChartDescendingRadioButton))
            $ViewChartSelectionForm.Controls.Add($ViewChartSortOrderGroupBox) 

            #------------------------------------
            # Custom View Chart Options GroupBox
            #------------------------------------
            # Create a group that will contain your radio buttons
            $ViewChartOptionsGroupBox          = New-Object System.Windows.Forms.GroupBox
            $ViewChartOptionsGroupBox.Location = New-Object System.Drawing.Point(($ViewChartXComboBox.Location.X + $ViewChartXComboBox.Size.Width + 5),$ViewChartXComboBox.Location.Y)
            $ViewChartOptionsGroupBox.size     = '100,105'
            $ViewChartOptionsGroupBox.text     = "Options:"

                ### View Chart Legend CheckBox
                $ViewChartLegendCheckBox          = New-Object System.Windows.Forms.Checkbox
                $ViewChartLegendCheckBox.Location = New-Object System.Drawing.Point(10,15)
                $ViewChartLegendCheckBox.Size     = '85,25'
                $ViewChartLegendCheckBox.Checked  = $false
                $ViewChartLegendCheckBox.Enabled  = $true
                $ViewChartLegendCheckBox.Text     = "Legend"
                $ViewChartLegendCheckBox.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)

                ### View Chart 3D Chart CheckBox
                $ViewChart3DChartCheckBox          = New-Object System.Windows.Forms.Checkbox
                $ViewChart3DChartCheckBox.Location = New-Object System.Drawing.Point(10,38)
                $ViewChart3DChartCheckBox.Size     = '85,25'
                $ViewChart3DChartCheckBox.Checked  = $false
                $ViewChart3DChartCheckBox.Enabled  = $true
                $ViewChart3DChartCheckBox.Text     = "3D Chart"
                $ViewChart3DChartCheckBox.Font          = New-Object System.Drawing.Font("$Font",11,0,0,0)
                
                $ViewChartOptionsGroupBox.Controls.AddRange(@($ViewChartLegendCheckBox,$ViewChart3DChartCheckBox))
            $ViewChartSelectionForm.Controls.Add($ViewChartOptionsGroupBox) 

            #----------------------------------
            # Custom View Chart Execute Button
            #----------------------------------
            $ViewChartExecuteButton          = New-Object System.Windows.Forms.Button
            $ViewChartExecuteButton.Location = New-Object System.Drawing.Point(200,($ViewChartSortOrderGroupBox.Location.y + $ViewChartSortOrderGroupBox.Size.Height + 8))
            $ViewChartExecuteButton.Size     = New-Object System.Drawing.Size(100,23)
            $ViewChartExecuteButton.Text     = "Execute"
            $ViewChartExecuteButton.Add_Click({ ViewChartExecute })
            $ViewChartExecuteButton.Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)  
            $ViewChartSelectionForm.Controls.Add($ViewChartExecuteButton)   
                  
            #---------------------------------------------
            # Custom View Chart Execute Button Note Label
            #---------------------------------------------
            $ViewChartExecuteButtonNoteLabel          = New-Object System.Windows.Forms.Label
            $ViewChartExecuteButtonNoteLabel.Location = New-Object System.Drawing.Point(10,($ViewChartSortOrderGroupBox.Location.y + $ViewChartSortOrderGroupBox.Size.Height + 8)) 
            $ViewChartExecuteButtonNoteLabel.size     = New-Object System.Drawing.Size(190,25) 
            $ViewChartExecuteButtonNoteLabel.Text     = "Note: Press execute again if the desired chart did not appear."
            $ViewChartExecuteButtonNoteLabel.Font     = New-Object System.Drawing.Font("$Font",11,0,0,0)
            $ViewChartSelectionForm.Controls.Add($ViewChartExecuteButtonNoteLabel)

            [void] $ViewChartSelectionForm.ShowDialog()
        }
        $Property = $null
        $Property = ViewChartSelectProperty
    }
