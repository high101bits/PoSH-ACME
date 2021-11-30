<#
.Description
    An empty site is generally not recommended. The term describes a site without any Domain Controllers.
    A site of this sort has two possible reasons for existing � Microsoft SCCM product used for software
    distribution and other management tools to help identify something in Active directory for end users
    or application use. In general this isn�t an issue, but if they are not needed, removing them is a
    good practice. Less for Active directory to replicated to existing Domain Controllers in other sites.
#>

$DomainControllers = (Get-ADDomainController -Filter *).Name
Foreach ($DomainController in $DomainControllers) {
    # Set up variables for the loop:
    $Query = $True
    $AutoGenerated = $Null

    # Get a list of links for this Domain Controller:
    Try {
        $Links = Get-ADReplicationConnection -Server $DomainController -ErrorAction STOP
    } Catch {
        Write-host 'Failed - Unable to query links.' -ForegroundColor Red
        $Query = $False
    }

    # Check each set of links to analyze the ones for each Domain Controller:
    If ($Query) {
        Foreach ($Line in $Links) {
            # Fix Values
            $Name = $Line.Name
            $Autogenerated= $Line.Autogenerated
            $ReplicateFromDirectoryServer = $Line.ReplicateFromDirectoryServer
            $ReplicateToDirectoryServer = $Line.ReplicateToDirectoryServer
            $FromLarge = $ReplicateFromDirectoryServer.Split(',')[1]
            $ToLarge = $ReplicateToDirectoryServer.Split(',')[0]
            $FinalFrom = $FromLarge.Split('=')[1]
            $FinalTo = $ToLarge.Split('=')[1]
            $SiteLarge = $Line.DistinguishedName.Split(',')[4]
            $Site = $SiteLarge.Split('=')[1]
            $Row = "$DomainController,$Site,$Name,$Autogenerated,$FinalFrom,$FinalTo" | Out-File $ADReplicationConnectionDestination -Append
        }
    } Else {
        Write-host '  Domain Controller with no Links found - ' -ForegroundColor White -NoNewline
        Write-Host "$DomainController" -ForegroundColor Yellow -NoNewline
        Write-Host ' - is this Domain Controller needed?' -ForegroundColor White
        $Row = "$DomainController,NoLink,,,," | Out-File $ADReplicationConnectionDestination -Append
    }
}


# SIG # Begin signature block
# MIIFuAYJKoZIhvcNAQcCoIIFqTCCBaUCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUGX0fFOA6g0AZaMyNNiRE9Hkz
# WuWgggM6MIIDNjCCAh6gAwIBAgIQVnYuiASKXo9Gly5kJ70InDANBgkqhkiG9w0B
# AQUFADAzMTEwLwYDVQQDDChQb1NoLUVhc3lXaW4gQnkgRGFuIEtvbW5pY2sgKGhp
# Z2gxMDFicm8pMB4XDTIxMTEyOTIzNDA0NFoXDTMxMTEyOTIzNTA0M1owMzExMC8G
# A1UEAwwoUG9TaC1FYXN5V2luIEJ5IERhbiBLb21uaWNrIChoaWdoMTAxYnJvKTCC
# ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANUnnNeIFC/eQ11BjDFsIHp1
# 2HkKgnRRV07Kqsl4/fibnbOclptJbeKBDQT3iG5csb31s9NippKfzZmXfi69gGE6
# v/L3X4Zb/10SJdFLstfT5oUD7UdiOcfcNDEiD+8OpZx4BWl5SNWuSv0wHnDSIyr1
# 2M0oqbq6WA2FqO3ETpdhkK22N3C7o+U2LeuYrGxWOi1evhIHlnRodVSYcakmXIYh
# pnrWeuuaQk+b5fcWEPClpscI5WiQh2aohWcjSlojsR+TiWG/6T5wKFxSJRf6+exu
# C0nhKbyoY88X3y/6qCBqP6VTK4C04tey5z4Ux4ibuTDDePqH5WpRFMo9Vie1nVkC
# AwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0G
# A1UdDgQWBBS2KLS0Frf3zyJTbQ4WsZXtnB9SFDANBgkqhkiG9w0BAQUFAAOCAQEA
# s/TfP54uPmv+yGI7wnusq3Y8qIgFpXhQ4K6MmnTUpZjbGc4K3DRJyFKjQf8MjtZP
# s7CxvS45qLVrYPqnWWV0T5NjtOdxoyBjAvR/Mhj+DdptojVMMp2tRNPSKArdyOv6
# +yHneg5PYhsYjfblzEtZ1pfhQXmUZo/rW2g6iCOlxsUDr4ZPEEVzpVUQPYzmEn6B
# 7IziXWuL31E90TlgKb/JtD1s1xbAjwW0s2s1E66jnPgBA2XmcfeAJVpp8fw+OFhz
# Q4lcUVUoaMZJ3y8MfS+2Y4ggsBLEcWOK4vGWlAvD5NB6QNvouND1ku3z94XmRO8v
# bqpyXrCbeVHascGVDU3UWTGCAegwggHkAgEBMEcwMzExMC8GA1UEAwwoUG9TaC1F
# YXN5V2luIEJ5IERhbiBLb21uaWNrIChoaWdoMTAxYnJvKQIQVnYuiASKXo9Gly5k
# J70InDAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkq
# hkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGC
# NwIBFTAjBgkqhkiG9w0BCQQxFgQUfmXHc8gBq9K/J1jAyf6GtgfORogwDQYJKoZI
# hvcNAQEBBQAEggEAgr/T+XQ58plea2l/KTkEuK3Pa6PF+mCoK8JEpCGcBofHDgQq
# v0AHsQD+3Xqujle8Xs22W2Y0V0GwdxGJKYnYrTBXsNHxqyRxbd1i5WEpFLWxUKm1
# 17RYxEcydHHpaPdRMQ5dCMvfIoEplPJoxIXS47hdwpCb7fu/oOUThYFtGZJCI6lj
# 113mki9h1TX0HCrik+sLznpMg2/DGOlDfV+8u+ZsHqfDC0M8NBt9NK4Fo9rcQwmZ
# LQUtdYZUa7pT9wluWH1TbToQxBoHIO56UrAj5nChJzdRi7egplGvyzuVN54Pujuk
# bfJcRRTPjAdPXh4f/My3qTW4MmOCFKqUtm62+A==
# SIG # End signature block
