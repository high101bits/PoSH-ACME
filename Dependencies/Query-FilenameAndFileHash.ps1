function Query-FilenameAndFileHash {
    $CollectionName = "File Search"
    $CollectionCommandStartTime = Get-Date 
    $StatusListBox.Items.Clear()
    $StatusListBox.Items.Add("Query: $CollectionName")                    
    $ResultsListBox.Items.Insert(0,"$(($CollectionCommandStartTime).ToString('yyyy/MM/dd HH:mm:ss')) $CollectionName")
    foreach ($TargetComputer in $ComputerList) {
        param(
            $CollectedDataTimeStampDirectory, 
            $IndividualHostResults, 
            $CollectionName, 
            $TargetComputer
        )
        Conduct-PreCommandCheck -CollectedDataTimeStampDirectory $CollectedDataTimeStampDirectory `
                                -IndividualHostResults $IndividualHostResults -CollectionName $CollectionName `
                                -TargetComputer $TargetComputer
        Create-LogEntry -TargetComputer $TargetComputer -CollectionName $CollectionName -LogFile $LogFile

        $DirectoriesToSearch = $FileSearchFileSearchDirectoryTextbox.Text -split "`r`n"
        $FilesToSearch       = $FileSearchFileSearchFileTextbox.Text -split "`r`n"
        $MaximumDepth        = $FileSearchFileSearchMaxDepthTextbox.text
        $FileHashSelection   = $FileSearchSelectFileHashCheckbox.Text

        if ($ComputerListProvideCredentialsCheckBox.Checked) {
            if (!$script:Credential) { $script:Credential = Get-Credential }
            $QueryCredentialParam = ", $script:Credential"
            $QueryCredential      = "-Credential $script:Credential"
        }
        else {
            $QueryCredentialParam = $null
            $QueryCredential      = $null        
        }
$QueryJob= @"
        Start-Job -Name "PoSh-ACME: `$(`$CollectionName) -- `$(`$TargetComputer)" -ScriptBlock {
            param(`$DirectoriesToSearch, `$FilesToSearch, `$TargetComputer, `$DirectoryPath, `$Filename, `$MaximumDepth, `$IndividualHostResults, `$CollectionName $QueryCredentialParam)
            [System.Threading.Thread]::CurrentThread.Priority = 'High'
            ([System.Diagnostics.Process]::GetCurrentProcess()).PriorityClass = 'High'

            `$FilesFoundList = @()
            foreach (`$DirectoryPath in `$DirectoriesToSearch) {
                foreach (`$Filename in `$FilesToSearch) {
                    `$FilesFound = Invoke-Command -ComputerName `$TargetComputer $QueryCredential -ScriptBlock {
                        param(`$DirectoryPath, `$Filename, `$MaximumDepth, `$TargetComputer)

                    $GetChildItemRecurse

                    `$MaxDepth = `$MaximumDepth
                    `$Path = `$DirectoryPath
                        
                    Get-ChildItemRecurse -Path `$Path -Depth `$MaxDepth | Where-Object { (`$_.Name -match "`$Filename") }
                    } -ArgumentList @(`$DirectoryPath, `$Filename, `$MaximumDepth, `$TargetComputer)
                        
                    `$FilesFoundList += `$FilesFound | Select-Object -Property PSComputerName, Directory, Name, BaseName, Extension, Attributes, CreationTime, LastWriteTime, LastAccessTime, FullName
                }
            }
            `$FilesFoundList | Export-CSV "`$(`$IndividualHostResults)\`$(`$CollectionName)\`$(`$CollectionName)-`$(`$TargetComputer).csv" -NoTypeInformation
        } -ArgumentList @(`$DirectoriesToSearch, `$FilesToSearch, `$TargetComputer, `$DirectoryPath, `$Filename, `$MaximumDepth, `$IndividualHostResults, `$CollectionName $QueryCredentialParam)
"@
    Invoke-Expression -Command $QueryJob
    }
    Monitor-Jobs
    $CollectionCommandEndTime  = Get-Date                    
    $CollectionCommandDiffTime = New-TimeSpan -Start $CollectionCommandStartTime -End $CollectionCommandEndTime
    $ResultsListBox.Items.RemoveAt(0)
    $ResultsListBox.Items.Insert(0,"$(($CollectionCommandStartTime).ToString('yyyy/MM/dd HH:mm:ss')) [$CollectionCommandDiffTime]  $CollectionName")
    Compile-CsvFiles -LocationOfCSVsToCompile   "$($IndividualHostResults)\$($CollectionName)\$($CollectionName)*.csv" `
                     -LocationToSaveCompiledCSV "$($CollectedDataTimeStampDirectory)\$($CollectionName).csv"
}