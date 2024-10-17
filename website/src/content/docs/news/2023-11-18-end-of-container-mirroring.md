---
slug: "news/the-end-of-container-mirroring"
title: "The End of Container Mirroring"
authors: [jagrbombs]
date: 2023-11-18
tags:
  - "2023"
---

In the ever-evolving landscape of containerization and application deployment, TrueCharts has been at the forefront of providing users with streamlined and efficient Helm charts. As TrueCharts continues to prioritize user experience and development efficiency, a notable change is on the horizon – the decision to discontinue mirroring containers. We've highlighted below the main reasons for this change.

- **Focusing Dev Time on Innovation**:
  TrueCharts has always been committed to delivering high-quality Helm charts that simplify the deployment of applications on Kubernetes. By discontinuing container mirroring, the development team can now redirect their efforts and time towards enhancing existing charts, introducing new features, and ensuring the overall improvement of the TrueCharts ecosystem. This shift in focus aims to bring users an even more polished and feature-rich experience.

- **Enhanced Clarity for Chart Users**:
  The decision to cease container mirroring brings increased transparency for TrueCharts users. With a clear distinction between containers provided by TrueCharts and those hosted elsewhere, users can easily identify which containers are in use within their deployments. This added clarity fosters a better understanding of the components powering their applications and promotes a more informed and empowered user community.

- **Faster and More Efficient Processing**:
  Our current automated testing, takes a lot of processing time. Part of this is separated testing and releasing of the the container mirror. By removing the container mirror, we can lower the amount of tests run separately by 20%, significantly increasing the speed at which we can follow upstream releases of new versions.

## As well, we would like to highlight these two important aspects of this transition below

- **DockerHub Rate Limits**:
  In a world where some container registries are subject to rate limits, this change does mean users might hit rate-limits when pulling certain containers. Especially those from dockerhub. If this is the case, please contact the container creator and request they use a different container registry.

- **Gradual Transition for Current Users:**
  Change can be daunting, especially for existing users accustomed to a certain workflow. Therefore, the discontinuation of container mirroring will not impact current users for at least a year. During this transition period, users can continue to benefit from mirrored images while TrueCharts prepares them for the upcoming change through clear communication and support.

- **Seamless and Non-Breaking Change:**
  TrueCharts is committed to making this transition as seamless as possible. Users can expect a non-disruptive experience, with no breaking changes to their current deployments. TrueCharts will provide comprehensive support to guide users through the transition, ensuring that the shift away from mirroring is a smooth and hassle-free process.

## Conclusion

As TrueCharts takes this strategic step towards discontinuing container mirroring, the focus remains on user experience, transparency, and efficient development. By embracing this change, TrueCharts aims to provide users with an even more robust platform for deploying applications on Kubernetes. As the containerization landscape continues to evolve, TrueCharts remains dedicated to simplifying the deployment process and empowering users with the tools they need for success.
