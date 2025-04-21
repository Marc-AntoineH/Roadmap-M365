# function Get-PolicyLocations {
#     [CmdletBinding()]
#     param()
    
#     $locations = @{}
    
#     Write-Host "`nEmplacements à inclure (Oui/Non):"
#     $locations.Exchange = (Read-Host "Exchange Online (O/N)").ToUpper() -eq "O"
#     $locations.SharePoint = (Read-Host "SharePoint (O/N)").ToUpper() -eq "O"
#     $locations.OneDrive = (Read-Host "OneDrive (O/N)").ToUpper() -eq "O"
#     $locations.Teams = (Read-Host "Teams (O/N)").ToUpper() -eq "O"
#     $locations.Endpoint = (Read-Host "Endpoint (O/N)").ToUpper() -eq "O"
    
#     return $locations
# }


### REFACTOR
function Get-PolicyLocations {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet("O", "N")]
        [string]$Exchange,

        [Parameter()]
        [ValidateSet("O", "N")]
        [string]$SharePoint,

        [Parameter()]
        [ValidateSet("O", "N")]
        [string]$OneDrive,

        [Parameter()]
        [ValidateSet("O", "N")]
        [string]$Teams,

        [Parameter()]
        [ValidateSet("O", "N")]
        [string]$Endpoint
    )

    Write-Host "`n--- CONFIGURATION DES EMPLACEMENTS DE LA POLITIQUE DLP ---" -ForegroundColor Cyan
    Write-Host "`nVeuillez saisir O pour Oui ou N pour Non."

    $locations = @{}

    # Fonction interne pour lire une entrée validée (O/N)
    function Read-ONInput {
        param(
            [string]$prompt,
            [string]$parameterName
        )
        while (-not $PSBoundParameters.ContainsKey($parameterName)) {
            $input = (Read-Host "$prompt (O/N)").ToUpper()
            if ($input -in "O", "N") {
                $PSBoundParameters[$parameterName] = $input
            } else {
                Write-Warning "Entrée invalide. Veuillez saisir O pour Oui ou N pour Non."
            }
        }
        return ($PSBoundParameters[$parameterName] -ceq "O")
    }

    $locations.Exchange = Read-ONInput "Exchange Online" "Exchange"
    $locations.SharePoint = Read-ONInput "SharePoint" "SharePoint"
    $locations.OneDrive = Read-ONInput "OneDrive" "OneDrive"
    $locations.Teams = Read-ONInput "Teams" "Teams"
    $locations.Endpoint = Read-ONInput "Endpoint" "Endpoint"

    return $locations
}





