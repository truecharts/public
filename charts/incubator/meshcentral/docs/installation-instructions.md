# Installation instructions

:::warn

Ingress for this chart is **required**

:::

In order to be able to expose some options in the GUI,
but also give users the option to users to **unset** those values,
instead of using our defaults. We decided to do the following.

We will **unset** every option (key) that has:

- Stings: Empty (`"`) value.
- Arrays: Empty (`[]`) arrays.
- Int: Value of `-99`.
  (That's because both `0` and `-1` is valid values on some options
  and empty int are not possible (at least now) in TrueNAS Scale GUI)

The above will only be applied when installed in TrueNAS Scale as an App

Native Helm users won't be affected with the above.

In both Native Helm and TrueNAS Scale, keys that start with `_` are **unset**.

For SCALE users, you can add additional configuration options that are not exposed in the UI
by using the `Additional MeshCentral Configuration` section.

::: tip

However, if you think an option would be used by a lot of users, it would be best to ask us to expose it.

:::

For example to set this:

```json
"settings": {
  "sms": {
    "provider": "twillio"
  }
}
```

Set like this:

- Key: `settigns.sms.provider`
- Value: `twillio`

For lists:

```json
"domains": {
  "": {
    "newAccoutnsRights": [
      "item1",
      "item2"
    ]
  }
}
```

Set like this:

- Key: `domains."".newAccountsRights`
- Value: `[ "item1", "item2" ]`

::: warn

Please use the exact casing as in the [MeshCentral's json schema](https://github.com/Ylianst/MeshCentral/blob/master/meshcentral-config-schema.json).

:::
