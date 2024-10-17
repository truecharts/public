---
sidebar:
  order: 2
title: Project Scope
---

TrueCharts is a comprehensive project that focuses on providing Helm charts for applications to run on Kubernetes-based platforms. This documentation article aims to describe the project's scope, highlighting its key principles and areas of focus.

## Overview

TrueCharts is committed to delivering high-quality Helm charts for Kubernetes-based applications. By leveraging the power of Helm, a popular package manager for Kubernetes, and adhering to native Kubernetes features, TrueCharts ensures compatibility, maintainability, and ease of use for its users.

### Key Principles

1. Native Kubernetes Features: TrueCharts places a strong emphasis on utilizing the native features and capabilities offered by Kubernetes. This approach ensures compatibility with the Kubernetes ecosystem and enables seamless integration with existing Helm-based Kubernetes workflows. By focussing on the power of Helm, TrueCharts provides charts that are familiar to Helm users and adheres to Helm and Kubernetes best practices.
2. Avoidance of Platform-Specific Features: The project prefers not to rely on platform-specific feature sets that are unique to specific Kubernetes distributions or platforms such TrueNAS SCALE (i.e using cert-manager certificates instead of built-in certificates on TrueNAS SCALE). By avoiding these platform-specific features, TrueCharts charts maintain a higher degree of portability and can be used across different Kubernetes environments without modification. Users can expect a consistent experience regardless of their chosen Kubernetes platform.
3. Holistic packaging of Helm Charts: Our charts aim to view application holistically, packing all parts (frontends, databases, tools) into a single helm chart. We also aim to ensure all our charts fit well within a single “truecharts ecosystem”. This means each chart will integrate everything and all the containers needed to run (better than a simple docker-compose) and will be ready for TrueCharts features such as ingress and certificate management from the get-go.

### Focus Areas

1. Helm Chart Development: TrueCharts focuses on developing high-quality Helm charts that encapsulate the deployment, configuration, and management of various Kubernetes applications. The charts are designed to simplify the deployment process and provide configurable options to meet the specific requirements of each application.
2. Standardized Tools: TrueCharts focuses on using standardized tools for Kubernetes, such as cert-manager, Traefik and integrating them for easy use across all our charts. This is accomplished using the Common Helm chart, for which we have extensive documention on our website so others can add their own charts to the catalog or modify as they see fit.
3. Compatibility and Community Engagement: TrueCharts strives to maintain compatibility with the latest versions of Helm and Kubernetes, ensuring that users can seamlessly upgrade their environments without issues. The project actively engages with the Kubernetes and Helm communities, contributing bug fixes, enhancements, and documentation. Community feedback and collaboration are vital for improving the project and ensuring its alignment with industry standards.
4. Avoidance of Writing Custom Containers: TrueCharts strives to minimize the creation of custom containers within its charts. Instead, it promotes the use of existing, well-maintained container images available from the official upstream sources or trusted community repositories. This approach ensures that users benefit from established image quality, security, and support. By leveraging existing containers, TrueCharts reduces the maintenance burden and encourages the use of best practices within the Kubernetes ecosystem.

### Limitations

1. Opinionated Charts: TrueCharts Helm Charts are carefully constructed to ensure the least amount of user-errors and often limit features to what we think our ecosystem really needs. Not every option each chart or application may have access to will be enable to the end-user.
2. Platform Support: TrueCharts builds its charts with certain tools and may not be able to support every distribution of Kubernetes or deployment pipeline, please check our website and/or support channels for supported platforms.

## Trains

TrueCharts contains multiple trains.
Each has it's own meaning and limitations for support.

### Stable Train Charts

We provide direct support for getting `stable` train charts working on our [discord](/s/discord) inside the **#support** channel.
That includes installation and guidance on getting it working with defaults or basic settings (not advanced customizations or remote smb shares, etc).
Bug reports aren't accepted on [discord](/s/discord) so if you spot a bug (Charts in the stable train should work with mostly defaults configuration)
please report them to our [github](https://github.com/truecharts/charts/issues/new/choose). Bug reports that state something doesn't work without supporting items may be closed.

### Incubator Train Charts

Our support policy for `incubator` train charts is different for those on the `stable` train. Those charts are work in progress,
may break at anytime and we're still going through many of the charts from unRAID. We won't accept support tickets for `incubator` train
charts on our [discord](/s/discord). However, we have an **#incubator-chat** channel for these apps to help get them running and/or receive feedback.
With enough positive feedback a chart can be promoted to `stable` train. Feedback about bugs is also accepted there which can be used to fix them.
Assume anything in the `incubator` train is in beta and you're testing it. As well, anything installed in `incubator` will have to be REINSTALLED once it moves to the `stable` train.

## Deployment Platform Support Policy

Please check the support policy of your specific platform to verify which versions of your platform are actually supported by TrueCharts

## Conclusion

TrueCharts is a project dedicated to delivering high-quality Helm charts for Kubernetes applications. By focusing on native Helm features, avoiding platform-specific functionality, and leveraging existing containers, TrueCharts provides users with reliable, portable, and user-friendly solutions. The projects commitment to compatibility, maintainability, and engagement with the Kubernetes community ensures a robust and valuable resource for Kubernetes developers and system.

For more information, please visit the TrueCharts website at https://truecharts.org or engage with the community through the provided communication channels.
