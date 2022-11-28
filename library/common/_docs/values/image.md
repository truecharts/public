# Image

## Key: image

- Type: `dict`
- Default:

  ```yaml
  image:
    repository: repo
    tag: tag
    pullPolicy: IfNotPresent
  ```

- Helm Template: ❌

`image` key contains info regarding the container image that will be used

Example:

```yaml
image:
  repository: nginx
  tag: 1.16
  pullPolicy: IfNotPresents
```

## Key: imageSelector

- Type: `string`
- Default: `""`
- Helm Template: ❌

`imageSelector` key is used for apps/charts that have multiple image variations.
Example, an app that has different image for CPU and GPU workloads.

This key should contain an name of a `dict` constructed similar to `image`.
If defined `image` is ignored and the defined `dict` is used.

In the below example the gpu image will be used when `imageSelector` is defined,
otherwise it will default to the `image`, which is the cpu image.
Example:

```yaml
image:
  repository: app/repository
  tag: cpu-v1
  pullPolicy: IfNotPresents

gpuImage:
  repository: app/repository
  tag: gpu-v1
  pullPolicy: IfNotPresents

imageSelector: gpuImage
```

<!-- TODO: Add link to k8s docs -->
