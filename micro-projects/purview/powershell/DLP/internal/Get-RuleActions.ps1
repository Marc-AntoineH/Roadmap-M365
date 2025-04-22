# function Get-RuleActions {
#     [CmdletBinding()]
#     param()
    
#     $actions = @{}
    
#     Write-Host "`nActions à configurer (Oui/Non):"
#     $actions.BlockAccess = (Read-Host "Bloquer l'accès au contenu (O/N)").ToUpper() -eq "O"
#     $actions.NotifyUser = (Read-Host "Notifier les utilisateurs (O/N)").ToUpper() -eq "O"
    
#     return $actions
# }


### REFACTOR
function Get-RuleActions {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet("O", "N")]
        [string]$BlockAccessInput,

        [Parameter()]
        [ValidateSet("O", "N")]
        [string]$NotifyUserInput
        # Ajoutez d'autres paramètres d'actions ici si nécessaire
    )

    Write-Host "`n--- CONFIGURATION DES ACTIONS DE LA RÈGLE DLP ---" -ForegroundColor Cyan
    Write-Host "`nVeuillez saisir O pour Oui ou N pour Non." -ForegroundColor Green

    $actions = @{}

    # Nested function pour gérer l'action BlockAccess
    function Get-BlockAccessAction {
        if (-not $PSBoundParameters.ContainsKey('BlockAccessInput')) {
            while ($true) {
                $blockAccessResponse = (Read-Host "Bloquer l'accès au contenu (O/N)").ToUpper()
                if ($blockAccessResponse -in "O", "N") {
                    return ($blockAccessResponse -eq "O")
                    break
                } else {
                    Write-Warning "Entrée invalide. Veuillez saisir O ou N."
                }
            }
        } else {
            return ($BlockAccessInput -eq "O")
        }
    }

    # Nested function pour gérer l'action NotifyUser
    function Get-NotifyUserAction {
        if (-not $PSBoundParameters.ContainsKey('NotifyUserInput')) {
            while ($true) {
                $notifyUserResponse = (Read-Host "Notifier les utilisateurs (O/N)").ToUpper()
                if ($notifyUserResponse -in "O", "N") {
                    return ($notifyUserResponse -eq "O")
                    break
                } else {
                    Write-Warning "Entrée invalide. Veuillez saisir O ou N."
                }
            }
        } else {
            return ($NotifyUserInput -eq "O")
        }
    }

    $actions.BlockAccess = Get-BlockAccessAction
    $actions.NotifyUser = Get-NotifyUserAction

    return $actions
}