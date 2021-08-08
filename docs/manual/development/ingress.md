# Ingress

Ingress is what we call "Reverse Proxy" in the UI and in the user side of the documentation. Please be aware that those refer to the same system. An Ingress is, simply put, just Kubernetes way of connecting outsides to Apps running in containers.

### Ingress Types

We currently support:
- HTTP via Ingres
- HTTP via Traefik IngressRoute (HTTP-IR)
- TCP via Traefik IngressRouteTCP
- UDP via Traefik IngressRouteUDP

From questions.yaml and the UI, these can be changed with selecting another "Type". However: Under the hood IngressRoutes and Ingress are totally different beasts and have a seperate creation process. Errors for Plain HTTP  do NOT have to be present in HTTP-IR.

It's also important to note that TCP (and even more so: UDP) have less options available. The example configurations below contain a mostly complete overview of what is currently available and reasonable.

##### Ingress and Services

It's important to know what Ingress does, before you start creating ingresses in questions.yaml. Ingresses send outside Traffic, to a kubernetes Service, which in turn forwards traffic to the actual containers.

This means that every container needs to know how to reach their Service. If they do not, things go wrong.

To ensure this, it's adviced to keep the names of your Ingresses the same as the names of your services. We made sure the ingress would automatically detect (and connect to) the main port of a Service with the same name.

However: In case you need to do this differently, need to connect to additionalServices and/or need to connect to a secondary port, you can manually set both the serviceName and servicePort in questions.yaml. We advice however, to only do so if absolutely necessary!

##### The Main Ingress

The main Ingress and Main service take an important role in our standardisation. Where the main Service is used for healthchecks and the "portal" button, the main Ingress is just used for the portal button.

However: As the maintainers expect new features to be connecting to the main service and main ingress, it will cause problems if you decide to bypass/ignore these.

### Standards/Examples

We try to maintain as much of a standardised questions.yaml format as possible, to ensure (bulk) editing stays as easy as possible.

##### HTTP Ingress

```
  - variable: ingress
    label: "Ingress Configuration"
    group: "Ingress Configuration"
    schema:
      type: dict
      attrs:
        - variable: main
          label: "Main Ingress"
          schema:
            type: dict
            attrs:
              - variable: enabled
                label: "Enable Ingress"
                schema:
                  type: boolean
                  default: false
                  show_subquestions_if: true
                  subquestions:
                    - variable: hosts
                      label: "Hosts"
                      schema:
                        type: list
                        default: []
                        items:
                          - variable: host
                            label: "Host"
                            schema:
                              type: dict
                              attrs:
                                - variable: host
                                  label: "HostName"
                                  schema:
                                    type: string
                                    default: ""
                                    required: true
                                - variable: paths
                                  label: "Hosts"
                                  schema:
                                    type: list
                                    default: []
                                    items:
                                      - variable: path
                                        label: "path"
                                        schema:
                                          type: string
                                          required: true
                                          hidden: false
                                          default: "/"
                                      - variable: pathType
                                        label: "pathType"
                                        schema:
                                          type: string
                                          required: true
                                          hidden: false
                                          default: "Prefix"
                    - variable: tls
                      label: "TLS-Settings"
                      schema:
                        type: list
                        default: []
                        items:
                          - variable: hosts
                            label: "Certificate Hosts"
                            schema:
                              type: list
                              default: []
                              items:
                                - variable: host
                                  label: "Host"
                                  schema:
                                    type: string
                                    default: ""
                                    required: true
                          - variable: scaleCERT
                            label: "Select TrueNAS SCALE Certificate"
                            schema:
                              type: int
                              $ref:
                                - "definitions/certificate"

```

##### TCP Ingress

```
        - variable: tcp
          label: "TCP Reverse Proxy Configuration"
          schema:
            type: dict
            attrs:
              - variable: enabled
                label: "Enable TCP Reverse Proxy"
                schema:
                  type: boolean
                  default: false
                  show_subquestions_if: true
                  subquestions:
                    - variable: type
                      label: "Select Reverse Proxy Type"
                      schema:
                        type: string
                        default: "TCP"
                        required: true
                        editable: false
                        hidden: true
                    - variable: serviceName
                      label: "Service name to proxy to"
                      schema:
                        hidden: true
                        editable: false
                        type: string
                        default: ""
                    - variable: entrypoint
                      label: "Select Entrypoint"
                      schema:
                        type: string
                        default: "torrent-tcp"
                        required: true
                        enum:
                          - value: "torrent-tcp"
                            description: "Torrent-TCP: port 51413"
```

