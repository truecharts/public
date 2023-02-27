{{- define "tc.v1.common.class.cnpg.pooler" -}}
  {{- $values := .Values.cnpg -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.cnpg -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $cnpgClusterName := $values.name -}}
  {{- $cnpgName := $values.cnpgName -}}
  {{- $cnpgPoolerName := $values.poolerName -}}
  {{- $cnpgClusterLabels := $values.labels -}}
  {{- $cnpgClusterAnnotations := $values.annotations }}

---
apiVersion: {{ include "tc.v1.common.capabilities.cnpg.pooler.apiVersion" $ }}
kind: Pooler
metadata:
  name: {{ printf "%v-%v" $cnpgClusterName $values.pooler.type }}
spec:
  cluster:
    name: {{ $cnpgClusterName }}

  instances: {{ $values.pooler.instances | default 2 }}
  type: {{ $values.pooler.type }}
  pgbouncer:
    poolMode: session
    parameters:
      max_client_conn: "1000"
      default_pool_size: "10"

{{- end -}}
