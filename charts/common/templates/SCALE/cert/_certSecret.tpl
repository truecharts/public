{{- define "tc.common.scale.cert.secret" -}}

{{- $secretName := include "tc.common.names.fullname" . -}}

{{- if .ObjectValues.certHolder -}}
  {{- if hasKey .ObjectValues.certHolder "nameOverride" -}}
    {{- $secretName = ( printf "%v-%v-%v-%v" $secretName .ObjectValues.certHolder.nameOverride "ixcert" .ObjectValues.certHolder.scaleCert ) -}}
  {{- else }}
    {{- $secretName = ( printf "%v-%v-%v" $secretName "ixcert" .ObjectValues.certHolder.scaleCert ) -}}
  {{ end -}}
{{ else }}
  {{- $_ := set $ "ObjectValues" (dict "certHolder" .Values) -}}
  {{- $secretName = ( printf "%v-%v-%v-%v" $secretName "scalecert" "ixcert" .Values.scaleCert ) -}}
{{ end -}}

{{- if eq (include "tc.common.scale.cert.available" $ ) "true" -}}


{{- printf "\n%s\n" "---" }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}-{{ .Release.Revision }}
  labels: {{ include "tc.common.labels" . | nindent 4 }}
type: kubernetes.io/tls
data:
  tls.crt: {{ (include "tc.common.scale.cert.publicKey" $ ) | toString | b64enc | quote }}
  tls.key: {{ (include "tc.common.scale.cert.privateKey" $ ) | toString | b64enc | quote }}
{{- end -}}
{{- end -}}
