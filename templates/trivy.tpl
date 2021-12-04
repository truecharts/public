{{- if . -}}
#### {{ escapeXML ( index . 0 ).Target }}
<link href="https://truecharts.org/_static/trivy.css" type="text/css" rel="stylesheet" />
<script>
  window.onload = function() {
    document.querySelectorAll('td.links').forEach(function(linkCell) {
      var links = [].concat.apply([], linkCell.querySelectorAll('a'));
      [].sort.apply(links, function(a, b) {
        return a.href > b.href ? 1 : -1;
      });
      links.forEach(function(link, idx) {
        if (links.length > 3 && 3 === idx) {
          var toggleLink = document.createElement('a');
          toggleLink.innerText = "Toggle more links";
          toggleLink.href = "#toggleMore";
          toggleLink.setAttribute("class", "toggle-more-links");
          linkCell.appendChild(toggleLink);
        }
        linkCell.appendChild(link);
      });
    });
    document.querySelectorAll('a.toggle-more-links').forEach(function(toggleLink) {
      toggleLink.onclick = function() {
        var expanded = toggleLink.parentElement.getAttribute("data-more-links");
        toggleLink.parentElement.setAttribute("data-more-links", "on" === expanded ? "off" : "on");
        return false;
      };
    });
  };
</script>
    {{ range . }}
**{{ escapeXML .Type }}**

      {{ if (eq (len .Vulnerabilities) 0) }}
| No Vulnerabilities found         |
|:---------------------------------|

      {{ else }}
| Package         |    Vulnerability   |   Severity  |  Installed Version | Fixed Version |                   Links                   |
|:----------------|:------------------:|:-----------:|:------------------:|:-------------:|-----------------------------------------|
        {{- range .Vulnerabilities }}
| {{ escapeXML .PkgName }}         |    {{ escapeXML .VulnerabilityID }}   |   {{ escapeXML .Vulnerability.Severity }}  |  {{ escapeXML .InstalledVersion }} | {{ escapeXML .FixedVersion }} | <p class="links" data-more-links="off">{{ range .Vulnerability.References }}<a href={{ escapeXML . | printf "%q" }}>{{ escapeXML . }}</a><br>{{ end }}</p>  |
        {{- end }}
      {{- end }}
    {{- end }}
{{- else }}
| No Vulnerabilities found         |
|:---------------------------------|
{{- end }}