##### UDP Ingress

```
        - variable: udp
          label: "UDP Reverse Proxy Configuration"
          schema:
            type: dict
            attrs:
              - variable: enabled
                label: "Enable UDP Reverse Proxy"
                schema:
                  type: boolean
                  default: false
                  show_subquestions_if: true
                  subquestions:
                    - variable: type
                      label: "Select Reverse Proxy Type"
                      schema:
                        type: string
                        default: "UDP"
                        required: true
                        editable: false
                        hidden: true
                    - variable: serviceName
                      label: "Service name to proxy to"
                      schema:
                        hidden: true
                        editable: false
                        type: string
                        default: ""
                    - variable: entrypoint
                      label: "Select Entrypoint"
                      schema:
                        type: string
                        default: "torrent-udp"
                        required: true
                        enum:
                          - value: "torrent-udp"
                            description: "Torrent-UDP: port 51413"
```

### Other Ingress options

There are a few other options that are rarely (if ever) used.

##### servicePort

```
                     - variable: servicePort
                       label: "Service Port to proxy to"
                       schema:
                         hidden: true
                         editable: false
                         type: int
                         default: 80
```


##### serviceKind

```
                    - variable: serviceKind
                      label: "Service Kind to proxy to"
                      schema:
                        hidden: true
                        editable: false
                        type: string
                        default: ""
```


### External Services

The externalServices option, is actually mostly an Ingress "under the hood" which just creates a very small (minimal) service.

```
  - variable: externalServices
    label: "(Advanced) Add External Services"
    group: "Advanced"
    schema:
      type: list
      default: []
      items:
        - variable: externalService
          label: "External Service"
          schema:
            type: dict
            attrs:
              - variable: enabled
                label: "Enable Web Reverse Proxy"
                schema:
                  type: boolean
                  hidden: true
                  editable: false
                  default: true
              - variable: type
                label: "Reverse Proxy Type"
                schema:
                  type: string
                  default: "HTTP"
                  hidden: true
                  editable: false
                  required: true
              - variable: serviceName
                label: "Service name to proxy to"
                schema:
                  hidden: true
                  editable: false
                  type: string
                  default: ""
              - variable: serviceTarget
                label: "IP Adress of the external service"
                schema:
                  hidden: false
                  editable: true
                  required: true
                  type: string
                  default: "192.168.0.0"
              - variable: servicePort
                label: "External Service Port"
                description: "The port on the external service you want to proxy"
                schema:
                  hidden: false
                  required: true
                  editable: true
                  type: int
                  default: 80
              - variable: serviceType
                label: "Connection Type"
                description: "Connection Type between Traefik and the external service"
                schema:
                  hidden: false
                  editable: true
                  required: true
                  default: "HTTP"
                  type: string
                  enum:
                    - value: "HTTP"
                      description: "HTTP"
                    - value: "HTTPS"
                      description: "HTTPS"
              - variable: serviceKind
                label: "Service Kind to proxy to"
                schema:
                  hidden: true
                  editable: false
                  type: string
                  default: ""
              - variable: entrypoint
                label: "Select Entrypoint"
                schema:
                  type: string
                  default: "websecure"
                  required: true
                  enum:
                    - value: "websecure"
                      description: "Websecure: HTTPS/TLS port 443"
              - variable: host
                label: "Domain Name"
                required: true
                schema:
                  type: string
              - variable: path
                label: "path"
                schema:
                  type: string
                  required: true
                  hidden: false
                  default: "/"
              - variable: certType
                label: "Select Certificate Type"
                schema:
                  type: string
                  default: "selfsigned"
                  enum:
                    - value: ""
                      description: "No Encryption/TLS/Certificates"
                    - value: "selfsigned"
                      description: "Self-Signed Certificate"
                    - value: "ixcert"
                      description: "TrueNAS SCALE Certificate"
              - variable: certificate
                label: "Select TrueNAS SCALE Certificate"
                schema:
                  type: int
                  show_if: [["certType", "=", "ixcert"]]
                  $ref:
                    - "definitions/certificate"
              - variable: authForwardURL
                label: "Forward Authentication URL"
                schema:
                  type: string
                  default: ""
```
