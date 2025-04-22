# function Get-RuleBasicInfo {
#     [CmdletBinding()]
#     param()
    
#     Write-Host "`n--- CRÉATION DE LA RÈGLE DLP ---" -ForegroundColor Yellow
#     return Read-Host "Nom de la règle DLP"
# }


### REFACTOR
function Get-RuleBasicInfo {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Name,

        [Parameter()]
        [string]$Comment
    )

    Write-Host "`n--- CRÉATION DE LA RÈGLE DLP ---" -ForegroundColor Cyan

    $ruleInfo = @{}

    # Demander le nom une première fois en dehors de la boucle
    if ([string]::IsNullOrWhiteSpace($Name)) {
        $Name = Read-Host "Nom de la règle DLP (obligatoire)"
    }

    # Boucle pour la validation si le nom est toujours vide après la première entré
    while ([string]::IsNullOrWhiteSpace($Name)) {
        Write-Warning "Le nom de la règle est obligatoire. Veuillez saisir un nom."
        $Name = Read-Host "Nom de la règle DLP (obligatoire)"
    }


    $ruleInfo.Name = $Name
    $ruleInfo.Comment = Read-Host "Description de la règle (facultatif)"

    return $ruleInfo
    Write-Host "- Nom: $($RuleInfo.Name)"
    Write-Host "- Description: $($RuleInfo.Comment)"
}