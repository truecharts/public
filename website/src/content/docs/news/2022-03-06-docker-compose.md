---
slug: "news/docker-compose"
title: "Docker-Compose on TrueNAS SCALE using TrueCharts"
authors: [ornias]
date: 2022-03-06
tags:
  - "2022"
---

From the early stages of TrueNAS SCALE development, we’ve read many complaints about the fact docker-compose wasn’t supported by TrueNAS SCALE. It’s understandable, as it’s one of the most used docker deployment options for home users.

The TrueNAS SCALE community has figured out interesting ways to enable Docker-Compose. But this approaches all have a number of downsides:

- It's not future proof, it can be nuked permanently and without warning, with any TrueNAS SCALE update.

- It inherently breaks SCALE Applications and often even requires those to be disabled.

- There is no support for this work-around.

To solve this problem, we’ve decided to take matters into our own hands. We are glad to finally announce our solution:

#### Docker-Compose Application for TrueNAS SCALE by TrueCharts

It’s designed from the ground up, to give users nearly the same experience as running Docker-Compose on the host system, and even contains some nice tweaks:

- It’s fully backed by TrueNAS SCALE Applications, so it will survive updates.

- There is a GUI option to input your Docker-Compose file, that will survive reboots.

- Completely self-contained, and will not modify the default docker stack.

- Fully compatible to run alongside other TrueNAS SCALE Applications, so you can easily migrate your Docker-Compose applications to TrueNAS SCALE Applications.

- We are your support if the application does not work as advertised.

All with just one caveat:

- The Docker-Compose command has to be executed from inside the container shell.

We based our solution on the official Docker-in-Docker container by Docker, with some added tooling to optimize it for single-container deployments. Perhaps most interestingly, the container has native access to `/mnt`, `/root` and `/cluster`, so you can work with your containers like you’re working on the host.

With this in place we hope that TrueNAS SCALE can finally start to fill the big shoes of solutions like Unraid and TrueNAS Core and give the community what they want, not just what they need!
