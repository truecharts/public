---
title: Authelia Rules
---

This is a collection of some common Authelia Rules.

:::note[RULE ORDER]

It is important that rules are created in the correct order in Authelia. Rules are processed from top to bottom with the first matching rule being applied. The most narrow rules should be applied first with the most broad rules last.

:::

:::note[DEFAULT POLICY]

For these rules to work as intended, your default access control policy must be set to `deny`.

:::

All rules requiring Authelia authentication were configured with `two_factor` (2FA). If you do not want 2FA on some or all rules replace the Policy with `one_factor`.

In this guide we assume you have a group `admin` and a group `user` in LDAP.
Members of the `admin` group will have access to everything.
Members of the `user` group will only have access to a select set of apps you choose.

## API Rule

This rule will bypass Authelia for API level access in most apps. This should always be your first rule.

```yaml
// values.yaml
- domain: "*.example.com"
  policy: bypass
  resources:
  - "^/api([/?].*)?$"
  - "^/api([/?].*)?$"
  - "^/identity.*$"
  - "^/triggers.*$"
  - "^/meshagents.*$"
  - "^/meshsettings.*$"
  - "^/agent.*$"
  - "^/control.*$"
  - "^/meshrelay.*$"
  - "^/wl.*$"
```

## Vaultwarden

This rule will allow users of the `admin` group to access the Vaultwarden admin page and bypass Authelia when accessing the webportal as auth is already provided by vaultwarden.

```yaml
// values.yaml
- domain: "vaultwarden.example.com"
  policy: two_factor
  subject: group:admin
  resources: "^*/admin.*$"
- domain: "vaultwarden.example.com"
  policy: deny
  resources: "^*/admin.*$"
- domain: "vaultwarden.example.com"
  policy: bypass
```

## User Rule

This rule will allow users in the `user` group access to only the specified applications.

```yaml
// values.yaml
- domain:
  - "jellyfin.example.com"
  - "nextcloud.example.com"
  - "whateveryouwant.example.com"
  policy: two_factor
  subject: group:user
```

## Catch All Rule

This rule will give access to everything to users of the `admin` group.

```yaml
// values.yaml
- domain:
  - "example.com"
  - "*.example.com"
  policy: two_factor
  subject: group:admin
```
