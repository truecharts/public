# Services

Every App needs to be exposed to something, either an UI, API or other containers.However with Kubernetes we don't directly connect to the containers running the App, because those might be on another node or there might be multiple "high available" containers for the App. Instead we use what is called `Services`. Services are simply put "Internal Load-Balancers", they also guaranteed to be reachable by (internal!) DNS name and (in some cases) prevent traffic from reaching your App when the healthcheck isn't finished yet (or is failing).

### Two kinds of services

##### Main Service

Every App is required to have a main service, the primary thing that users (or other Apps!) connect with. No mater if it's a webUI, an API, a database connection or something totally else, A service is always required.

Please keep in mind that every App is different, some just have one service (which *ALWAYS* has to be called `main`) and others need more (which each has to have an unique name). Every App also uses different ports, so please alter accordingly.

```
  - variable: service
    group: "Networking"
    label: "Configure Service(s)"
    schema:
      type: dict
      attrs:
        - variable: main
          label: "Main Service"
          description: "The Primary service on which the healthcheck runs, often the webUI"
          schema:
            type: dict
            attrs:
              - variable: enabled
                label: "Enable the service"
                schema:
                  type: boolean
                  default: true
                  hidden: true
              - variable: type
                label: "Service Type"
                description: "ClusterIP's are only internally available, nodePorts expose the container to the host node System, Loadbalancer exposes the service using the system loadbalancer"
                schema:
                  type: string
                  default: "NodePort"
                  enum:
                    - value: "NodePort"
                      description: "NodePort"
                    - value: "ClusterIP"
                      description: "ClusterIP"
                    - value: "LoadBalancer"
                      description: "LoadBalancer"
              - variable: loadBalancerIP
                label: "LoadBalancer IP"
                description: "LoadBalancerIP"
                schema:
                  show_if: [["type", "=", "LoadBalancer"]]
                  type: string
                  default: ""
                  required: true
              - variable: exetrnalIPs
                label: "External IP's"
                description: "External IP's"
                schema:
                  show_if: [["type", "=", "LoadBalancer"]]
                  type: list
                  default: []
                  items:
                    - variable: externalIP
                      label: "External IP"
                      required: true
                      schema:
                        type: string
              - variable: ports
                label: "Service's Port(s) Configuration"
                schema:
                  type: dict
                  attrs:
                    - variable: main
                      label: "Main Service Port Configuration"
                      schema:
                        type: dict
                        attrs:
                          - variable: enabled
                            label: "Enable the port"
                            schema:
                              type: boolean
                              default: true
                              hidden: true
                          - variable: protocol
                            label: "Port Type"
                            schema:
                              type: string
                              default: "HTTP"
                              hidden: false
                              enum:
                                - value: HTTP
                                  description: "HTTP"
                                - value: "HTTPS"
                                  description: "HTTPS"
                                - value: TCP
                                  description: "TCP"
                                - value: "UDP"
                                  description: "UDP"
                          - variable: port
                            label: "Container Port"
                            schema:
                              type: int
                              default: 5076
                              editable: false
                              hidden: true
                          - variable: targetport
                            label: "Target Port"
                            description: "This port exposes the container port on the service"
                            schema:
                              type: int
                              default: 5076
                              editable: true
                              hidden: false
                              required: true
                          - variable: nodePort
                            label: "Node Port (Optional)"
                            description: "This port gets exposed to the node. Only considered when service type is NodePort"
                            schema:
                              type: int
                              min: 9000
                              max: 65535
                              default: 36041
                              required: true
```
