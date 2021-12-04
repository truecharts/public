{{- if . -}}
#### Chart Object: {{ escapeXML ( index . 0 ).Target }}
    {{ range . }}

      {{ if (eq (len .Misconfigurations) 0) }}
| No Misconfigurations found         |
|:---------------------------------|

      {{ else }}
| Type         |    Misconfiguration ID   |   Check  |  Severity | Explaination |                   Solution                   | Links  |
|:----------------|:------------------:|:-----------:|:------------------:|:-------------:|-----------------------------------------|-----------------------------------------|
        {{- range .Misconfigurations }}
| {{ escapeXML .Type }}         |    {{ escapeXML .ID }}   |   {{ escapeXML .Title }}  |  {{ escapeXML .Severity }} | {{ escapeXML .Description }} | {{ escapeXML .Message }} | <details><summary>Click to expand!</summary>{{ range .References }}<a href={{ escapeXML . | printf "%q" }}>{{ escapeXML . }}</a><br>{{ end }}</details>  |
        {{- end }}
      {{- end }}
    {{- end }}
{{- else }}

| No Misconfigurations found         |
|:---------------------------------|
{{- end }}
