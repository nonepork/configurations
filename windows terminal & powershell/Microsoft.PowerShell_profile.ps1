# -- Initialization --

#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/emodipt-extend-transient.omp.json" | Invoke-Expression
$omp_file = Join-Path $PSScriptRoot "./themes/amro.omp.json"
oh-my-posh init pwsh --config $omp_file | Invoke-Expression

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
  Import-Module "$ChocolateyProfile"
}

Import-Module -Name Terminal-Icons

Invoke-Expression (& { (zoxide init powershell | Out-String) })

# -- Configuration -- 

# Let powershell use utf8 as encoding instead of utf16le
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$env:PYTHONIOENCODING='utf-8' 

# -- Function/Alias --

# For you
New-Alias -Name vim -Value nvim

function weather()
{
  Invoke-RestMethod https://wttr.in/Taiwan?0
}


function clearch()
{
  Remove-Item -path (Get-PSReadlineOption).HistorySavePath
}
