---
title: Authelia Setup
---

Authelia which is available in the premium train can act as the authentication provider for your apps and services either through OAuth or forward authentication. LLDAP can be used to manage your Authelia users and groups. To enable this as an option follow the steps outlined below. References to the specific questions as they appear in the TrueNAS SCALE UI are included in the guide and highlighted along with the answers you should use. Authelia is the recommended authentication provider for TrueCharts however you can use any other provider you wish for Authentik is available in the Stable train.

This guide has been written as LLDAP has specific requirements for the LDAP setup of Authelia. If you are using another LDAP provider you will need to follow the setup instructions for that provider.

> **Disclaimer:** This guide only covers the LDAP setup of Authelia. Refer to other guides for the remaining setup of Authelia.

## Setup instructions

1. Tick the box for `LDAP backend configuration` a further set of questions will then appear.
2. The dropdown `Implementation` should be set as `custom`
3. URL should be set to internally link back to your LLDAP instance for the default configuration it should look something like this, `ldap://lldap-ldap.ix-lldap.svc.cluster.local:3890`. This will need to be adapted if you have named LLDAP differently or used a different port for LDAP.
4. Next, set the `Base DN`. This is one of the configurable options you set when installing LLDAP, which by default is `dc=example,dc=com` and should be adapted to your domain if set.
5. The `Username Attribute` should be set to `uid`.
6. The `Additional Users DN` should be set to `ou=people`, as this is where all your users are stored.
7. The users filter can be set to one of two options depending on whether you want to allow sign-in with a username or both username and email. Both options are outlined below.

   **Username only**

   ```shell
   (&({username_attribute}={input})(objectClass=person))
   ```

   **Username and email**

   ```shell
   (&(|({username_attribute}={input})({mail_attribute}={input}))(objectClass=person))
   ```

8. The next option that needs setting is `Additional Groups DN`. It must be set to `ou=groups`, as this is where all your groups are stored.
9. LLDAP only supports only one filter, which should be set in `Groups Filter` and set to `(member={dn})`.
10. The `Group name Attribute` should be set to `cn`.
11. The `Mail Attribute` should simply be set to `mail`.
12. The `Display Name Attribute` should be set to `displayName`. This is the attribute that Authelia will use to greet users when they log in.
13. `Admin user` is the default admin user used when setting up LLDAP initially and is auto-generated for you. The entry you input into this box should look something like the one below. Change `dc=example,dc=com` to match the `Base DN` you set earlier.

    **Admin user**

    ```shell
    uid=admin,ou=people,dc=example,dc=com
    ```

14. Enter the admin user password into the `Password` field. As stated earlier, **DO NOT** use the default password.

## References

The origin material for this guide is available on the [LLDAP Github](https://github.com/lldap/lldap). While further information on Authelia can be found on their [Github](https://github.com/authelia/authelia) and [website](https://www.authelia.com/).

## Support

If you have any issues with following this guide, we can be reached using [Discord](https://discord.gg/tVsPTHWTtr) for real-time feedback and support.

---

All Rights Reserved - The TrueCharts Project
