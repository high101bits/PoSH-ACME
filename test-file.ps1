
function test-echo {
    param($word)
    Write-host "  ==========  "
    Write-Host "I'm going to echo $word!"
    Write-host "  ==========  "
}

function test-repeat {
    param($word)
    Write-host "  ==========  "
    Write-Host "$word $word $word $word $word!"
    Write-host "  ==========  "
}


