---
title: How-To
---

This is a quick how-to or setup-guide to use Bytestash on Talos.

## App Configuration

### Required Environment Settings:
The following must be specified and updated in your Helm Release file.
- `JWT_SECRET`: Provide a unique secret for the JSON Web Token

### Optional Environment Settings:
The following may be left at the default setting, OR you may override in your Helm Release file dependent on your requirements.
- `BASE_PATH`: write /bytestash for a domain such as my.domain/bytestash, leave blank in every other case
- `TOKEN_EXPIRY`: How long the token lasts Default is 24 hrs.
- `ALLOW_NEW_ACCOUNTS`: Will the instance allow new new accounts to be created. The Default is to allow new account creation.
- `DEBUG`: Enable to turn on logging, in most instances leave disabled
- `DISABLE_ACCOUNTS`: Disable the use of any accounts, export snippets first if enabling on an existing instance, as it will be like starting with a fresh instance. Default is false.
- `DISABLE_INTERNAL_ACCOUNTS`: Disable the use of internal accounts. Default is false.

### OIDC Single Sign On
Setting up the OIDC section will allow you to enable Single Sign On (SSO).
- `OIDC_ENABLED`: Set this to true to enable SSO. The default is for SSO - OIDC to be disabled.
- `OIDC_DISPLAY_NAME`: Enter the Display Name for users signing in with SSO, the default is set to Single Sign-on
- `OIDC_ISSUER_URL`: Enter the OIDC issuer URL,  e.g. https://authentik.mydomain.com/application/o/bytestash/ for authentik
- `OIDC_CLIENT_ID`:  Enter the OIDC client ID, the SSO app provider will provide this
- `OIDC_CLIENT_SECRET`: Enter the OIDC client secret, the SSO app provider will provide this
- `OIDC_SCOPES`: The OIDC scopes to request, e.g. "openid profile email groups"
