function Initialize-CommandTreeNodes {
    $script:TreeNodeCommandSearch = New-Object -TypeName System.Windows.Forms.TreeNode -ArgumentList "* Search Results          " -Property @{
        Tag       = "Search"
        NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 11),1,2,1)
        ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,0)
    }
    $script:TreeNodeEndpointCommands = New-Object -TypeName System.Windows.Forms.TreeNode -ArgumentList "1) Endpoint Commands          " -Property @{
        Tag       = "Endpoint Commands"
        NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 11),1,2,1)
        ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,0)
    }
    $script:TreeNodeActiveDirectoryCommands = New-Object -TypeName System.Windows.Forms.TreeNode -ArgumentList "2) Active Directory Commands          " -Property @{
        Tag       = "ADDS Commands"
        NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 11),1,2,1)
        ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,0)
    }
    $script:TreeNodeCustomGroupCommands = New-Object -TypeName System.Windows.Forms.TreeNode -ArgumentList "3) Custom Group Commands          " -Property @{
        Tag       = "Custom Group Commands"
        NodeFont  = New-Object System.Drawing.Font("$Font",$($FormScale * 11),1,2,1)
        ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,0)
    }
    $script:TreeNodeCommandSearch.Expand()
    $script:TreeNodeEndpointCommands.Expand()
    $script:TreeNodeActiveDirectoryCommands.Expand()
    $script:TreeNodeCustomGroupCommands.Expand()
    #$script:TreeNodeCustomGroupCommands.Collapse()
    $script:CommandsTreeView.Nodes.Clear()

#    UpdateState-TreeViewData -Endpoint
}


