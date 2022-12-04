{{- define "briefkasten.createdb" -}}
commands:
  - |
    pnpm start &
    echo "Waiting 20s for app to start..."
    sleep 20
    echo "Executing DB Seed..."
    pnpm db:push
    echo "...Done"
    echo "Exiting... App will restart..."
    exit 0
{{- end -}}
