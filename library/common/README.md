# Common Library

## Naming Scheme

- ServiceAccount:
  - Primary: `$FullName`
  - Others: `$FullName-$ServiceAccountName`
- RBAC:
  - Primary: `$FullName`
  - Others: `$FullName-$RBACName`
- Service:
  - Primary: `$FullName`
  - Others: `$FullName-$ServiceName`
- Pods:
  - Primary: `$FullName`
  - Others: `$FullName-$PodName`
- Containers: `$ContainerName`
- ConfigMap: `$FullName-$ConfigMapName`
- Secret: `$FullName-$SecretName`
- Scale Certificate: `$FullName-$CertName`
- Scale External Interface: `ix-$ReleaseName-$index`

> Full name -> `$ReleaseName-$ChartName`
> Any name that exceeds 63 characters, will throw an error
