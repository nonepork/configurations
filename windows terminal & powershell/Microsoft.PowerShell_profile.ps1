#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/emodipt-extend-transient.omp.json" | Invoke-Expression
$omp_file = Join-Path $PSScriptRoot "./themes/amro.omp.json"
oh-my-posh init pwsh --config $omp_file | Invoke-Expression

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Let powershell use utf8 as encoding instead of utf16le
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

Import-Module -Name Terminal-Icons

function weather() {
    Invoke-RestMethod https://wttr.in/Taiwan?0
}

$env:PYTHONIOENCODING='utf-8' 

function clearch() {
    Remove-Item -path (Get-PSReadlineOption).HistorySavePath
}

# For you
New-Alias -Name vim -Value nvim

# uncomment this if you're using powershell 7
# function project() {
#    Get-ChildItem 'D:\Projects\_Current Working' -Attributes Directory | Invoke-Fzf | Set-Location
# }
