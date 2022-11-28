{{- define "briefkasten.createdb" -}}
postStart:
  exec:
    command:
      - /bin/bash
      - -c
      - |
        pnpm db:push
{{- end -}}
