---
sidebar:
  order: 3
title: checkcrypt
---

:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

It's imperative that you always ensure the config you send to the internet is thoroughly encrypted. Using `clustertool checkcrypt` you can easily check if all files that are due to being encrypted, as specified in `.sops.yaml`, will actually be encrypted.

This tool can, for example, be used as a pre-commit check and will fail with a non-zero exit code if unencrypted files are detected that should've been encrypted in accordance with `.sops.yaml` configuration.
