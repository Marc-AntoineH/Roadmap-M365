# function Get-PolicyMode {
#     [CmdletBinding()]
#     param()
    
#     $modeOptions = @("Enable", "TestWithNotifications", "TestWithoutNotifications", "Disable")
#     $modeIndex = 0
#     do {
#         Write-Host "`nMode de la politique:"
#         for ($i = 0; $i -lt $modeOptions.Count; $i++) {
#             Write-Host "[$i] $($modeOptions[$i])"
#         }
#         $modeIndex = Read-Host "Choisissez le mode (0-3)"
#     } while ($modeIndex -lt 0 -or $modeIndex -gt 3)
    
#     return $modeOptions[$modeIndex]
# }


### REFACTOR
function Get-PolicyMode {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet("Enable", "TestWithNotifications", "TestWithoutNotifications", "Disable")]
        $PolicyMode
    )

    if (-not $PolicyMode) {
        Write-Host "`nSélectionnez le mode de la politique :"
        $modeOptionsValidateSet = "Enable", "TestWithNotifications", "TestWithoutNotifications", "Disable"
        $modeOptionsDisplay = "Enable", "Test With Notifications", "Test Without Notifications", "Disable"
        for ($i = 0; $i -lt $modeOptionsDisplay.Count; $i++) {
            Write-Host " [$i] $($modeOptionsDisplay[$i])"
        }
        while ($true) {
            $selectedIndex = Read-Host "Entrez le numéro correspondant au mode"
            if ($selectedIndex -as [int] -ge 0 -and $selectedIndex -lt $modeOptionsValidateSet.Count) {
                return $modeOptionsValidateSet[$selectedIndex]
                break
            } else {
                Write-Warning "Choix invalide. Veuillez entrer un nombre entre 0 et $($modeOptionsValidateSet.Count - 1)."
            }
        }
    } else {
        return $PolicyMode
    }
}