---
title: Adding Service
---

## What is a service?

Services are all sorts of ports that you want to add to your chart.

## How to Setup

To setup a service, add the following section to the values.yaml manually and adapt as needed. You can also add multiple ports to a single service.

The type can be both `Loadbalancer` and `ClusterIP` depending on your needs.

```yaml
service:
  myservice:
    enabled: true
    # only needed for loadBalancer
    loadBalancerIP: "192.168.178.11"
    type: "LoadBalancer"
    # integration needed to assign the specific loadBalancerIP via metallb
    integrations:
      metallb:
        enabled: true
    ports:
      web:
        enabled: true
        port: 8080
        targetPort: 80
        # http is set by default so can be skipped
        # protocol: http
      api:
        enabled: true
        port: 9090
        targetPort: 90
        protocol: tcp
```

In most charts there are already predefined services. You can change them to your needs (e.g. Loadbalancer/ClusterIP) as well as adding additional ones. Just make sure to choose a unique name.

### Service requirements

Please be aware that most apps already have a primary service named `main` and at least 1 primary is required.
It's also important to note that all services added by the end user should set `enabled` on all ports and services to `true`.

### Service intergrations

For each service you can add a specific integration. Metallb, Cilium or Traefik can be choosen.
In above example metallb integration is used, to get the correct metallb annotation for the ip assignment.

Integrations can be enabled as follow:

**Metallb**
```yaml
service:
  myservice:
    integration:
      metallb:
        enabled: true
          sharedKey: ""  ## Optional to set shared key manually, otherwise it is set to $namespace as standard
```

**Cilium**
```yaml
service:
  myservice:
    integration:
      cilium:
        enabled: true
          sharedKey: ""  ## Optional to set shared key manually, otherwise ignored (namespace sharing)
```

**Treafik**
```yaml
service:
  myservice:
    integration:
     traefik:
      enabled: true
```

## More info

For more info, check out the common-chart [service options](/common/service/)
