---
title: Authelia + LLDAP + Traefik ForwardAuth Setup guide
---

This quick guide should take you through the steps necessary to setup `Authelia` as your `forwardAuth` for `Traefik`. We'll be using `LLDAP` as the backend for `Authelia` since it's lightweight and simple enough for most users.

## Setup LLDAP

:::caution

LLDAP is a `stable` train chart and therefore isn't supported at the same level as the charts in the `premium` train (Authelia and Traefik).

:::

- Follow the easy steps included in the [Installation Notes](/charts/stable/lldap/installation-notes) for [LLDAP](/charts/stable/lldap/). Change `dc=example,dc=com` to your domain, i.e. `dc=MYDOMAIN,dc=net` and then change your password.

- Once in `LLDAP`, create a user inside the `lldap_password_manager` group and change your default `admin` password. That `lldap_password_manager` user will be used to bind to `Authelia`. Here I've created a user called `manager`, but you can use anything

- Create an `admin` group and add `User` to it. We will allow users of this group to access the site with Authelia later in the guide. Don't confuse with the pre-configured group `lldap_admin`, which should not be used to add `User`

## Setup Authelia

- The setup for Authelia is very specific and the logs won't tell you where you've messed up, but there's precise steps used to integrate `LLDAP` into `Authelia`.

```yaml
// values.yaml
# your domain
domain: example.com
# autehlia ingress url
default_redirection_url: https://auth.example.com
authentication_backend:
  # lldap setup
  ldap:
    enabled: true
    implementation: custom
    # if name is not lldap update as needed
    url: ldap://lldap-ldap.lldap.svc.cluster.local:3890
    # replace with your domain
    base_dn: DC=example,DC=com
    username_attribute: uid
    additional_users_dn: ou=people
    users_filter: (&(|({username_attribute}={input})({mail_attribute}={input}))(objectClass=person))
    additional_groups_dn: ou=groups
    groups_filter: (member={dn})
    group_name_attribute: cn
    mail_attribute: mail
    display_name_attribute: displayName
    # user with lldap_password_manager group
    user: uid=manager,ou=people,dc=example,dc=com
    # above user password in plain text
    plain_password: somepassword
  file:
    enabled: false
notifier:
  # smtp setup (example is gmail)
  smtp:
    enabled: true
    host: smtp.gmail.com
    port: 587
    # gmail email address (username)
    username: email@gmail.com
    # use a google app password if using gmail
    plain_password: somepassword
    # email address to show as sender
    sender: no-reply@example.com
  filesystem:
    enabled: false
access_control:
  rules:
    # basic rule for one factor (username/password) login for users in the admin group
    - domain:
      - "*.example.com"
      - example.com
      policy: one_factor
      subject: "group:admin"
```

Please see [Authelia Rules](./authelia-rules) for more advanced rules.

### Setup Authelia Ingress

- Make sure you're using the same domain as the `Default Redirection URL` above, so for me that's `auth.mydomain.com`

```yaml
// values.yaml
ingress:
  main:
    enabled: true
    integrations:
      traefik:
        enabled: true
      certManager:
        enabled: true
        certificateIssuer: domain-0-le-prod
    hosts:
      - host: auth.example.com
```

## Traefik ForwardAuth Setup

- This part is straight forward as long as you have a working `Traefik` install.

- The following is added to `Traefik` `values.yaml`,

```yaml
// values.yaml
middlewares:
  forwardAuth:
    - name: auth
      address: http://authelia.authelia.svc.cluster.local:9091/api/verify?rd=https://auth.example.com/
      authResponseHeaders:
        - Remote-User
        - Remote-Group
        - Remote-Name
        - Remote-Email
      trustForwardHeader: true
```

### Adding the forwardauth to your Apps

The last step is adding the `forwardauth` along with the standard `ingress` settings for your app, for more info on setting ingress see the [ClusterIssuer Guide](/charts/premium/clusterissuer/how-to).

- In this example we use the same name as above, or `auth`.

```yaml
// values.yaml
ingress:
  main:
    enabled: true
    integrations:
      traefik:
        enabled: true
        middlewares:
          - name: auth
            namespace: traefik
      certManager:
        enabled: true
        certificateIssuer: domain-0-le-prod
    hosts:
      - host: radarr.example.com
```

### References

The origin material for this guide is available on the [LLDAP Github](https://github.com/lldap/lldap). While further information on Authelia can be found on their [Github](https://github.com/authelia/authelia) and [website](https://www.authelia.com/).

### Support

If you have any issues with following this guide, we can be reached using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support.
