# Installation instructions

In both Native Helm and TrueNAS Scale, keys that start with `_` are **unset**.

## Configuration

### TrueNAS Scale

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

::: note

When you make a change in the UI, you need to manually stop and re-start the app
for the change to take effect.

:::

For SCALE users, you can add additional configuration options that are not exposed in the UI
by using the `Additional Frigate Configuration` section.

::: tip

However, if you think an option would be used by a lot of users, it would be best to ask us to expose it.

:::

For example to set this:

```yaml
detectors:
  coral:
    type: edgetpu
```

Set like this:

- Key: `detectors.coral.type`
- Value: `edgetpu`

For lists:

```yaml
ffmpeg:
  hwaccel_args:
    - arg1
    - arg2
```

Set like this:

- Key: `ffmpeg.hwaccel_args`
- Value: `[ "arg1", "arg2" ]`

::: warn

Please use the exact casing as in the [Frigate Configuration Reference](https://docs.frigate.video/configuration/index).

:::

### Native Helm

Native Helm users just add any yaml formatted config under `.Values.frigate` key.

## Hardcoded values

We hardcoded some values, so the chart/app can work correctly based on how it's written.
Those values are:

```yaml
database:
  path: /db/frigate.db
```
