# function Get-PolicyBasicInfo {
#     [CmdletBinding()]
#     param()
    
#     Write-Host "`n--- CRÉATION DE LA POLITIQUE DLP ---" -ForegroundColor Yellow
#     $policyInfo = @{}
#     $policyInfo.Name = Read-Host "Nom de la politique DLP"
#     $policyInfo.Comment = Read-Host "Description de la politique"
#     return $policyInfo
# }


### REFACTOR
function Get-PolicyBasicInfo {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Name,

        [Parameter()]
        [string]$Comment
    )

    Write-Host "`n--- CRÉATION DE LA POLITIQUE DLP ---" -ForegroundColor Cyan

    $policyInfo = @{}

    # Demander le nom une première fois en dehors de la boucle
    if ([string]::IsNullOrWhiteSpace($Name)) {
        $Name = Read-Host "Nom de la politique DLP (obligatoire)"
    }

    # Boucle pour la validation si le nom est toujours vide après la première entré
    while ([string]::IsNullOrWhiteSpace($Name)) {
        Write-Warning "Le nom de la politique est obligatoire. Veuillez saisir un nom."
        $Name = Read-Host "Nom de la politique DLP (obligatoire)"
    }

    $policyInfo.Name = $Name
    $policyInfo.Comment = Read-Host "Description de la politique (facultatif)"

    return $policyInfo
}
