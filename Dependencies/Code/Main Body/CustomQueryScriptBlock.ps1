<#
    .Description
    Scriptblock that is executed to manage the Query Build features such as the interactions between
    the textbox and button, launching Show-Command, variable manipulation, and message prompts
#>

function CustomQueryScriptBlock {
    param(
        [switch]$Build
    )

    $PSDefaultParameterValues = @{
        "Show-Command:Height" = 700
        "Show-Command:Width" = 1000
#        "Show-Command:ErrorPopup" = $True
    }
    if ($script:CustomQueryScriptBlockDisableSyntaxCheckbox.checked) {
        $script:ShowCommandQueryBuild = $script:CustomQueryScriptBlockTextbox.text
        if ($script:ShowCommandQueryBuild -eq $null) {
            $script:CustomQueryScriptBlockTextbox.text = $script:ShowCommandQueryBuild
            $script:CustomQueryScriptBlockTextbox.forecolor = 'black'
            $script:CustomQueryScriptBlockSaved = $script:ShowCommandQueryBuild
            $CustomQueryScriptBlockCheckBox.enabled = $true
            $CustomQueryScriptBlockAddCommandButton.Enabled = $true
            $CustomQueryScriptBlockAddCommandButton.BackColor = 'LightBlue'
        }
        if ($script:ShowCommandQueryBuild -match '-ComputerName') {
            [System.Windows.Forms.MessageBox]::Show("Error: Do not include the -ComputerName parameter.`nRather, make a selection from the Computer Treeview.","PoSh-EasyWin Query Builder",'Ok','Error')

            $script:ShowCommandQueryBuild = $script:ShowCommandQueryBuild -replace "-ComputerName\s(')?(\w|[0-9a-z_-])*(')?\s?",""
            $script:CustomQueryScriptBlockTextbox.text = $script:ShowCommandQueryBuild
            $script:CustomQueryScriptBlockTextbox.forecolor = 'black'
            $script:CustomQueryScriptBlockSaved = $script:ShowCommandQueryBuild
            $CustomQueryScriptBlockCheckBox.enabled = $true
        }
        elseif ($script:ShowCommandQueryBuild -eq $null) {
            $CustomQueryScriptBlockCheckBox.enabled = $true
            $script:CustomQueryScriptBlockSaved =  $script:CustomQueryScriptBlockTextbox.text
        }
    }
    elseif ($Build){
        $script:ShowCommandQueryBuild = Show-Command -PassThru

        if ($script:ShowCommandQueryBuild -eq $null) {
            $script:CustomQueryScriptBlockTextbox.text = 'Enter a cmdlet'
            $script:CustomQueryScriptBlockTextbox.forecolor = 'black'
            $CustomQueryScriptBlockCheckBox.checked = $false
            $CustomQueryScriptBlockCheckBox.enabled = $false
            $CustomQueryScriptBlockAddCommandButton.Enabled = $false
            $CustomQueryScriptBlockAddCommandButton.BackColor = 'LightGray'
        }
        else {
            $script:CustomQueryScriptBlockTextbox.text = $script:ShowCommandQueryBuild
            $script:CustomQueryScriptBlockTextbox.forecolor = 'black'
            $script:CustomQueryScriptBlockSaved = $script:ShowCommandQueryBuild
            $CustomQueryScriptBlockCheckBox.enabled = $true
            $CustomQueryScriptBlockAddCommandButton.Enabled = $true
            $CustomQueryScriptBlockAddCommandButton.BackColor = 'LightBlue'
        }

        if ($script:ShowCommandQueryBuild -match '-ComputerName') {
            [System.Windows.Forms.MessageBox]::Show("Error: Do not include the -ComputerName parameter.`nRather, make a selection from the Computer Treeview.","PoSh-EasyWin Query Builder",'Ok','Error')

            $script:ShowCommandQueryBuild = $script:ShowCommandQueryBuild -replace "-ComputerName\s(')?(\w|[0-9a-z_-])*(')?\s?",""
            $script:CustomQueryScriptBlockTextbox.text = $script:ShowCommandQueryBuild
            $script:CustomQueryScriptBlockTextbox.forecolor = 'black'
            $script:CustomQueryScriptBlockSaved = $script:ShowCommandQueryBuild
            $CustomQueryScriptBlockCheckBox.enabled = $true
        }
        elseif ($script:ShowCommandQueryBuild -eq $null) {
            $CustomQueryScriptBlockCheckBox.enabled = $true
            $script:CustomQueryScriptBlockSaved =  $script:CustomQueryScriptBlockTextbox.text
        }

    }
    else {
        $CustomQueryCheck = $true
        if ($CustomQueryCheck -eq $true) {
            if ($script:CustomQueryScriptBlockTextbox.text -eq 'Enter a cmdlet') {
                [System.Windows.Forms.MessageBox]::Show("Error: Enter a cmdlet that is avaible within a module on this endpoint.","PoSh-EasyWin Query Builder",'Ok','Error')
                $CustomQueryCheck = $false
                $CustomQueryScriptBlockCheckBox.checked = $false
                $CustomQueryScriptBlockCheckBox.enabled = $false
            }
            elseif ($(($script:CustomQueryScriptBlockTextbox.text -split ' ')[0]) -in $script:CmdletList -and $script:CustomQueryScriptBlockTextbox.text -notin $script:CmdletList) {
                [System.Windows.Forms.MessageBox]::Show("The entered cmdlet and any parameters will be updated.","PoSh-EasyWin Query Builder",'Ok','Info')
                $CustomQueryCheck = $true
            }
            elseif ($script:CustomQueryScriptBlockTextbox.text -notin $script:CmdletList) {
                [System.Windows.Forms.MessageBox]::Show("Error: The following is not an available command:`n`n$($script:CustomQueryScriptBlockTextbox.text)","PoSh-EasyWin Query Builder",'Ok','Error')
                $CustomQueryCheck = $false
                $CustomQueryScriptBlockCheckBox.checked = $false
                $CustomQueryScriptBlockCheckBox.enabled = $false
            }

            if (($script:CustomQueryScriptBlockTextbox.text -split ' ').count -eq 1){
                $script:ShowCommandQueryBuild = Show-Command -Name $script:CustomQueryScriptBlockTextbox.text -PassThru
            }
            elseif (($script:CustomQueryScriptBlockTextbox.text -split ' ').count -gt 1){
                $script:ShowCommandQueryBuild = Show-Command -Name $($script:CustomQueryScriptBlockTextbox.text -split ' ')[0] -PassThru
            }

            if ($script:ShowCommandQueryBuild -eq $null) {
                $script:CustomQueryScriptBlockTextbox.text = 'Enter a cmdlet'
                $script:CustomQueryScriptBlockTextbox.forecolor = 'black'
                $CustomQueryScriptBlockCheckBox.checked = $false
                $CustomQueryScriptBlockCheckBox.enabled = $false
                $CustomQueryScriptBlockAddCommandButton.Enabled = $false
                $CustomQueryScriptBlockAddCommandButton.BackColor = 'LightGray'
            }
            else {
                $script:CustomQueryScriptBlockTextbox.text = $script:ShowCommandQueryBuild
                $script:CustomQueryScriptBlockSaved = $script:ShowCommandQueryBuild
                $script:CustomQueryScriptBlockTextbox.forecolor = 'black'
                $CustomQueryScriptBlockCheckBox.enabled = $true
                $CustomQueryScriptBlockAddCommandButton.Enabled = $true
                $CustomQueryScriptBlockAddCommandButton.BackColor = 'LightBlue'
            }

            if ($script:ShowCommandQueryBuild -match '-ComputerName') {
                [System.Windows.Forms.MessageBox]::Show("Error: Do not include the -ComputerName parameter.`nRather, make a selection from the Computer Treeview.","PoSh-EasyWin Query Builder",'Ok','Error')

                $script:ShowCommandQueryBuild = $script:ShowCommandQueryBuild -replace "-ComputerName\s(')?(\w|[0-9a-z_-])*(')?\s?",""
                $script:CustomQueryScriptBlockTextbox.text = $script:ShowCommandQueryBuild
                $script:CustomQueryScriptBlockTextbox.forecolor = 'black'
                $script:CustomQueryScriptBlockSaved = $script:ShowCommandQueryBuild
                $CustomQueryScriptBlockCheckBox.enabled = $true
            }
            elseif ($script:ShowCommandQueryBuild -eq $null) {
                $CustomQueryScriptBlockCheckBox.enabled = $true
                $script:CustomQueryScriptBlockSaved =  $script:CustomQueryScriptBlockTextbox.text
            }
        }
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUbVNfIHFMRkIEklivm6+mdBzx
# 9QqgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUui/as41mscbI32/O43iaE11Y6jMwDQYJKoZI
# hvcNAQEBBQAEggEABkg5oq8ClBzQSvTlBiLLe/UXVj/5Pyp7NMqr1N3Cw0Pq3/Xp
# +E1ajac2kikiDfV/0iF1Urzh0nET/w1KhiLtBl7QdnY0F8UFuob6gIMqPCFzqgVz
# N8Sc54R3IOb297U0AqeM3EQ/uyUFrdv8O1r8LTX32qKvInxyzzSFyZ4cf+GyCiF/
# dTREqvJNZZN3JTSEXB41QUm80Nr0ge74zjKGQn6Nau+CHlULFxQ5vDuh3gLUc9o3
# 5JL8QMQJVxzSjDV//4JhIdlObOahWzVKknqrSRRZNM3rNaNQUi7XskRf5NHjVfNQ
# YU+hfOSUtSWKXZnU8/BVqS+Vb3CE7z0Jc3wwIg==
# SIG # End signature block
