---
title: Services
---

Every App needs to be exposed to something, either an UI, API or other containers.However with Kubernetes we don't directly connect to the containers running the App, because those might be on another node or there might be multiple "high available" containers for the App. Instead we use what is called `Services`. Services are simply put "Internal Load-Balancers", they also guaranteed to be reachable by (internal!) DNS name and (in some cases) prevent traffic from reaching your App when the healthcheck isn't finished yet (or is failing).

## Two kinds of services

### Main Service

Every App **must** have a `main` service, the primary connection for users or other apps, whether it's a webUI, an API, a database connection or something else. Keep in mind that every App is unique, some may have one service called `main`, while others may need multiple services with **distinct** names. Also, every App uses different ports, so make sure to alter accordingly.
