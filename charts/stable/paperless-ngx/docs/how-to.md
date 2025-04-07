---
title: Setup Guide
---

**Paperless-ngx** is an open-source document management system that transforms your physical documents into a searchable
online archive.

## Media Storage

- If you plan on importing documents into Paperless-ngx via a network share, for example from a computer or scanner, it
  is recommended to set up an `NFS Share` for the shared folder.

### Configure additional OCR languages

Paperless-ngx supports different [configuration options](https://docs.paperless-ngx.com/configuration/#ocr) to customize
how it performs OCR. The most prominent option is the language or languages used to perform OCR operations. You can skip
this section if you only expect to import documents written in English.

Per default OCR is only performed in English. Check the Paperless-ngx documentation regarding the
[`PAPERLESS_OCR_LANGUAGE` (singular)](https://docs.paperless-ngx.com/configuration/#ocr) and note what configuration
would best match your use-case. Paperless-ngx only comes with a few OCR languages pre-installed, see the
[`PAPERLESS_OCR_LANGUAGES` (plural)](https://docs.paperless-ngx.com/configuration/#docker) configuration option for more
information, and note if you need this configured too.

### Configure import share

In addition to document uploads via the Web UI, Paperless-ngx can import documents from a [consumption
directory](https://docs.paperless-ngx.com/usage/#the-consumption-directory). This would allow you to move new documents
to an NFS share from your PC or directly from your scanner and Paperless-ngx would pick
up the documents from there. See the explanation of the feature linked above and its [configuration
options](https://docs.paperless-ngx.com/configuration/#consume_config) for more information.

This guide will only describe the Paperless-ngx specific options required to set up importing documents from a network
share. Please refer to your NAS documentation.

In addition to adding the NFS share to the Paperless-ngx application we need to configure polling for the import folder.
The NFS Share do not support the default polling model Paperless-ngx uses.

## Example Values for Paperless-ngx

```yaml

workload:
  main:
    podSpec:
      containers:
        main:
          env:
            PAPERLESS_ADMIN_USER: "admin"
            PAPERLESS_ADMIN_PASSWORD: "changeme"
            PAPERLESS_ADMIN_MAIL: "admin@admin.com"
            PAPERLESS_OCR_LANGUAGE: "eng"
            PAPERLESS_OCR_LANGUAGES: "eng fra deu spa ita"
            PAPERLESS_CONSUMER_POLLING: 120
persistence:
  consume:
    type: nfs
    # Example NFS Share
    server: "192.168.0.10"
    path: "/mnt/paperless/"

```

### Configure ForwardAuth authentication

Users that have set up [Traefik with ForwardAuth, for example with Authelia](/charts/stable/authelia/setup-guide/)
can take advantage of authentication through Authelia for their Paperless-ngx installation. Paperless-ngx will honour
logins passed from Authelia but not the e-mail address nor the groups of the logged-in user, those will be internal to
Paperless-ngx and separate from those in Authelia. ForwardAuth can be added to an existing Paperless-ngx installation as
long as the logins of Authelia users match the logins of Paperless-ngx users.

This guide will only describe the Paperless-ngx specific options required to set up ForwardAuth. Please refer to the
[Traefik + Authelia ForwardAuth setup guide](/charts/stable/authelia/setup-guide/) on how to prepare ForwardAuth.

Once you have set up ForwardAuth in your Traefik installation, configure ForwardAuth in Paperless-ngx as follows:

  - Add the following environment variables in the values for paperless.
  - Enter `PAPERLESS_ENABLE_HTTP_REMOTE_USER` and set its value to true, and
  - `PAPERLESS_LOGOUT_REDIRECT_URL` and your logout URL (`https://auth.mydomain.com/logout` as per the above guide's example domain) in the second box.

This will reconfigure and restart Paperless-ngx. Authentication to
your Paperless-ngx installation will be handled by Authelia now. Those options can be removed at any time,
authentication to your Paperless-ngx installation will then revert to the Paperless-ngx built-in authentication
mechanism.

## Where to go from here?

Paperless-ngx offers a helpful [best practices guide](https://docs.paperless-ngx.com/usage/#basic-searching) as a
starting point, as well as a recommended workflow a little further along on that same page.
