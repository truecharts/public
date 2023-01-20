# Image

## Key: image

Info:

- Type: `dict`
- Default:

  ```yaml
  image:
    repository: repo
    tag: tag
    pullPolicy: IfNotPresent
  ```

- Helm Template: ❌

Can be defined in:

- `.Values`.image

---

Contains info regarding the container image and tag that will be used

Example:

```yaml
image:
  repository: nginx
  tag: 1.16
  pullPolicy: IfNotPresents
```

If you want define additional images use the following pattern `imageName`.

Example:

```yaml
imageName:
  repository: some-repo
  tag: some-tag
  pullPolicy: IfNotPresents
```

---
---

## Key: imageSelector

Info:

- Type: `string`
- Default: `""`
- Helm Template: ❌

Can be defined in:

- `.Values`.imageSelector
- `.Values.additionalContainers.[container-name]`.imageSelector
- `.Values.initContainers.[container-name]`.imageSelector
- `.Values.installContainers.[container-name]`.imageSelector
- `.Values.upgradeContainers.[container-name]`.imageSelector
- `.Values.systemContainers.[container-name]`.imageSelector
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.imageSelector

---

If left empty, it will fail back to `image`.

Used for apps/charts that have multiple image variations.
Example, an app that has different image for CPU and GPU workloads.

This key should contain an name of a `dict` constructed similar to `image`.

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

imageSelector: imageGPU
```

Additionally you should use the imageSelector (only) when defining
additional/init/install/upgrade/system/job containers.

Example:

```yaml
additionalContainers:
  worker:
    imageSelector: imageWorker
```

Kubernetes Documentation:

- [Images](https://kubernetes.io/docs/concepts/containers/images)
- [Pull Policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy)
