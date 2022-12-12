{{- define "ix.v1.common.class.certificate" -}}
  {{- $cert := .cert -}}
  {{- $root := .root -}}

  {{- if not (hasKey $cert "id") -}}
    {{- fail (printf "Certificate (%s) has no <id> key" $cert.nameOverride) -}}
  {{- end -}}
  {{- $certID := (toString $cert.id) -}}

  {{- if (include "ix.v1.common.certificate.exists" (dict "root" $root "certID" $certID)) -}}
  {{/* Generate secret name here so we can pass it to persistence if needed */}}
  {{- $secretName := include "ix.v1.common.names.fullname" $root -}}
  {{- if $cert.nameOverride -}}
    {{- $secretName = (printf "%v-%v-%v-%v" $secretName $cert.nameOverride "ixcert" $certID) -}}
  {{- else -}}
    {{- $secretName = (printf "%v-%v-%v" $secretName "ixcert" $certID) -}}
  {{- end -}}
  {{- $secretName = (printf "%v-%v" $secretName $root.Release.Revision) -}}

  {{- if (hasKey $cert "certPath") -}}
    {{- if $cert.certPath -}}
      {{/* FIXME: Create Volume + Volume Mount of the secret to the certPath */}}
      {{/* Probably append to .Values.persistence? Also make sure to call this spawner before pod creation */}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $cert "keyPath") -}}
    {{- if $cert.keyPath -}}
      {{/* FIXME: Create Volume + Volume Mount of the secret to the certPath */}}
      {{/* Probably append to .Values.persistence? Also make sure to call this spawner before pod creation */}}
    {{- end -}}
  {{- end }}
---
apiVersion: {{ include "ix.v1.common.capabilities.secret.apiVersion" . }}
kind: Secret
type: kubernetes.io/tls
metadata:
  name: {{ $secretName }}
  {{- $labels := (default dict (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (default dict (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
data:
  tls.crt: {{ include "ix.v1.common.certificate.get" (dict "root" $root "cert" $cert "key" "certificate") | toString | b64enc | quote }}
  tls.key: {{ include "ix.v1.common.certificate.get" (dict "root" $root "cert" $cert "key" "privatekey") | toString | b64enc | quote }}
  {{- end -}}
{{- end -}}
