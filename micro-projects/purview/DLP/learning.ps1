# Se connecter avec User UPN
Connect-IPPSSession -UserPrincipalName mhebert@klabmtl.ca 

# TARGET =>
#DLP Policy:
#   Canada PII (EXO, SPO, ODB & Teams dans une policy)
#       DLP Rule:
#           - ExternalShare

Get-DlpCompliancePolicy
Get-DlpCompliancePolicy -Identity "Canada PII"

Get-DlpComplianceRule -Policy "Canada PII"
Get-DlpComplianceRule -Identity "ExternalShare"

# 2 variables + output txt file
$ExternalShare = Get-DlpComplianceRule -Identity "ExternalShare"
$ExternalShareAdvancedRule = Get-DlpComplianceRule -Identity "ExternalShare" | fl AdvancedRule
$ExternalShareAdvancedRule > ExternalShareAdvancedRule.json


Get-DlpSensitiveInformationType
Get-DlpSensitiveInformationType | Where-Object { $_.Publisher -eq "K-laboratory" }
Get-DlpSensitiveInformationType -Identity "NAS by DataShieldDivine"


# Update DLP rule
$data = Get-Content -Path "C:\Users\marc-antoinehebert\Downloads\road-to-builder\micro-projects\purview\DLP\Rule\AdvancedRule\Canada PII\ExternalShare.json" -ReadCount 0
$AdvancedRuleString = $data | Out-string
Set-DLPComplianceRule -Identity "ExternalShare" -AdvancedRule $AdvancedRuleString

