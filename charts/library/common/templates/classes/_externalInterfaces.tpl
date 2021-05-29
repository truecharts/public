{{/*
This template serves as a blueprint for External Interface objects that are created
using the SCALE GUI.
*/}}
{{- define "common.classes.externalInterfaces" -}}
{{- range $index, $iface := .Values.ixExternalInterfacesConfiguration  }}
---
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: ix-{{ $.Release.Name }}-{{ $index }}
spec:
  config: '{{ $iface }}'
{{- end }}
{{- end -}}
