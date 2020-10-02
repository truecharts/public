{{- range $index, $iface := .Values.externalInterfacesConfiguration }}
---
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: ix-{{ $.Release.Name }}-{{ $index }}
spec:
  config: '{{ $iface }}'
{{- end }}
