function Show-MessageBox {
    param(
        [string]$Title = 'Oops... No title was provided',

        [string]$Message = 'Oops... there should be a message here!',

        [ValidateSet('None', 'Hand', 'Error', 'Stop', 'Question', 'Exclamation', 'Warning', 'Asterisk', 'Information')]
        [string]$Type = 'Warning',

        [ValidateSet('OK', 'OKCancel', 'AbortRetryIgnore', 'YesNoCancel', 'YesNo', 'RetryCancel')]
        [string]$Options = 'Ok',

        [switch]$Sound
    )
    # Helpful website:
    # https://michlstechblog.info/blog/powershell-show-a-messagebox/

    # If used elsewhere, you need to load the assemply using one of the methods below:
    # 1) [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    # 2) Add-Type -AssemblyName System.Windows.Forms

    if ($Sound) {
        [system.media.systemsounds]::Exclamation.play()
    }

    # Show-MessageBox -Message  -Title "PoSh-EasyWin" -Options "Ok" -Type "Error" -Sound
    return [System.Windows.MessageBox]::Show($Message,$Title,$Options,$Type)
    # Note, the return codes are either as follows: None, OK, Cancel, Abort, Retry, Ignore, Yes, No

    <#
        $StatusListBox.Items.Clear()
        $StatusListBox.Items.Add("$($Message):  Error")
        #Removed For Testing#$ResultsListBox.Items.Clear()
        $ResultsListBox.Items.Add("Error:  No hostname/IP selected")
        $ResultsListBox.Items.Add("        Make sure to checkbox only one hostname/IP")
        $ResultsListBox.Items.Add("        Selecting a Category will not allow you to connect to multiple hosts")
    #>
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUgJaGtuLv/EooyVaiDHWv4fCr
# W3qgggM6MIIDNjCCAh6gAwIBAgIQeugH5LewQKBKT6dPXhQ7sDANBgkqhkiG9w0B
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
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUz0+tzmzR9HfmKneScdg9d1JH/3AwDQYJKoZI
# hvcNAQEBBQAEggEAP4TYEPtgXraLe8wqF2DIGVULSJwtL/xd6Py5dewvAJGlIMHd
# 8LEic6j9PBV30i/JADpBc5LuFLx4gpSx72/sQuX0NuM5xfjrg66xJe0ONrBIh52/
# 9LgtMRddLpmm1akTI1raBkPlwSMuYw6d1C9mhFxuPoiw9CfLohGjtmbvLAFakcnI
# OTlhIJWnxzOIEcwCQ85zH1Dy78AOgARepJ8KPb9FcljMWWW+Sz9gMhx4xpjwlgz2
# MlXanO+MUSZJ3RzgwpEkqnqmnSngbEZpLS8uGvQu+Gfbe+p6Z6mrDJCtaj5/SBUb
# o/W6ztsV47gQeIlvyZ3JNaRlyQcC87kVzaH6ZA==
# SIG # End signature block
