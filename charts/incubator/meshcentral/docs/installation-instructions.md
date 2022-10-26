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
