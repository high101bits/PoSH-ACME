function KeepChecked-CommandTreeNode {
    $CommandsTreeView.Nodes.Add($script:TreeNodeEndpointCommands)
    $CommandsTreeView.Nodes.Add($script:TreeNodeActiveDirectoryCommands)
    $CommandsTreeView.Nodes.Add($script:TreeNodeCommandSearch)
    $CommandsTreeView.Nodes.Add($script:TreeNodePreviouslyExecutedCommands)    
    [System.Windows.Forms.TreeNodeCollection]$AllCommandsNode = $CommandsTreeView.Nodes 

    if ($CommandsCheckedBoxesSelected.count -gt 0) {
        $ResultsListBox.Items.Clear()
        $ResultsListBox.Items.Add("Categories that were checked will not remained checked.")
        $ResultsListBox.Items.Add("")
        $ResultsListBox.Items.Add("The following Commands are still selected:")
        foreach ($root in $AllCommandsNode) { 
            foreach ($Category in $root.Nodes) { 
                foreach ($Entry in $Category.nodes) { 
                    if ($CommandsCheckedBoxesSelected -contains $Entry.text -and $root.text -notmatch 'Query History') {
                        $Entry.Checked      = $true
                        $Entry.NodeFont     = New-Object System.Drawing.Font("$Font",10,1,1,1)
                        $Entry.ForeColor    = [System.Drawing.Color]::FromArgb(0,0,0,224)
                        $Category.NodeFont  = New-Object System.Drawing.Font("$Font",10,1,1,1)
                        $Category.ForeColor = [System.Drawing.Color]::FromArgb(0,0,0,224)
                        $Category.Expand()
                        $Root.NodeFont      = New-Object System.Drawing.Font("$Font",10,1,1,1)
                        $Root.ForeColor     = [System.Drawing.Color]::FromArgb(0,0,0,224)
                        $Root.Expand()
                        $ResultsListBox.Items.Add($Entry.Text)
                    }            
                }
            }
        }
    }
}
