---
title: Ingress
---

Ingress is what we call "Reverse Proxy" in the UI and in the user side of the documentation. Please be aware that those refer to the same system. An Ingress is, simply put, just Kubernetes way of connecting outsides to Apps running in containers.

## Ingress Types

We currently support:

- HTTP via Ingres
- HTTP via Traefik IngressRoute (HTTP-IR)
- TCP via Traefik IngressRouteTCP
- UDP via Traefik IngressRouteUDP

From questions.yaml and the UI, these can be changed with selecting another "Type". However: Under the hood IngressRoutes and Ingress are totally different beasts and have a separate creation process. Errors for Plain HTTP do NOT have to be present in HTTP-IR.

It's also important to note that TCP (and even more so: UDP) have less options available. The example configurations below contain a mostly complete overview of what is currently available and reasonable.

### Ingress and Services

It's important to know what Ingress does, before you start creating ingresses in questions.yaml. Ingresses send outside Traffic, to a kubernetes Service, which in turn forwards traffic to the actual containers.

This means that every container needs to know how to reach their Service. If they do not, things go wrong.

To ensure this, it's advised to keep the names of your Ingresses the same as the names of your services. We made sure the ingress would automatically detect (and connect to) the main port of a Service with the same name.

However: In case you need to do this differently, need to connect to additionalServices and/or need to connect to a secondary port, you can manually set both the serviceName and servicePort in questions.yaml. We advice however, to only do so if absolutely necessary!

### The Main Ingress

The main Ingress and Main service take an important role in our standardization. Where the main Service is used for healthchecks.

However: As the maintainers expect new features to be connecting to the main service and main ingress, it will cause problems if you decide to bypass/ignore these.

### Standards/Examples

We try to maintain as much of a standardized questions.yaml format as possible, to ensure (bulk) editing stays as easy as possible.
