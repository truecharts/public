# Services

Every App needs to be exposed to something, either an UI, API or other containers.However with Kubernetes we don't directly connect to the containers running the App, because those might be on another node or there might be multiple "high available" containers for the App. Instead we use what is called `Services`. Services are simply put "Internal Load-Balancers", they also guaranteed to be reachable by (internal!) DNS name and (in some cases) prevent traffic from reaching your App when the healthcheck isn't finished yet (or is failing).

### Two kinds of services

##### Main Service

Every App is required to have a main service, the primary thing that users (or other Apps!) connect with. No mater if it's a webUI, an API, a database connection or something totally else, A service is always required.

Please keep in mind that every App is different, some just have one service (which *ALWAYS* has to be called `main`) and others need more (which each has to have an unique name). Every App also uses different ports, so please alter accordingly.

```
  - variable: services
    group: "Networking"
    label: "Configure Service"
    schema:
      type: dict
      attrs:
        - variable: main
          label: "Main service"
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
                label: "Service type"
                description: "ClusterIP's are only internally available, nodePorts expose the container to the host node System"
                schema:
                  type: string
                  default: "ClusterIP"
                  enum:
                    - value: "nodePort"
                      description: "NodePort"
                    - value: "ClusterIP"
                      description: "ClusterIP"
              - variable: port
                label: "Port configuration"
                schema:
                  type: dict
                  attrs:
                    - variable: protocol
                      label: "Port Type"
                      schema:
                        type: string
                        default: "TCP"
                        hidden: true
                        enum:
                          - value: TCP
                            description: "TCP"
                          - value: "UDP"
                            description: "UDP"
                    - variable: port
                      label: "container port"
                      schema:
                        type: int
                        default: 80
                        editable: false
                        hidden: true
                    - variable: targetport
                      label: "Internal Service port"
                      description: "When connecting internally to this App, you'll need this port"
                      schema:
                        type: int
                        default: 80
                        editable: true
                    - variable: nodePort
                      label: "(optional) host nodePort to expose to"
                      description: "only get used when nodePort is selected"
                      schema:
                        type: int
                        min: 9000
                        max: 65535
                        default: 36052
                        required: true
```

##### Unlimited custom services

in some edgecases users might need or want to have the option to add unlimited custom Services. While we _highly_ suggest not doing so, these services can be added with the following standardised template:

```
  - variable: additionalServices
    label: "Custom Services"
    group: "Networking"
    schema:
      type: list
      default: []
      items:
        - variable: additionalService
          label: "Custom Service"
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
                label: "Service type"
                description: "ClusterIP's are only internally available, nodePorts expose the container to the host node System"
                schema:
                  type: string
                  default: "ClusterIP"
                  enum:
                    - value: "nodePort"
                      description: "NodePort"
                    - value: "ClusterIP"
                      description: "ClusterIP"
              - variable: port
                label: "Port configuration"
                schema:
                  type: dict
                  attrs:
                    - variable: port
                      label: "container port"
                      schema:
                        type: int
                        default: 80
                        editable: false
                        hidden: true
                    - variable: targetport
                      label: "Internal Service port"
                      description: "When connecting internally to this App, you'll need this port"
                      schema:
                        type: int
                        default: 80
                        editable: true
                    - variable: nodePort
                      label: "(optional) host nodePort to expose to"
                      description: "only get used when nodePort is selected"
                      schema:
                        type: int
                        min: 9000
                        max: 65535
                        default: 36052
                        required: true

```
