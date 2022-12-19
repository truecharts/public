{{- define "ix.v1.common.certificate.persistence" -}}
  {{- $secretName := .secretName -}}
  {{- $root := .root -}}
  {{- $tlsKey := .tlsKey -}}
  {{- $type := .type -}}
  {{- $cert := .cert -}}
  {{- $certID := .certID -}}

  {{/* Create the dict */}}
  {{- $persistenceDict := (dict "enabled" true "type" "secret" "objectName" $secretName) -}}

  {{- $currCert := (get $cert $type) -}}
  {{- if $currCert -}}
    {{/* If cert is enabled */}}
    {{- if $currCert.enabled -}}
      {{/* And has a path... */}}
      {{- if $currCert.path -}}
        {{/* Append mountPath and subPath */}}
        {{- $_ := set $persistenceDict "mountPath" (tpl $currCert.path $root) -}}
        {{- $_ := set $persistenceDict "subPath" $tlsKey -}}

        {{/* Append readOnly if defined. Actual content validation will be done when volume(Mount) is created  */}}
        {{- if (hasKey $currCert "readOnly") -}}
          {{- $_ := set $persistenceDict "readOnly" $currCert.readOnly -}}
        {{- end -}}

        {{/* Append defaultMode. Actual content validation will be done when volume(Mount) is created */}}
        {{- if (hasKey $currCert "defaultMode") -}}
          {{- $_ := set $persistenceDict "defaultMode" $currCert.defaultMode -}}
        {{- end -}}

        {{/* Append into persistence, so it will create the volume and volumeMount. randAlhaNum is to avoid dupes */}}
        {{- $_ := set $root.Values.persistence (printf "ix-certificate-%s-%s-%s" $type $certID (randAlphaNum 5 | lower)) $persistenceDict -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
