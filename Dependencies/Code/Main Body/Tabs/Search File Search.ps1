
$Section1FileSearchTab = New-Object System.Windows.Forms.TabPage -Property @{
    Text   = "File Search  "
    Left   = $FormScale * 3
    Top    = $FormScale * -10
    Width  = $FormScale * 450
    Height = $FormScale * 20
    Font   = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
    UseVisualStyleBackColor = $True
    ImageIndex = 4
}
$MainLeftSearchTabControl.Controls.Add($Section1FileSearchTab)

# Recursively goes through directories down to the specified depth
# Used for backwards compatibility with systems that have older PowerShell versions, newer versions of PowerShell has a -Depth parameter
Update-FormProgress "$Dependencies\Code\Main Body\Get-ChildItemDepth.ps1"
. "$Dependencies\Code\Main Body\Get-ChildItemDepth.ps1"

# This code is used within both the Individual and Session Based execution modes
Update-FormProgress "$Dependencies\Code\Main Body\Conduct-FileSearch.ps1"
. "$Dependencies\Code\Main Body\Conduct-FileSearch.ps1"

$FileSearchDirectoryListingCheckbox = New-Object System.Windows.Forms.CheckBox -Property @{
    Text   = "Directory Listing (WinRM)"
    Left   = $FormScale * 3
    Top    = $FormScale * 5
    Width  = $FormScale * 230
    Height = $FormScale * 20
    Font   = New-Object System.Drawing.Font("$Font",$($FormScale * 12),1,2,1)
    ForeColor = 'Blue'
    Add_Click = { 
        Update-QueryCount
        
        Update-TreeViewData -Commands -TreeView $script:CommandsTreeView.Nodes
        if ($this.checked){$this.ForeColor = 'Red'} else {$this.ForeColor = 'Blue'}
    }
}
$Section1FileSearchTab.Controls.Add($FileSearchDirectoryListingCheckbox)


        $FileSearchDirectoryListingMaxDepthLabel = New-Object System.Windows.Forms.Label -Property @{
            Text   = "Recursive Depth"
            Left   = $FileSearchDirectoryListingCheckbox.Width + $($FormScale * 52)
            Top    = $FileSearchDirectoryListingCheckbox.Top + $($FormScale * 5)
            Width  = $FormScale * 100
            Height = $FormScale * 20
            Font   = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            ForeColor  = "Black"
        }
        $Section1FileSearchTab.Controls.Add($FileSearchDirectoryListingMaxDepthLabel)


        $FileSearchDirectoryListingMaxDepthTextbox = New-Object System.Windows.Forms.RichTextBox -Property @{
            Text   = 0
            Left   = $FileSearchDirectoryListingMaxDepthLabel.Left + $FileSearchDirectoryListingMaxDepthLabel.Width
            Top    = $FileSearchDirectoryListingCheckbox.Top + $($FormScale * 2)
            Width  = $FormScale * 50
            Height = $FormScale * 20
            MultiLine = $false
            WordWrap  = $false
            Font      = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
        }
        $Section1FileSearchTab.Controls.Add($FileSearchDirectoryListingMaxDepthTextbox)


        $FileSearchDirectoryListingLabel = New-Object System.Windows.Forms.Label -Property @{
            Text   = "Collection time is dependant on the directory's contents."
            Left   = $FormScale * 3
            Top    = $FileSearchDirectoryListingCheckbox.Top + $FileSearchDirectoryListingCheckbox.Height + $($FormScale * 5)
            Width  = $FormScale * 330
            Height = $FormScale * 20
            Font      = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            ForeColor = "Black"
        }
        $Section1FileSearchTab.Controls.Add($FileSearchDirectoryListingLabel)


        Update-FormProgress "$Dependencies\Code\System.Windows.Forms\TextBox\FileSearchDirectoryListingTextbox.ps1"
        . "$Dependencies\Code\System.Windows.Forms\TextBox\FileSearchDirectoryListingTextbox.ps1"
        $FileSearchDirectoryListingTextbox = New-Object System.Windows.Forms.TextBox -Property @{
            Left   = $FormScale * 3
            Top    = $FileSearchDirectoryListingLabel.Top + $FileSearchDirectoryListingLabel.Height + $($FormScale * 5)
            Width  = $FormScale * 430
            Height = $FormScale * 20
            MultiLine          = $False
            WordWrap           = $false
            Text               = "Enter a single directory"
            AutoCompleteSource = "FileSystem"
            AutoCompleteMode   = "SuggestAppend"
            Font               = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            Add_MouseEnter = $FileSearchDirectoryListingTextboxAdd_MouseEnter
            Add_MouseLeave = $FileSearchDirectoryListingTextboxAdd_MouseLeave
            Add_MouseHover = $FileSearchDirectoryListingTextboxAdd_MouseHover
        }
        $Section1FileSearchTab.Controls.Add($FileSearchDirectoryListingTextbox)


