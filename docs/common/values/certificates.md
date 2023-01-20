# Certificates

## Key: scaleCerts

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - certPath: ✅
  - keyPath: ✅

Can be defined in:

- `.Values`.scaleCerts

---

Before taking any action, it will check if middleware have populated
the `ixCertificates` list, and that the `id` is included.

For every item it will create a secret containing
the certificate and the private key.

Optionally, you can mount certificate, private key or both in the
container as files.

Examples:

```yaml
scaleCerts:
  some_cert_name:
    # ID Comes from the definitions on the GUI
    id: 1
    # Optional, Override Name
    nameOverride: name_override
    # Optional, If populated, it will mount the certificate in the container's path
    certPath: /some/path/in/the/container/crt.key
    # Optional, If populated, it will mount the private key in the container's path
    keyPath: /some/path/in/the/container/key.key
    # Optional, Allow the use of revoked certs, even if is not allowed globally
    useRevoked: false
    # Optional, Allow the use of expired certs, even if is not allowed globally
    useExpired: false
```

---
---

## Key: scaleCertsList

Info:

- Type: `list`
- Default: `[]`
- Helm Template:
  - certPath: ✅
  - keyPath: ✅

Can be defined in:

- `.Values`.scaleCertsList

---

Anything that applies to `scaleCerts` applies here too.

The only difference is that this is a `list` instead of `dict`

This list can used for Scale GUI as it's easier to build lists.

Example:

```yaml
scaleCertsList:
  - name: some_cert_name
    id: 1
    # Optional
    nameOverride: name_override
    # Optional
    certPath:
    # Optional
    keyPath:
    # Optional
    useRevoked: false
    # Optional
    useExpired: false
```
