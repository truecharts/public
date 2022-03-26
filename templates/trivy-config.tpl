{{- if . -}}
#### Chart Object: {{ escapeXML ( index . 0 ).Target }}
    {{ range . }}

      {{ if (eq (len .Misconfigurations) 0) }}
| No Misconfigurations found         |
|:---------------------------------|

      {{ else }}
| Type         |    Misconfiguration ID   |   Check  |  Severity |                   Explaination                   | Links  |
|:----------------|:------------------:|:-----------:|:------------------:|-----------------------------------------|-----------------------------------------|
        {{- range .Misconfigurations }}
| {{ escapeXML .Type }}         |    {{ escapeXML .ID }}   |   {{ escapeXML .Title }}  |  {{ escapeXML .Severity }} | <details><summary>Expand...</summary> {{ escapeXML .Description }} <br> <hr> <br> {{ escapeXML .Message }} </details>| <details><summary>Expand...</summary>{{ range .References }}<a href={{ escapeXML . | printf "%q" }}>{{ escapeXML . }}</a><br>{{ end }}</details>  |
        {{- end }}
      {{- end }}
    {{- end }}
{{- else }}

| No Misconfigurations found         |
|:---------------------------------|
{{- end }}
