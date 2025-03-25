import requests
import re

#!/usr/bin/env python3

def get_tenant_id_from_domain(domain):
    url = f'https://login.microsoftonline.com/{domain}/v2.0/.well-known/openid-configuration'
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()
        issuer = data.get('issuer', '')
        
        # L'issuer ressemble à : https://login.microsoftonline.com/{tenant_id}/v2.0
        match = re.search(r'https://login\.microsoftonline\.com/([a-f0-9-]+)/', issuer)
        if match:
            tenant_id = match.group(1)
            print(f"✅ Le tenant ID du domain {domain} est : {tenant_id}")
            return tenant_id
        else:
            print("❌ Impossible d'extraire le tenant ID depuis l'issuer.")
    else:
        print(f"❌ Erreur HTTP ({response.status_code}) pour le domaine {domain}")

    return None


client_domain = 'klabmtl.ca'  # Remplace par le domaine du client
tenant_id = get_tenant_id_from_domain(client_domain)
