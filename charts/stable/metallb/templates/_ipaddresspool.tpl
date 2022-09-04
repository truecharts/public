{{- define "metallb.ipAddressPool" -}}
{{- if .Values.metallb.ipAddressPools }}
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: {{ .Release.Name }}
  namespace: {{ .Release.Namespace }}
spec:
  addresses:
{{- range .Values.metallb.ipAddressPools.addresses }}
    - {{ . }}
{{- end }}
  autoAssign: {{ .Values.metallb.ipAddressPools.autoAssign | default true }}
  avoidBuggyIPs: {{ .Values.metallb.ipAddressPools.avoidBuggyIPs | default false }}
{{- end }}
{{- end -}}