$FileSearchFileSearchCheckbox = New-Object System.Windows.Forms.CheckBox -Property @{
    Text   = "File Search (WinRM)"
    Left   = $FormScale * 3
    Top    = $FileSearchDirectoryListingTextbox.Top + $FileSearchDirectoryListingTextbox.Height + $($FormScale * 25)
    Width  = $FormScale * 230
    Height = $FormScale * 20
    Font   = New-Object System.Drawing.Font("$Font",$($FormScale * 12),1,2,1)
    ForeColor = 'Blue'
    Add_Click = {
        Update-QueryCount

        Update-TreeViewData -Commands -TreeView $script:CommandsTreeView.Nodes
        if ($this.checked){$this.ForeColor = 'Red'} else {$this.ForeColor = 'Blue'}
    }
}
$Section1FileSearchTab.Controls.Add($FileSearchFileSearchCheckbox)


        $FileSearchFileSearchMaxDepthLabel = New-Object System.Windows.Forms.Label -Property @{
            Text   = "Recursive Depth"
            Left   = $FileSearchFileSearchCheckbox.Width + $($FormScale * 52)
            Top    = $FileSearchFileSearchCheckbox.Top + $($FormScale * 5)
            Width  = $FormScale * 100
            Height = $FormScale * 20
            Font   = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            ForeColor  = "Black"
        }
        $Section1FileSearchTab.Controls.Add($FileSearchFileSearchMaxDepthLabel)


        $FileSearchFileSearchMaxDepthTextbox = New-Object System.Windows.Forms.RichTextBox -Property @{
            Text   = 0
            Left   = $FileSearchFileSearchMaxDepthLabel.Left + $FileSearchFileSearchMaxDepthLabel.Width
            Top    = $FileSearchFileSearchCheckbox.Top + $($FormScale * 2)
            Width  = $FormScale * 50
            Height = $FormScale * 20
            MultiLine = $false
            WordWrap  = $false
            Font      = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
        }
        $Section1FileSearchTab.Controls.Add($FileSearchFileSearchMaxDepthTextbox)


        $FileSearchFileSearchLabel = New-Object System.Windows.Forms.Label -Property @{
            Text   = "Collection time depends on the number of files and directories, plus recursive depth."
            Left   = $FormScale * 3
            Top    = $FileSearchFileSearchMaxDepthTextbox.Top + $FileSearchFileSearchMaxDepthTextbox.Height + $($FormScale * 2)
            Width  = $FormScale * 450
            Height = $FormScale * 20
            Font      = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            ForeColor = "Black"
        }
        $Section1FileSearchTab.Controls.Add($FileSearchFileSearchLabel)


        $FileSearchSearchByFileHashLabel = New-Object System.Windows.Forms.Label -Property @{
            Text   = "Search by Filename or Filehash:"
            Left   = $FileSearchFileSearchLabel.Left
            Top    = $FileSearchFileSearchLabel.Top + $FileSearchFileSearchLabel.Height
            Width  = $FormScale * 175
            Height = $FormScale * 20
            Font      = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            ForeColor = "Black"
        }
        $Section1FileSearchTab.Controls.Add($FileSearchSearchByFileHashLabel)


        Update-FormProgress "$Dependencies\Code\Main Body\Get-FileHash.ps1"
        . "$Dependencies\Code\Main Body\Get-FileHash.ps1"
        $FileSearchSelectFileHashComboBox = New-Object System.Windows.Forms.ComboBox -Property @{
            Text   = "Filename"
            Left   = $FileSearchSearchByFileHashLabel.Left + $FileSearchSearchByFileHashLabel.Width
            Top    = $FileSearchSearchByFileHashLabel.Top
            Width  = $FormScale * 100
            Height = $FormScale * 20
            Font   = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
        }
        $HashingAlgorithms = @('Filename','MD5','SHA1','SHA256','SHA384','SHA512','RIPEMD160')
        ForEach ($Hash in $HashingAlgorithms) { $FileSearchSelectFileHashComboBox.Items.Add($Hash) }
        $Section1FileSearchTab.Controls.Add($FileSearchSelectFileHashComboBox)


        Update-FormProgress "$Dependencies\Code\System.Windows.Forms\RichTextBox\FileSearchFileSearchDirectoryRichTextbox.ps1"
        . "$Dependencies\Code\System.Windows.Forms\RichTextBox\FileSearchFileSearchDirectoryRichTextbox.ps1"
        $FileSearchFileSearchDirectoryRichTextbox = New-Object System.Windows.Forms.RichTextBox -Property @{
            Text   = "Enter Directories; One Per Line"
            Left   = $FormScale * 3
            Top    = $FileSearchSearchByFileHashLabel.Top + $FileSearchSearchByFileHashLabel.Height + ($FormScale * 5)
            Width  = $FormScale * 430
            Height = $FormScale * 80
            MultiLine = $True
            Font      = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            Add_MouseEnter = $FileSearchFileSearchDirectoryRichTextboxAdd_MouseEnter
            Add_MouseLeave = $FileSearchFileSearchDirectoryRichTextboxAdd_MouseLeave
            Add_MouseHover = $FileSearchFileSearchDirectoryRichTextboxAdd_MouseHover
        }
        $Section1FileSearchTab.Controls.Add($FileSearchFileSearchDirectoryRichTextbox)


        Update-FormProgress "$Dependencies\Code\System.Windows.Forms\RichTextBox\FileSearchFileSearchFileRichTextbox.ps1"
        . "$Dependencies\Code\System.Windows.Forms\RichTextBox\FileSearchFileSearchFileRichTextbox.ps1"
        $FileSearchFileSearchFileRichTextbox = New-Object System.Windows.Forms.RichTextBox -Property @{
            Text   = "Enter FileNames; One Per Line"
            Left   = $FormScale * 3
            Top    = $FileSearchFileSearchDirectoryRichTextbox.Top + $FileSearchFileSearchDirectoryRichTextbox.Height + $($FormScale * 5)
            Width  = $FormScale * 430
            Height = $FormScale * 80
            MultiLine  = $True
            ScrollBars = "Vertical" #Horizontal
            Font       = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            Add_MouseEnter = $FileSearchFileSearchFileRichTextboxAdd_MouseEnter
            Add_MouseLeave = $FileSearchFileSearchFileRichTextboxAdd_MouseLeave
            Add_MouseHover = $FileSearchFileSearchFileRichTextboxAdd_MouseHover
        }
        $Section1FileSearchTab.Controls.Add($FileSearchFileSearchFileRichTextbox)


