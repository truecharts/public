{{/* Define the job */}}

{{- define "ipfs.job" -}}
{{- $jobName := include "common.names.fullname" . }}

---
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ printf "%s-job" $jobName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
spec:
  template:
    backoffLimit: 2
    completions: 1
        spec:
          restartPolicy: Never
          {{- with (include "common.controller.volumes" . | trim) }}
          volumes:
            {{- nindent 12 . }}
          {{- end }}
          containers:
            - name: {{ .Chart.Name }}
              image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
              env:
                - name: NODE_IP
                  value: {{ .Values.env.NODE_IP }}
                  value: {{ .Values.clamav.extra_args }}
              command: ["sh", "-c"]
              args:
                - >
                  echo "Setting API.HTTPHeaders.Access-Control-Allow-Methods to [\"PUT\", \"POST\"]...";
                  ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]';
                  echo "Setting API.HTTPHeaders.Access-Control-Allow-Origin [\"http://${NODE_IP}:5001\", \"http://localhost:3000\", \"http://127.0.0.1:5001\"]...";
                  ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://${NODE_IP}:5001", "http://localhost:3000", "http://127.0.0.1:5001"]';
                  echo "Done!";
                  exit 0;
              {{- with (include "common.controller.volumeMounts" . | trim) }}
              volumeMounts:
                {{ nindent 16 . }}
              {{- end }}
              resources:
{{ toYaml .Values.resources | indent 16 }}
{{- end -}}
