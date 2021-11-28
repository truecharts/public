# Portal Button

After installation almost every app should have a "portal" button. This button is an easy and streamlined way of entering the Applications after installation. However, one should be aware that it does not magically follow changes inside the application (for example: from http to https).

##### questions.yaml example

Every questions.yaml file should contain the following snippets to enable the portal button. Please be aware to change `"http"` to `"https"` in services.main.port.protocol if your application uses http instead of https when running using "NodePort".

Also please be aware that the portal only(!) points towards the main service, main service port and main ingress.

```
portals:
  web_portal:
    protocols:
      - "$kubernetes-resource_configmap_portal_protocol"
    host:
      - "$kubernetes-resource_configmap_portal_host"
    ports:
      - "$kubernetes-resource_configmap_portal_port"
        path: "/"

questions:

  - variable: portal
    group: "Container Image"
    label: "Configure Portal Button"
    schema:
      type: dict
      hidden: true
      attrs:
        - variable: enabled
          label: "Enable"
          description: "enable the portal button"
          schema:
            hidden: true
            editable: false
            type: boolean
            default: true

```

There are also some additional (advanced) options availale, these can be added below the above required portion as required:

**host:**
```
        - variable: host
          label: "override Host when using NodePort"
          description: "Overrides the host setting when using NodePort. Example usecase would be loadbalanced NodePorts."
          schema:
            hidden: true
            editable: false
            type: string
            default: "test.com"
```