Update-FormProgress "$Dependencies\Code\Main Body\Search-AlternateDataStream.ps1"
. "$Dependencies\Code\Main Body\Search-AlternateDataStream.ps1"
$FileSearchAlternateDataStreamCheckbox = New-Object System.Windows.Forms.CheckBox -Property @{
    Text   = "Alternate Data Stream Search (WinRM)"
    Left   = $FormScale * 3
    Top    = $FileSearchFileSearchFileRichTextbox.Top + $FileSearchFileSearchFileRichTextbox.Height + $($FormScale * 20)
    Width  = $FormScale * 260
    Height = $FormScale * 20
    Font   = New-Object System.Drawing.Font("$Font",$($FormScale * 12),1,2,1)
    ForeColor = 'Blue'
    Add_Click = { 
        Update-QueryCount
        
        Update-TreeViewData -Commands -TreeView $script:CommandsTreeView.Nodes
        if ($this.checked){$this.ForeColor = 'Red'} else {$this.ForeColor = 'Blue'}
    }
}
$Section1FileSearchTab.Controls.Add($FileSearchAlternateDataStreamCheckbox)


        $FileSearchAlternateDataStreamMaxDepthLabel = New-Object System.Windows.Forms.Label -Property @{
            Text   = "Recursive Depth"
            Left   = $FileSearchFileSearchCheckbox.Width + $($FormScale * 52)
            Top    = $FileSearchAlternateDataStreamCheckbox.Top + $($FormScale * 5)
            Width  = $FormScale * 100
            Height = $FormScale * 20
            Font   = New-Object System.Drawing.Font("$Font",$($FormScale *11),0,0,0)
        }
        $Section1FileSearchTab.Controls.Add($FileSearchAlternateDataStreamMaxDepthLabel)


        $FileSearchAlternateDataStreamMaxDepthTextbox = New-Object System.Windows.Forms.RichTextBox -Property @{
            Text   = 0
            Left   = $FileSearchAlternateDataStreamMaxDepthLabel.Left + $FileSearchAlternateDataStreamMaxDepthLabel.Width
            Top    = $FileSearchAlternateDataStreamCheckbox.Top + $($FormScale * 2)
            Width  = $FormScale * 50
            Height = $FormScale * 20
            MultiLine = $false
            Font      = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
        }
        $Section1FileSearchTab.Controls.Add($FileSearchAlternateDataStreamMaxDepthTextbox)


        $FileSearchAlternateDataStreamLabel = New-Object System.Windows.Forms.Label -Property @{
            Text   = "Exlcudes':`$DATA' stream, and will show the ADS name and its contents."
            Left   = $FormScale * 3
            Top    = $FileSearchAlternateDataStreamMaxDepthTextbox.Top + $FileSearchAlternateDataStreamMaxDepthTextbox.Height
            Width  = $FormScale * 450
            Height = $FormScale * 20
            Font   = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            ForeColor = "Black"
        }
        $Section1FileSearchTab.Controls.Add($FileSearchAlternateDataStreamLabel)


        Update-FormProgress "$Dependencies\Code\System.Windows.Forms\RichTextBox\FileSearchAlternateDataStreamDirectoryRichTextbox.ps1"
        . "$Dependencies\Code\System.Windows.Forms\RichTextBox\FileSearchAlternateDataStreamDirectoryRichTextbox.ps1"
        $FileSearchAlternateDataStreamDirectoryRichTextbox = New-Object System.Windows.Forms.RichTextBox -Property @{
            Lines  = "Enter Directories; One Per Line"
            Left   = $FormScale * 3
            Top    = $FileSearchAlternateDataStreamLabel.Top + $FileSearchAlternateDataStreamLabel.Height
            Width  = $FormScale * 430
            Height = $FormScale * 80
            Font   = New-Object System.Drawing.Font("$Font",$($FormScale * 11),0,0,0)
            MultiLine     = $True
            Add_MouseEnter = $FileSearchAlternateDataStreamDirectoryRichTextboxAdd_MouseEnter
            Add_MouseLeave = $FileSearchAlternateDataStreamDirectoryRichTextboxAdd_MouseLeave
            Add_MouseHover = $FileSearchAlternateDataStreamDirectoryRichTextboxAdd_MouseHover
        }
        $Section1FileSearchTab.Controls.Add($FileSearchAlternateDataStreamDirectoryRichTextbox)


        Update-FormProgress "$Dependencies\Code\System.Windows.Forms\Button\FileSearchAlternateDataStreamDirectoryExtractStreamDataButton.ps1"
        . "$Dependencies\Code\System.Windows.Forms\Button\FileSearchAlternateDataStreamDirectoryExtractStreamDataButton.ps1"
        . "$Dependencies\Code\Main Body\Get-RemoteAlternateDataStream.ps1"
        $FileSearchAlternateDataStreamDirectoryExtractStreamDataButton = New-Object System.Windows.Forms.Button -Property @{
            Text   = 'Retrieve and Extract Stream Data'
            Left   = $FileSearchAlternateDataStreamDirectoryRichTextbox.Left + $FileSearchAlternateDataStreamDirectoryRichTextbox.Width - $($FormScale * 200 - 1)
            Top    = $FileSearchAlternateDataStreamDirectoryRichTextbox.Top + $FileSearchAlternateDataStreamDirectoryRichTextbox.Height + $($FormScale * 5)
            Width  = $FormScale * 200
            Height = $FormScale * 20
            Add_Click = $FileSearchAlternateDataStreamDirectoryExtractStreamDataButtonAdd_Click
        }
        $Section1FileSearchTab.Controls.Add($FileSearchAlternateDataStreamDirectoryExtractStreamDataButton)
        Apply-CommonButtonSettings -Button $FileSearchAlternateDataStreamDirectoryExtractStreamDataButton

# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU/D+5v2H4fjPRbvCHIzWyTFC8
# GC+gggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQU66JSyNPNbdvy/rIyrulGnUJzgHYwDQYJKoZI
# hvcNAQEBBQAEggEAEuV9hCicmcq2ygBKuZJ0Mx2lglVMDtwsz9y8c+ukdxwIwTFy
# vUdv9hRFEIRag6ZObjojl4lV0VINlrpzCSASdq93umew8BhwWVj+vOqsVsScUFBc
# VKYzPEz1eJFiwjqiLW0CnPqQgq/90SJwcTvUhhv9FMj5DuHVBraonnvfjb1tz/RP
# BP7nkQ0gSj27V54EnF6SZ1YdW6NUqlGKFp8l12VFpoipP1JlPE3XGeEK9oNmT2k/
# ygrOtz24WwRfNiXrXg0EGukQ5KCEYtM+fHV9qV/tHfG5s+9xNTtSe89cm4w4RobT
# TULXppT4b75W+6mI6CP+WG8vo3+Q9uoDPnSHmA==
# SIG # End signature block