# Se connecter avec User UPN
Connect-IPPSSession -UserPrincipalName mhebert@klabmtl.ca 

# TARGET =>
#   DLP Policy:
#       Canada PII (EXO, SPO, ODB & Teams dans une policy)
#           DLP Rule:
#               - ExternalShare
Get-DlpCompliancePolicy
Get-DlpCompliancePolicy -Identity "Canada PII"

Get-DlpComplianceRule -Policy "Canada PII"
Get-DlpComplianceRule -Identity "ExternalShare"


# Aller chercher AdvancedRule dans la Rule et sauvegarder en JSON
$Rule = Get-DlpComplianceRule -Identity "ExternalShare"
$AdvancedRule = $Rule.AdvancedRule
$AdvancedRule > AdvancedRule.json


# Lister les SITs, filtrer sur ceux creer par l'organisation
Get-DlpSensitiveInformationType
Get-DlpSensitiveInformationType | Where-Object { $_.Publisher -eq "K-laboratory" }
Get-DlpSensitiveInformationType -Identity "NAS by DataShieldDivine"


# Update DLP rule
$Data = Get-Content `
    -Path "C:\Users\marc-antoinehebert\Downloads\road-to-builder\micro-projects\purview\DLP\Rule\AdvancedRule\Canada PII\ExternalShare.json" `
    -ReadCount 0
$String = $Data | Out-string
Set-DLPComplianceRule -Identity "ExternalShare" `
    -AdvancedRule $String


# Creer une nouvelle DLP policy
New-DlpCompliancePolicy -Name "Canada PII" `
    -Mode TestWithoutNotifications `
    -ExchangeLocation All `
    -SharePointLocation All `
    -OneDriveLocation All `
    -TeamsLocation All


# Creer une nouvelle DLP rule
$Data = Get-Content `
    -Path "C:\Users\marc-antoinehebert\Downloads\road-to-builder\micro-projects\purview\DLP\Rule\AdvancedRule\Canada PII\ExternalShare.json" `
    -ReadCount 0
$String = $Data | Out-string
New-DLPComplianceRule -Name "ExternalShare" `
    -Policy "Canada PII" `
    -AdvancedRule $String



<#
.SYNOPSIS
    Fournit une brève description de ce que fait la fonction.
    (Maximum une ligne)

.DESCRIPTION
    Fournit une description détaillée de la fonction, y compris son but,
    son fonctionnement, et potentiellement des exemples d'utilisation plus complexes.
    Peut s'étendre sur plusieurs lignes.

.PARAMETER NomDuParamètre1
    Décrit le premier paramètre, son rôle, s'il est obligatoire ou optionnel,
    et les valeurs qu'il accepte.

.PARAMETER NomDuParamètre2
    Décrit le deuxième paramètre, et ainsi de suite pour tous les paramètres.

.EXAMPLE
    Get-MonExemple -Nom "Valeur" -Option $true
    Décrit comment utiliser la fonction avec des exemples concrets.
    Peut inclure plusieurs exemples montrant différentes utilisations.

.NOTES
    Auteur      : Votre Nom
    Date        : AAAA-MM-JJ
    Version     : 1.0
    Informations supplémentaires ou remarques importantes.
#>

function Get-Something {
    [CmdletBinding()] # La fonction hérite automatiquement de certains paramètres communs que la plupart des cmdlets PowerShell prennent en charge ex. -Verbose
    param(
        [Parameter()] # Cet attribut indique que $Var1 est un paramètre de la fonction. Rend $Var1 accessible lorsque vous appelez la fonction ex. Get-Something -Var1 "blablabla"
        [string]$Var1,

        [Parameter()]
        [int]$Var2

        [Parameter()]
        [ValidateSet("valeur1", "valeur2")]
        [string]$Var3
    )

    # Différentes commandes pour afficher des informations à l'utilisateur
    Write-Host "Hello World!"
    Write-Warning "Le nom est obligatoire."
    Write-Error
    Write-Verbose

    Read-Host # Demande input à l'utilisateur
