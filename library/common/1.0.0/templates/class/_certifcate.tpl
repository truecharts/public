{{- define "ix.v1.common.class.certificate" -}}
  {{- $cert := .cert -}}
  {{- $root := .root -}}
  {{- $tlsCrtKey := "tls.crt" -}}
  {{- $tlsPrivateKey := "tls.key" -}}

  {{- if not (hasKey $cert "id") -}} {{/* This is something that should not happen when using this library */}}
    {{- fail (printf "Certificate (%s) has no <id> key" $cert.nameOverride) -}}
  {{- end -}} {{/* It can only happen when consuing this function within this library */}}
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

  {{- if (hasKey $cert "cert") -}}
    {{/* Create the dict */}}
    {{- $persistenceDict := (dict "enabled" true "type" "secret" "objectName" $secretName) -}}

    {{/* If cert is enabled */}}
    {{- if $cert.cert.enabled -}}
      {{/* And has a path... */}}
      {{- if $cert.cert.path -}}

        {{/* Append mountPath and subPath */}}
        {{- $_ := set $persistenceDict "mountPath" $cert.cert.path -}}
        {{- $_ := set $persistenceDict "subPath" $tlsCrtKey -}}

        {{/* Append readOnly if defined. Actual content validation will be done when volume(Mount) is created  */}}
        {{- if (hasKey $cert.cert "readOnly") -}}
          {{- $_ := set $persistenceDict "readOnly" $cert.cert.readOnly -}}
        {{- end -}}

        {{/* Append defaultMode. Actual content validation will be done when volume(Mount) is created */}}
        {{- if (hasKey $cert.cert "defaultMode") -}}
          {{- $_ := set $persistenceDict "defaultMode" $cert.cert.defaultMode -}}
        {{- end -}}

        {{/* Append into persistence, so it will create the volume and volumeMount. randAlhaNum is to avoid dupes */}}
        {{- $_ := set $root.Values.persistence (printf "ix-certificate-cert-%s-%s" $certID (randAlphaNum 5 | lower)) $persistenceDict -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $cert "key") -}}
    {{/* Create the dict */}}
    {{- $persistenceDict := (dict "enabled" true "type" "secret" "objectName" $secretName) -}}

    {{/* If key is enabled */}}
    {{- if $cert.key.enabled -}}
      {{/* And has a path... */}}
      {{- if $cert.key.path -}}

        {{/* Append mountPath and subPath */}}
        {{- $_ := set $persistenceDict "mountPath" $cert.key.path -}}
        {{- $_ := set $persistenceDict "subPath" $tlsPrivateKey -}}

        {{/* Append readOnly if defined. Actual content validation will be done when volume(Mount) is created */}}
        {{- if (hasKey $cert.key "readOnly") -}}
          {{- $_ := set $persistenceDict "readOnly" $cert.key.readOnly -}}
        {{- end -}}

        {{/* Append defaultMode if defined. Actual content validation will be done when volume(Mount) is created */}}
        {{- if (hasKey $cert.key "defaultMode") -}}
          {{- $_ := set $persistenceDict "defaultMode" $cert.key.defaultMode -}}
        {{- end -}}

        {{/* Append into persistence, so it will create the volume and volumeMount. randAlhaNum is to avoid dupes */}}
        {{- $_ := set $root.Values.persistence (printf "ix-certificate-key-%s-%s" $certID (randAlphaNum 5 | lower)) $persistenceDict -}}
      {{- end -}}
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
  {{ $tlsCrtKey }}: {{ include "ix.v1.common.certificate.get" (dict "root" $root "cert" $cert "key" "certificate") | toString | b64enc | quote }}
  {{ $tlsPrivateKey }}: {{ include "ix.v1.common.certificate.get" (dict "root" $root "cert" $cert "key" "privatekey") | toString | b64enc | quote }}
  {{- end -}}
{{- end -}}
