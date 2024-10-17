---
slug: "news/helm-repo-back"
title: "Relaunched: Our Helm Repository"
authors: [ornias]
date: 2023-02-14
tags:
  - "2023"
---

We're is excited to announce that our native Helm Charts are back in action!

After disabling the release of our Helm Charts to our Helm Repository at the end of last year, we received numerous reports of users being impacted by the decision.

We understand the importance of our Helm Charts and how they help users manage their applications on k8s, so we took the time to rethink our approach and create separate pipelines for our SCALE Apps and native Helm Charts. This means that decisions regarding one of them will no longer impact the other.

While our primary target is still TrueNAS SCALE, we do accept enhancement requests and bug reports that only affect native Helm users. In the future, we hope to have a separate maintainer for native Helm-specific issues, but for now, please understand enhancements and bugs that do not affect TrueNAS SCALE are less of a priority unless very severe.

We are also excited to announce the release of our completely rebuilt common chart next month, which will come with state-of-the-art testing and templating. This will empower users, both within and outside of TrueNAS SCALE, to manage their applications with ease. Be sure to check it out when it's ready!

In conclusion, we are proud to bring back native Helm Charts to our users, and we hope that this will make managing applications on k8s a seamless and enjoyable experience for all.

Check out the Helm Repository over at: https://charts.truecharts.org
