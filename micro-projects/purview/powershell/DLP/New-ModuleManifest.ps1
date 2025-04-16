# Supprimer le .psd1 puis lancer ce script.

New-ModuleManifest -Path ".\Dlp.psd1" `
  -RootModule "Dlp.psm1" `
  -Author "Marc-Antoine Hebert" `
  -Description "Module pour la création et gestion de politiques DLP" `
  -ModuleVersion "1.0.0" `
  -FunctionsToExport @(
    'Get-PolicyBasicInfo',
    'Get-PolicyMode',
    'Get-PolicyLocations',
    'Get-RuleBasicInfo',
    'Get-SensitiveInfoTypes',
    'Get-RuleMinimumCount',
    'Get-RuleActions',
    'Build-PolicyParameters',
    'Build-RuleParameters',
    'Show-ConfigurationSummary',
    'Deploy-DlpPolicy',
    'New-CompleteDlpPolicy'
  )